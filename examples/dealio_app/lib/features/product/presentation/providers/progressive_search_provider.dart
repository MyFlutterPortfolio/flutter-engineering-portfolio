import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/network/failures.dart';
import 'package:untitled5/features/product/data/repositories/product_repository.dart';

import 'product_provider.dart';

part 'progressive_search_provider.freezed.dart';

@freezed
abstract class ProgressiveSearchState with _$ProgressiveSearchState {
  const factory ProgressiveSearchState({
    required AsyncValue<SearchResponse?> searchResponse,
    @Default(0) int currentStage,
    @Default(false) bool isPolling,
    String? requestId,
    String? stage2Error,
    String? stage3Error,
    String? lastQueryKey,
    DateTime? lastRequestTime,
  }) = _ProgressiveSearchState;
}

final progressiveSearchProvider =
    StateNotifierProvider<ProgressiveSearchNotifier, ProgressiveSearchState>((
      ref,
    ) {
      final repository = ref.watch(productRepositoryProvider);
      return ProgressiveSearchNotifier(repository);
    });

class ProgressiveSearchNotifier extends StateNotifier<ProgressiveSearchState> {
  final ProductRepository _repository;
  Timer? _pollingTimer;
  CancelToken? _cancelToken;
  int _pollCount = 0;
  final Duration _dedupeWindow = const Duration(seconds: 2);

  ProgressiveSearchNotifier(this._repository)
    : super(
        ProgressiveSearchState(searchResponse: const AsyncValue.data(null)),
      );

  Future<void> search(SearchRequest request) async {
    final queryKey = "${request.query}-${request.country}-${request.budget}";
    final now = DateTime.now();

    // Deduplication
    if (state.lastQueryKey == queryKey &&
        state.lastRequestTime != null &&
        now.difference(state.lastRequestTime!) < _dedupeWindow) {
      return;
    }

    _cancelPolling();
    _cancelToken = CancelToken();
    _pollCount = 0;

    state = state.copyWith(
      searchResponse: const AsyncValue.loading(),
      currentStage: 1,
      requestId: null,
      stage2Error: null,
      stage3Error: null,
      lastQueryKey: queryKey,
      lastRequestTime: now,
    );

    try {
      final stage1Response = await _repository.searchProducts(
        request,
        cancelToken: _cancelToken,
      );

      state = state.copyWith(
        searchResponse: AsyncValue.data(stage1Response),
        requestId: stage1Response.requestId,
        currentStage: 1,
      );

      if (stage1Response.requestId != null &&
          (stage1Response.isPartial == true || stage1Response.stage == 1)) {
        _startPolling(stage1Response.requestId!);
      }
    } catch (e, stack) {
      if (e is DioException && CancelToken.isCancel(e)) return;
      final error = e is AppException ? e : AppException.unknown(e);
      state = state.copyWith(searchResponse: AsyncValue.error(error, stack));
    }
  }

  void _startPolling(String requestId) {
    state = state.copyWith(isPolling: true);
    _scheduleNextPoll(requestId, const Duration(milliseconds: 400));
  }

  void _scheduleNextPoll(String requestId, Duration delay) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer(delay, () => _pollStatus(requestId));
  }

  Future<void> _pollStatus(String requestId) async {
    if (!state.isPolling) return;
    _pollCount++;

    // Max polling window 20s
    if (_pollCount > 35) {
      // rough estimate: 5 * 400ms + 18 * 1s = 2s + 18s = 20s
      _stopPolling();
      return;
    }

    try {
      final status = await _repository.getSearchStatus(
        requestId,
        cancelToken: _cancelToken,
      );

      _handleStatusUpdate(status);

      if (status.status == 'ready' || status.status == 'failed') {
        _stopPolling();
      } else {
        final nextDelay = _pollCount < 5
            ? const Duration(milliseconds: 400)
            : const Duration(seconds: 1);
        _scheduleNextPoll(requestId, nextDelay);
      }
    } catch (e) {
      if (e is DioException && CancelToken.isCancel(e)) return;
      // Continue polling on transient errors unless it's a hard failure
      _scheduleNextPoll(requestId, const Duration(seconds: 1));
    }
  }

  void _handleStatusUpdate(SearchSessionStatusResponse status) {
    final currentResponse = state.searchResponse.value;
    if (currentResponse == null) return;

    var updatedResults = List<Product>.from(currentResponse.results);
    var updatedOffers = List<StoreOffer>.from(currentResponse.storeOffers);
    String? stage2Err = state.stage2Error;
    String? stage3Err = state.stage3Error;
    int stage = state.currentStage;

    // Merge Stage 2: Detailed data (prices/offers)
    if (status.stage2?.status == 'ready' && status.stage2?.data != null) {
      stage = 2;
      final data = status.stage2!.data!;
      // Assume data contains 'storeOffers' or updates for specific products
      if (data['storeOffers'] != null) {
        final List offersJson = data['storeOffers'];
        updatedOffers = offersJson.map((j) => StoreOffer.fromJson(j)).toList();
      }

      // Update individual products if data contains product-specific prices
      if (data['products'] != null) {
        final Map<String, dynamic> productsUpdate = data['products'];
        updatedResults = updatedResults.map((p) {
          if (productsUpdate.containsKey(p.id)) {
            final update = productsUpdate[p.id];
            if (update['dynamicPrices'] != null) {
              final List prices = update['dynamicPrices'];
              return p.copyWith(
                dynamicPrices: prices
                    .map((price) => DynamicPrice.fromJson(price))
                    .toList(),
              );
            }
          }
          return p;
        }).toList();
      }
    } else if (status.stage2?.status == 'failed') {
      stage2Err = status.stage2?.error ?? "Detailed data delayed.";
    }

    // Merge Stage 3: AI analysis
    if (status.stage3?.status == 'ready' && status.stage3?.data != null) {
      stage = 3;
      final data = status.stage3!.data!;
      if (data['results'] != null) {
        final List aiUpdates = data['results'];
        for (var update in aiUpdates) {
          final productId = update['productId'];
          final aiJson = update['aiAnalysis'];
          if (productId != null && aiJson != null) {
            final index = updatedResults.indexWhere((p) => p.id == productId);
            if (index != -1) {
              updatedResults[index] = updatedResults[index].copyWith(
                aiAnalysis: AIAnalysis.fromJson(aiJson),
              );
            }
          }
        }
      }
    } else if (status.stage3?.status == 'failed') {
      stage3Err = status.stage3?.error ?? "AI analysis unavailable.";
    }

    state = state.copyWith(
      currentStage: stage,
      stage2Error: stage2Err,
      stage3Error: stage3Err,
      searchResponse: AsyncValue.data(
        currentResponse.copyWith(
          results: updatedResults,
          storeOffers: updatedOffers,
        ),
      ),
    );
  }

  void _stopPolling() {
    state = state.copyWith(isPolling: false);
    _pollingTimer?.cancel();
  }

  void _cancelPolling() {
    _stopPolling();
    _cancelToken?.cancel();
  }

  @override
  void dispose() {
    _cancelPolling();
    super.dispose();
  }
}
