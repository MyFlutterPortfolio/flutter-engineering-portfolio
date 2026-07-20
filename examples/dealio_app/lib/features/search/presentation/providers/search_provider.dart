import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/network/failures.dart';
import 'package:untitled5/features/search/data/repositories/search_repository_impl.dart';
import 'package:untitled5/features/search/data/datasources/search_remote_datasource.dart';
import 'package:untitled5/features/search/domain/repositories/search_repository.dart';

import 'search_state.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SearchRepositoryImpl(SearchRemoteDataSource(apiClient));
});

final searchNotifierProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
      final repository = ref.watch(searchRepositoryProvider);
      return SearchNotifier(repository);
    });

class StoreLookupParams {
  final String countryCode;
  final String query;
  final int limit;

  const StoreLookupParams({
    required this.countryCode,
    this.query = '',
    this.limit = 20,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StoreLookupParams &&
        other.countryCode.trim().toUpperCase() ==
            countryCode.trim().toUpperCase() &&
        other.query.trim().toLowerCase() == query.trim().toLowerCase() &&
        other.limit == limit;
  }

  @override
  int get hashCode => Object.hash(
    countryCode.trim().toUpperCase(),
    query.trim().toLowerCase(),
    limit,
  );
}

final availableStoresProvider = FutureProvider.autoDispose
    .family<List<Store>, StoreLookupParams>((ref, params) async {
      final countryCode = params.countryCode.trim().toUpperCase();
      if (countryCode.isEmpty) return [];
      final query = params.query.trim();
      final safeLimit = params.limit < 1
          ? 1
          : (params.limit > 100 ? 100 : params.limit);
      final repository = ref.watch(searchRepositoryProvider);
      return repository.getStores(
        countryCode,
        q: query.isEmpty ? null : query,
        limit: safeLimit,
      );
    });

class SearchNotifier extends StateNotifier<SearchState> {
  static const int _maxCacheEntries = 12;
  static const Duration _cacheTtl = Duration(minutes: 10);

  final SearchRepository _repository;
  Timer? _pollingTimer;
  CancelToken? _cancelToken;
  DateTime? _lastSearchRequestTime;
  SearchRequest? _lastRequestParams;
  int _operationVersion = 0;

  final Map<String, _CacheEntry> _cache = {};

  SearchNotifier(this._repository) : super(const SearchState());

  String _generateCacheKey(SearchRequest request) {
    final stores =
        [...?request.selectedStores]
            .map((item) => item.trim().toLowerCase())
            .where((item) => item.isNotEmpty)
            .toSet()
            .toList()
          ..sort();
    final query = request.query.trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
    final notes = request.notes?.trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
    return [
      query,
      request.country.trim().toUpperCase(),
      request.language.trim().toLowerCase(),
      request.storeScope.trim().toLowerCase(),
      notes ?? '',
      stores.join(','),
    ].join('|');
  }

  bool _isDuplicateRequest(SearchRequest request) {
    if (_lastRequestParams == null || _lastSearchRequestTime == null) {
      return false;
    }

    final isSameRequest =
        _generateCacheKey(request) == _generateCacheKey(_lastRequestParams!);
    final isRecent =
        DateTime.now().difference(_lastSearchRequestTime!) <
        const Duration(seconds: 2);

    return isSameRequest && isRecent;
  }

  Future<void> search(SearchRequest request) async {
    if (_isDuplicateRequest(request)) return;
    final operation = ++_operationVersion;

    _lastSearchRequestTime = DateTime.now();
    _lastRequestParams = request;

    final cacheKey = _generateCacheKey(request);

    final cachedResponse = _readCachedResponse(cacheKey);
    if (cachedResponse != null) {
      state = state.copyWith(
        status: SearchStatus.stage3Ready,
        results: cachedResponse.results,
        storeOffers: cachedResponse.storeOffers,
        requestId: cachedResponse.requestId,
        aiSummaryRequestId: cachedResponse.aiSummaryRequestId,
        lastRequest: request,
        plan: cachedResponse.plan,
        quota: cachedResponse.quota,
        searchProvider: cachedResponse.searchProvider,
        errorMessage: null,
      );
      return;
    }

    _cancelToken?.cancel();
    _pollingTimer?.cancel();
    _cancelToken = CancelToken();

    state = state.copyWith(
      status: SearchStatus.loadingStage1,
      errorMessage: null,
      lastRequest: request,
      results: [],
      storeOffers: [],
      stage2Error: false,
      stage3Error: false,
      requestId: null,
      aiSummaryRequestId: null,
    );

    try {
      await _executeSearchRequest(request, operation);
    } catch (e) {
      if (e is DioException && CancelToken.isCancel(e)) return;

      if (e is DioException &&
          request.storeScope == 'selected' &&
          _shouldFallbackToGlobal(e)) {
        final fallbackRequest = request.copyWith(
          storeScope: 'global',
          selectedStores: null,
        );

        try {
          await _executeSearchRequest(fallbackRequest, operation);
          if (!_isCurrent(operation)) return;
          state = state.copyWith(
            errorMessage:
                'Selected-store filter is temporarily unavailable. Showing global results.',
          );
          return;
        } catch (fallbackError) {
          if (fallbackError is DioException &&
              CancelToken.isCancel(fallbackError)) {
            return;
          }
          if (_isCurrent(operation)) _handleError(fallbackError);
          return;
        }
      }

      if (_isCurrent(operation)) _handleError(e);
    }
  }

  Future<void> _executeSearchRequest(
    SearchRequest request,
    int operation,
  ) async {
    final response = await _repository.search(
      request,
      cancelToken: _cancelToken,
    );

    if (!_isCurrent(operation)) return;

    state = state.copyWith(
      status: SearchStatus.stage1Ready,
      results: response.results,
      storeOffers: response.storeOffers,
      requestId: response.requestId,
      aiSummaryRequestId: response.aiSummaryRequestId,
      plan: response.plan,
      quota: response.quota,
      searchProvider: response.searchProvider,
      stage1Source: response.stage1Source ?? '',
    );

    if (response.requestId != null) {
      _startProgressivePolling(response.requestId!, operation);
    } else {
      state = state.copyWith(status: SearchStatus.stage3Ready);
    }
  }

  bool _shouldFallbackToGlobal(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    final code = data is Map ? data['code']?.toString() : null;

    if (status == 400 && code == 'SELECTED_STORES_REQUIRED') {
      return true;
    }
    if (status == 403 && code == 'PLAN_FEATURE_REQUIRED') {
      return true;
    }
    return false;
  }

  void _handleError(dynamic e) {
    final mappedError = _toUserFriendlyMessage(AppErrorMapper.map(e));

    if (e is DioException) {
      final appEx = AppException.fromDio(e);
      if (appEx.code == AppErrorCode.MONTHLY_SEARCH_LIMIT_REACHED) {
        QuotaInfo? quotaInfo = state.quota;
        final details = appEx.details;
        if (details != null) {
          try {
            if (details.containsKey('search')) {
              quotaInfo = QuotaInfo.fromJson(details);
            } else {
              final used = (details['used'] as num?)?.toInt() ?? 0;
              final limit = (details['limit'] as num?)?.toInt() ?? 0;
              final remaining = (details['remaining'] as num?)?.toInt() ?? 0;
              final resetAt = details['resetAt']?.toString() ?? '';
              final allowed = details['allowed'] == true;
              quotaInfo = QuotaInfo(
                search: SearchQuota(
                  used: used,
                  limit: limit <= 0 ? 1 : limit,
                  remaining: remaining < 0 ? 0 : remaining,
                  resetAt: resetAt,
                  allowed: allowed,
                ),
              );
            }
          } catch (_) {}
        }

        state = state.copyWith(
          status: SearchStatus.quotaExceeded,
          errorMessage: appEx.message,
          quota: quotaInfo,
        );
        return;
      }

      if (e.response?.statusCode == 403) {
        state = state.copyWith(
          status: SearchStatus.error,
          errorMessage: 'Plan restriction: Upgrade to access this feature.',
        );
        return;
      }
    }

    final shouldUseLocalizedFallback =
        mappedError == kGenericUserErrorMessage ||
        mappedError == kSearchUnavailableMessage;

    state = state.copyWith(
      status: SearchStatus.error,
      errorMessage: shouldUseLocalizedFallback ? null : mappedError,
    );
  }

  String _toUserFriendlyMessage(String rawMessage) {
    final message = rawMessage.trim();
    if (message.isEmpty) return kSearchUnavailableMessage;

    final lowered = message.toLowerCase();
    const technicalSignals = <String>[
      'typeerror',
      'subtype of type',
      'map<string',
      "type 'null'",
      'renderflex',
      'stack trace',
    ];

    for (final signal in technicalSignals) {
      if (lowered.contains(signal)) {
        return kSearchUnavailableMessage;
      }
    }

    return message;
  }

  Future<String?> scanBarcode(BarcodeRequest request) async {
    try {
      final query = await _repository.scanBarcode(request);
      return query;
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<String?> recognizeImage(ImageRecognitionRequest request) async {
    try {
      final query = await _repository.recognizeImage(request);
      return query;
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  bool _isCurrent(int operation) => operation == _operationVersion;

  void _startProgressivePolling(String requestId, int operation) {
    int pollCount = 0;
    const maxPollTime = Duration(seconds: 60);
    final startTime = DateTime.now();

    void scheduleNextPoll() {
      if (!_isCurrent(operation)) return;
      pollCount++;
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed > maxPollTime) {
        _finalizeSearch(operation);
        return;
      }

      final delay = pollCount <= 5
          ? const Duration(milliseconds: 1500)
          : const Duration(seconds: 3);

      _pollingTimer = Timer(delay, () async {
        if (!_isCurrent(operation)) return;
        try {
          final statusResponse = await _repository.getSearchStatus(
            requestId,
            cancelToken: _cancelToken,
          );

          if (!_isCurrent(operation)) return;
          _handleStatusUpdate(statusResponse);

          if (statusResponse.status == 'ready') {
            _finalizeSearch(operation);
          } else if (statusResponse.status == 'failed') {
            state = state.copyWith(
              status: SearchStatus.error,
              errorMessage: 'Analysis failed on server.',
            );
            _pollingTimer?.cancel();
          } else {
            scheduleNextPoll();
          }
        } catch (e) {
          if (e is DioException && CancelToken.isCancel(e)) return;
          if (!_isCurrent(operation)) return;
          // Retry logic for network issues during polling
          if (pollCount > 30) {
            _finalizeSearch(operation);
          } else {
            scheduleNextPoll();
          }
        }
      });
    }

    scheduleNextPoll();
  }

  void _handleStatusUpdate(SearchSessionStatusResponse status) {
    var newState = state;

    if (status.stage2 != null) {
      if (status.stage2!.status == 'ready' && status.stage2!.data != null) {
        final stage2Results = _parseProducts(status.stage2!.data!['results']);
        final stage2Offers = _parseStoreOffers(
          status.stage2!.data!['storeOffers'],
        );

        if (stage2Results.isNotEmpty) {
          newState = newState.copyWith(
            results: _mergeProducts(newState.results, stage2Results),
          );
        }
        if (stage2Offers.isNotEmpty) {
          newState = newState.copyWith(storeOffers: stage2Offers);
        }
        newState = newState.copyWith(status: SearchStatus.stage2Ready);
      } else if (status.stage2!.status == 'failed') {
        newState = newState.copyWith(stage2Error: true);
      }
    }

    if (status.stage3 != null) {
      if (status.stage3!.status == 'ready' && status.stage3!.data != null) {
        final aiUpdates = _parseAiUpdates(status.stage3!.data!['results']);
        if (aiUpdates.isNotEmpty) {
          newState = newState.copyWith(
            results: _mergeAIResultsInList(newState.results, aiUpdates),
            status: SearchStatus.stage3Ready,
          );
        }
      } else if (status.stage3!.status == 'failed') {
        newState = newState.copyWith(stage3Error: true);
      }
    }

    state = newState;
  }

  void _finalizeSearch(int operation) {
    if (!_isCurrent(operation)) return;
    _pollingTimer?.cancel();
    state = state.copyWith(status: SearchStatus.stage3Ready);
    if (state.lastRequest != null && state.errorMessage == null) {
      _updateCache(state.lastRequest!);
    }
  }

  List<Product> _mergeProducts(List<Product> current, List<Product> updates) {
    final Map<String, Product> productMap = {for (var p in current) p.id: p};
    for (var update in updates) {
      final existing = productMap[update.id];
      if (existing != null) {
        productMap[update.id] = existing.copyWith(
          dynamicPrices: update.dynamicPrices.isNotEmpty
              ? update.dynamicPrices
              : existing.dynamicPrices,
          title: update.title.isNotEmpty ? update.title : existing.title,
          imageUrl: update.imageUrl ?? existing.imageUrl,
          specifications: update.specifications.isNotEmpty
              ? update.specifications
              : existing.specifications,
        );
      } else {
        productMap[update.id] = update;
      }
    }
    return productMap.values.toList();
  }

  List<Product> _parseProducts(dynamic raw) {
    if (raw is! List) return const [];
    final products = <Product>[];
    for (final item in raw) {
      final json = _asJsonMap(item);
      if (json == null) continue;
      try {
        products.add(Product.fromJson(json));
      } catch (_) {
        continue;
      }
    }
    return products;
  }

  List<StoreOffer> _parseStoreOffers(dynamic raw) {
    if (raw is! List) return const [];
    final offers = <StoreOffer>[];
    for (final item in raw) {
      final json = _asJsonMap(item);
      if (json == null) continue;
      try {
        offers.add(StoreOffer.fromJson(json));
      } catch (_) {
        continue;
      }
    }
    return offers;
  }

  List<AIResultUpdate> _parseAiUpdates(dynamic raw) {
    if (raw is! List) return const [];
    final updates = <AIResultUpdate>[];
    for (final item in raw) {
      final json = _asJsonMap(item);
      if (json == null) continue;
      try {
        updates.add(AIResultUpdate.fromJson(json));
      } catch (_) {
        continue;
      }
    }
    return updates;
  }

  Map<String, dynamic>? _asJsonMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      try {
        return Map<String, dynamic>.from(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  List<Product> _mergeAIResultsInList(
    List<Product> current,
    List<AIResultUpdate> updates,
  ) {
    final Map<String, Product> productMap = {for (var p in current) p.id: p};
    for (var update in updates) {
      final existing = productMap[update.productId];
      if (existing != null) {
        productMap[update.productId] = existing.copyWith(
          aiAnalysis: update.aiAnalysis,
        );
      }
    }
    return productMap.values.toList();
  }

  void _updateCache(SearchRequest request) {
    _pruneExpiredCache();
    final key = _generateCacheKey(request);
    _cache.remove(key);
    _cache[key] = _CacheEntry(
      response: SearchResponse(
        query: request.query,
        results: state.results,
        storeOffers: state.storeOffers,
        country: request.country,
        requestId: state.requestId,
        aiSummaryRequestId: state.aiSummaryRequestId,
        plan: state.plan,
        quota: state.quota,
        searchProvider: state.searchProvider,
      ),
      expiry: DateTime.now().add(_cacheTtl),
    );

    while (_cache.length > _maxCacheEntries) {
      _cache.remove(_cache.keys.first);
    }
  }

  SearchResponse? _readCachedResponse(String key) {
    _pruneExpiredCache();
    final entry = _cache.remove(key);
    if (entry == null) return null;
    if (DateTime.now().isAfter(entry.expiry)) return null;
    _cache[key] = entry;
    return entry.response;
  }

  void _pruneExpiredCache() {
    final now = DateTime.now();
    _cache.removeWhere((_, entry) => now.isAfter(entry.expiry));
  }

  void retry() {
    if (_lastRequestParams != null) {
      search(_lastRequestParams!);
    }
  }

  @override
  void dispose() {
    _operationVersion++;
    _pollingTimer?.cancel();
    _cancelToken?.cancel();
    super.dispose();
  }
}

class _CacheEntry {
  final SearchResponse response;
  final DateTime expiry;
  _CacheEntry({required this.response, required this.expiry});
}
