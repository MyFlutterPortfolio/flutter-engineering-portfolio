import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/network/api_endpoints.dart';
import 'package:untitled5/core/network/failures.dart';
import 'package:untitled5/features/search/data/repositories/search_repository_impl.dart';
import 'package:untitled5/features/search/data/datasources/search_remote_datasource.dart';
import 'package:untitled5/features/search/domain/repositories/search_repository.dart';

class AgentSearchRequest {
  static const String schemaVersion = 'dealio.agent_search.v1';

  final String query;
  final String countryCode;
  final String language;
  final String? userContext;
  final String? productId;
  final int limit;
  final String priority;
  final int cacheTtlSeconds;
  final int dedupeWindowSeconds;
  final int timeoutMs;

  const AgentSearchRequest({
    required this.query,
    required this.countryCode,
    required this.language,
    this.userContext,
    this.productId,
    this.limit = 4,
    this.priority = 'interactive',
    this.cacheTtlSeconds = 600,
    this.dedupeWindowSeconds = 90,
    this.timeoutMs = 12000,
  });

  String get normalizedQuery {
    return query.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  String get normalizedCountry {
    return countryCode.trim().toUpperCase();
  }

  String get normalizedLanguage {
    final value = language.trim().toLowerCase();
    return value.isEmpty ? 'en' : value;
  }

  int get safeLimit => limit.clamp(1, 8);

  String get dedupeKey {
    final parts = <String>[
      schemaVersion,
      normalizedQuery,
      normalizedCountry,
      normalizedLanguage,
      productId?.trim() ?? '',
      safeLimit.toString(),
    ];
    return 'ags_${_stableHash(parts.join('|'))}';
  }

  String createClientRequestId() {
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return '${dedupeKey}_$timestamp';
  }

  Map<String, dynamic> toJson({required String clientRequestId}) {
    final context = userContext?.trim();
    final scopedProductId = productId?.trim();
    final safeCacheTtl = cacheTtlSeconds.clamp(60, 3600);
    final safeDedupeWindow = dedupeWindowSeconds.clamp(15, 600);
    final safeTimeout = timeoutMs.clamp(3000, 30000);

    final payload = <String, dynamic>{
      'schemaVersion': schemaVersion,
      'clientRequestId': clientRequestId,
      'dedupeKey': dedupeKey,
      'intent': 'shopping_search',
      'query': <String, dynamic>{
        'text': query.trim(),
        'normalized': normalizedQuery,
      },
      'locale': <String, dynamic>{
        'language': normalizedLanguage,
        'country': normalizedCountry,
      },
      'context': <String, dynamic>{
        if (context != null && context.isNotEmpty) 'conversation': context,
        if (scopedProductId != null && scopedProductId.isNotEmpty)
          'productId': scopedProductId,
      },
      'controls': <String, dynamic>{
        'limit': safeLimit,
        'priority': priority.trim().isEmpty ? 'interactive' : priority.trim(),
        'timeoutMs': safeTimeout,
        'progressive': true,
      },
      'cache': <String, dynamic>{
        'enabled': true,
        'ttlSeconds': safeCacheTtl,
        'dedupeWindowSeconds': safeDedupeWindow,
      },
      'capabilities': const <String, dynamic>{
        'rankProducts': true,
        'verifyPrices': true,
        'returnSources': true,
        'priceAlertCandidate': true,
      },
      'client': <String, dynamic>{
        'app': 'dealio',
        'platform': kIsWeb ? 'web' : defaultTargetPlatform.name,
      },
    };
    return payload;
  }

  static String _stableHash(String input) {
    var hash = 0x811c9dc5;
    for (final codeUnit in input.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x01000193) & 0xffffffff;
    }
    return hash.toRadixString(16).padLeft(8, '0');
  }
}

class AgentSearchResponse {
  final String schemaVersion;
  final String status;
  final String summary;
  final List<AgentSearchProduct> products;
  final List<String> sources;
  final String? requestId;
  final String? clientRequestId;
  final String? dedupeKey;
  final String? provider;
  final String? cacheStatus;
  final String? queueStatus;
  final int? queuePosition;
  final int? nextPollMs;
  final bool fromFallback;

  const AgentSearchResponse({
    this.schemaVersion = AgentSearchRequest.schemaVersion,
    this.status = 'ready',
    required this.summary,
    required this.products,
    this.sources = const <String>[],
    this.requestId,
    this.clientRequestId,
    this.dedupeKey,
    this.provider,
    this.cacheStatus,
    this.queueStatus,
    this.queuePosition,
    this.nextPollMs,
    this.fromFallback = false,
  });

  bool get hasTerminalResult {
    final normalized = status.toLowerCase();
    return normalized == 'ready' ||
        normalized == 'partial' ||
        normalized == 'completed' ||
        normalized == 'failed';
  }

  bool get shouldPoll {
    final normalized = status.toLowerCase();
    return requestId != null &&
        (normalized == 'queued' ||
            normalized == 'pending' ||
            normalized == 'processing' ||
            normalized == 'running');
  }

  Map<String, dynamic> toChatMetadata() {
    return <String, dynamic>{
      'decision': summary,
      'products': products.map((product) => product.toChatMetadata()).toList(),
      'priceAlert': products.isNotEmpty,
      'sources': sources,
      'agentSearch': <String, dynamic>{
        'schemaVersion': schemaVersion,
        'status': status,
        if (requestId != null) 'requestId': requestId,
        if (clientRequestId != null) 'clientRequestId': clientRequestId,
        if (dedupeKey != null) 'dedupeKey': dedupeKey,
        if (provider != null) 'provider': provider,
        if (cacheStatus != null) 'cacheStatus': cacheStatus,
        if (queueStatus != null) 'queueStatus': queueStatus,
        if (queuePosition != null) 'queuePosition': queuePosition,
        if (nextPollMs != null) 'nextPollMs': nextPollMs,
        'fallback': fromFallback,
      },
    };
  }
}

class AgentSearchProduct {
  final String id;
  final String title;
  final bool isSyntheticId;
  final String? store;
  final double? price;
  final String? currency;
  final String? link;
  final int? score;
  final String? reason;
  final String? imageUrl;

  const AgentSearchProduct({
    required this.id,
    required this.title,
    this.isSyntheticId = false,
    this.store,
    this.price,
    this.currency,
    this.link,
    this.score,
    this.reason,
    this.imageUrl,
  });

  Map<String, dynamic> toChatMetadata() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isSyntheticId': isSyntheticId,
      if (store != null) 'store': store,
      if (price != null) 'price': price,
      if (currency != null) 'currency': currency,
      if (link != null) 'link': link,
      if (score != null) 'score': score,
      if (reason != null) 'reason': reason,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}

class AgentSearchRepository {
  final ApiClient _apiClient;
  final SearchRepository _fallbackSearchRepository;

  AgentSearchRepository(this._apiClient, this._fallbackSearchRepository);

  Future<AgentSearchResponse> search(AgentSearchRequest request) async {
    final clientRequestId = request.createClientRequestId();
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.agentSearch,
        data: request.toJson(clientRequestId: clientRequestId),
        options: Options(
          headers: <String, dynamic>{
            'Idempotency-Key': clientRequestId,
            'X-Dedupe-Key': request.dedupeKey,
            'X-Agent-Search-Schema': AgentSearchRequest.schemaVersion,
          },
        ),
      );
      final parsed = _parseAgentResponse(
        response.data,
        request: request,
        clientRequestId: clientRequestId,
      );
      if (parsed.shouldPoll) {
        return _pollQueuedSearch(parsed, request: request);
      }
      if (parsed.products.isNotEmpty || parsed.summary.trim().isNotEmpty) {
        return parsed;
      }
      return _searchWithFallback(request);
    } on DioException {
      return _searchWithFallback(request);
    } catch (e) {
      throw e is AppException ? e : AppException.unknown(e);
    }
  }

  Future<AgentSearchResponse> _pollQueuedSearch(
    AgentSearchResponse initial, {
    required AgentSearchRequest request,
  }) async {
    var latest = initial;
    for (var attempt = 0; attempt < 7; attempt += 1) {
      final requestId = latest.requestId;
      if (requestId == null || requestId.trim().isEmpty) return latest;

      final delayMs = (latest.nextPollMs ?? (attempt < 3 ? 900 : 1400))
          .clamp(450, 2500)
          .toInt();
      await Future<void>.delayed(Duration(milliseconds: delayMs));

      try {
        final response = await _apiClient.dio.get(
          ApiEndpoints.agentSearchStatus(requestId),
          options: Options(
            headers: <String, dynamic>{
              'X-Dedupe-Key': latest.dedupeKey ?? request.dedupeKey,
              'X-Agent-Search-Schema': AgentSearchRequest.schemaVersion,
            },
          ),
        );
        latest = _parseAgentResponse(
          response.data,
          request: request,
          clientRequestId: latest.clientRequestId,
          fallbackRequestId: requestId,
        );
        if (!latest.shouldPoll) return latest;
      } on DioException {
        if (latest.products.isNotEmpty || latest.summary.trim().isNotEmpty) {
          return latest;
        }
      }
    }
    return latest;
  }

  Future<AgentSearchResponse> _searchWithFallback(
    AgentSearchRequest request,
  ) async {
    try {
      final response = await _fallbackSearchRepository.search(
        SearchRequest(
          query: request.query,
          country: request.countryCode,
          language: request.language,
          storeScope: 'global',
          notes: request.userContext,
        ),
      );
      final products = response.results
          .map(_productToAgentResult)
          .whereType<AgentSearchProduct>()
          .take(request.limit.clamp(1, 8))
          .toList(growable: false);
      final sources = products
          .map((product) => product.link)
          .whereType<String>()
          .where((link) => link.trim().isNotEmpty)
          .toSet()
          .take(8)
          .toList(growable: false);

      return AgentSearchResponse(
        status: 'ready',
        summary: '',
        products: products,
        sources: sources,
        requestId: response.requestId,
        clientRequestId: request.createClientRequestId(),
        dedupeKey: request.dedupeKey,
        provider: response.searchProvider ?? 'search-fallback',
        cacheStatus: 'local-fallback',
        queueStatus: 'completed',
        fromFallback: true,
      );
    } catch (e) {
      throw e is AppException ? e : AppException.unknown(e);
    }
  }

  AgentSearchResponse _parseAgentResponse(
    Object? data, {
    required AgentSearchRequest request,
    required String? clientRequestId,
    String? fallbackRequestId,
  }) {
    final root = _asMap(data);
    if (root == null) {
      throw AppException.unknown('Invalid agent search response');
    }
    final result = _asMap(root['result']);
    final body = result ?? _asMap(root['data']) ?? root;
    final rawItems =
        body['products'] ??
        body['results'] ??
        body['items'] ??
        body['recommendations'];

    final products = rawItems is List
        ? rawItems
              .map(_asMap)
              .whereType<Map<String, dynamic>>()
              .map(_mapToAgentResult)
              .whereType<AgentSearchProduct>()
              .take(8)
              .toList(growable: false)
        : const <AgentSearchProduct>[];

    return AgentSearchResponse(
      schemaVersion:
          _readString(root, const ['schemaVersion', 'version']) ??
          _readString(body, const ['schemaVersion', 'version']) ??
          AgentSearchRequest.schemaVersion,
      status:
          _readString(root, const ['status']) ??
          _readString(body, const ['status']) ??
          'ready',
      summary:
          _readString(body, const [
            'summary',
            'message',
            'recommendation',
            'decision',
          ]) ??
          '',
      products: products,
      sources: _readStringList(body['sources'] ?? root['sources']),
      requestId:
          _readString(root, const ['requestId', 'id']) ??
          _readString(body, const ['requestId', 'id']) ??
          fallbackRequestId,
      clientRequestId:
          _readString(root, const ['clientRequestId']) ??
          _readString(body, const ['clientRequestId']) ??
          clientRequestId,
      dedupeKey:
          _readString(root, const ['dedupeKey']) ??
          _readString(body, const ['dedupeKey']) ??
          request.dedupeKey,
      provider:
          _readString(root, const ['provider', 'searchProvider']) ??
          _readString(body, const ['provider', 'searchProvider']),
      cacheStatus: _readCacheStatus(root, body),
      queueStatus: _readQueueStatus(root, body),
      queuePosition: _readQueuePosition(root, body),
      nextPollMs: _readNextPollMs(root, body),
    );
  }

  AgentSearchProduct? _mapToAgentResult(Map<String, dynamic> map) {
    final title = _readString(map, const [
      'title',
      'name',
      'productTitle',
      'product_name',
    ]);
    if (title == null) return null;

    final bestOffer = _asMap(map['bestOffer'] ?? map['offer']);
    final price = _readDouble(
      map['price'] ?? map['currentPrice'] ?? bestOffer?['price'],
    );
    final rawId = _readString(map, const ['id', 'productId', 'sku']);
    return AgentSearchProduct(
      id: rawId ?? _stableId(title),
      title: title,
      isSyntheticId: rawId == null,
      store:
          _readString(map, const ['store', 'storeName', 'merchant']) ??
          (bestOffer == null
              ? null
              : _readString(bestOffer, const [
                  'store',
                  'storeName',
                  'merchant',
                ])),
      price: price,
      currency:
          _readString(map, const ['currency']) ??
          (bestOffer == null
              ? null
              : _readString(bestOffer, const ['currency'])) ??
          'USD',
      link:
          _readString(map, const ['link', 'url', 'productUrl']) ??
          (bestOffer == null
              ? null
              : _readString(bestOffer, const ['link', 'url', 'productUrl'])),
      score: _readScore(map['score'] ?? map['fitScore'] ?? map['confidence']),
      reason: _readString(map, const ['reason', 'why', 'summary']),
      imageUrl: _readString(map, const ['imageUrl', 'image', 'thumbnail']),
    );
  }

  AgentSearchProduct? _productToAgentResult(Product product) {
    final title = product.title.trim().isNotEmpty
        ? product.title.trim()
        : product.modelName.trim();
    if (title.isEmpty) return null;

    final bestPrice = _bestPrice(product);
    return AgentSearchProduct(
      id: product.id,
      title: title,
      isSyntheticId: false,
      store: bestPrice?.store,
      price: bestPrice?.price,
      currency: bestPrice?.currency,
      link: bestPrice?.link,
      score: _scoreForProduct(product),
      reason: _reasonForProduct(product),
      imageUrl: product.imageUrl,
    );
  }

  DynamicPrice? _bestPrice(Product product) {
    final prices =
        product.dynamicPrices.where((price) => price.price > 0).toList()
          ..sort((a, b) {
            if (a.availability != b.availability) {
              return a.availability ? -1 : 1;
            }
            return a.price.compareTo(b.price);
          });
    return prices.isEmpty ? null : prices.first;
  }

  int? _scoreForProduct(Product product) {
    final needsScore = product.needsMatch?.matchPercentage;
    if (needsScore != null) return needsScore.clamp(0, 100).round();
    final aiScore = product.aiAnalysis?.needsMatchScore;
    if (aiScore != null) return aiScore.clamp(0, 100).round();
    final valueScore = product.aiAnalysis?.valueScore;
    if (valueScore != null) return valueScore.clamp(0, 100).round();
    return null;
  }

  String? _reasonForProduct(Product product) {
    final candidates = <String?>[
      product.aiAnalysis?.recommendationForUser,
      product.aiAnalysis?.fitSummary,
      product.needsMatch?.summary,
      product.description,
    ];
    for (final candidate in candidates) {
      final value = candidate?.trim();
      if (value != null && value.isNotEmpty) return value;
    }
    return null;
  }

  Map<String, dynamic>? _asMap(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  String? _readCacheStatus(
    Map<String, dynamic> root,
    Map<String, dynamic> body,
  ) {
    final cache =
        _asMap(root['cache']) ??
        _asMap(body['cache']) ??
        _asMap(root['cacheInfo']) ??
        _asMap(body['cacheInfo']);
    if (cache == null) {
      return _readString(root, const ['cacheStatus']) ??
          _readString(body, const ['cacheStatus']);
    }
    return _readString(cache, const ['status', 'state', 'source']);
  }

  String? _readQueueStatus(
    Map<String, dynamic> root,
    Map<String, dynamic> body,
  ) {
    final queue =
        _asMap(root['queue']) ??
        _asMap(body['queue']) ??
        _asMap(root['queueInfo']) ??
        _asMap(body['queueInfo']);
    if (queue == null) {
      return _readString(root, const ['queueStatus']) ??
          _readString(body, const ['queueStatus']);
    }
    return _readString(queue, const ['status', 'state']);
  }

  int? _readQueuePosition(
    Map<String, dynamic> root,
    Map<String, dynamic> body,
  ) {
    final queue =
        _asMap(root['queue']) ??
        _asMap(body['queue']) ??
        _asMap(root['queueInfo']) ??
        _asMap(body['queueInfo']);
    return _readInt(queue?['position'] ?? root['queuePosition']);
  }

  int? _readNextPollMs(Map<String, dynamic> root, Map<String, dynamic> body) {
    final queue =
        _asMap(root['queue']) ??
        _asMap(body['queue']) ??
        _asMap(root['queueInfo']) ??
        _asMap(body['queueInfo']);
    return _readInt(
      queue?['nextPollMs'] ??
          body['nextPollMs'] ??
          root['nextPollMs'] ??
          root['retryAfterMs'],
    );
  }

  String? _readString(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key]?.toString().trim();
      if (value != null && value.isNotEmpty && value.toLowerCase() != 'null') {
        return value;
      }
    }
    return null;
  }

  List<String> _readStringList(Object? raw) {
    if (raw is! List) return const <String>[];
    return raw
        .map((item) => item.toString().trim())
        .where((item) => item.isNotEmpty)
        .toSet()
        .toList(growable: false);
  }

  double? _readDouble(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '');
  }

  int? _readInt(Object? value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  int? _readScore(Object? value) {
    if (value is num) return value.clamp(0, 100).round();
    final parsed = num.tryParse(value?.toString() ?? '');
    return parsed?.clamp(0, 100).round();
  }

  String _stableId(String title) {
    final slug = title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return slug.isEmpty ? 'agent-result' : 'agent-$slug';
  }
}

final agentSearchRepositoryProvider = Provider<AgentSearchRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AgentSearchRepository(
    apiClient,
    SearchRepositoryImpl(SearchRemoteDataSource(apiClient)),
  );
});
