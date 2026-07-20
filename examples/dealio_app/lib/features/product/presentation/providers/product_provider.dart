import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/models/clario_models.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/network/failures.dart';
import 'package:untitled5/features/product/data/repositories/product_repository.dart';

final productRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProductRepository(apiClient);
});

// Provider for general product search (used in SearchScreen)
final productAnalysisProvider =
    StateNotifierProvider<ProductAnalysisNotifier, AsyncValue<SearchResponse?>>(
      (ref) {
        final repository = ref.watch(productRepositoryProvider);
        return ProductAnalysisNotifier(repository);
      },
    );

// NEW: Clario AI Analysis Provider (PRO/PLUS)
final clarioAnalysisProvider =
    StateNotifierProvider<
      ClarioAnalysisNotifier,
      AsyncValue<Map<String, dynamic>>
    >((ref) {
      final repository = ref.watch(productRepositoryProvider);
      return ClarioAnalysisNotifier(repository);
    });

class ClarioAnalysisNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final ProductRepository _repository;

  ClarioAnalysisNotifier(this._repository) : super(const AsyncValue.data({}));

  Future<void> analyze(ClarioAnalyzeRequest request) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.analyzeProductClario(request);
      state = AsyncValue.data(result);
    } catch (e, stack) {
      final error = e is AppException ? e : AppException.unknown(e);
      state = AsyncValue.error(error, stack);
    }
  }
}

class ProductAnalysisNotifier
    extends StateNotifier<AsyncValue<SearchResponse?>> {
  final ProductRepository _repository;
  CancelToken? _cancelToken;

  ProductAnalysisNotifier(this._repository)
    : super(const AsyncValue.data(null));

  Future<void> analyzeProduct({
    required String name,
    String? model,
    double? budget,
    String? notes,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    state = const AsyncValue.loading();
    try {
      // Create request object
      final request = SearchRequest(
        query: name,
        budget: budget,
        notes: notes,
        country: 'US', // Default or from state
      );

      final result = await _repository.searchProducts(
        request,
        cancelToken: _cancelToken,
      );
      state = AsyncValue.data(result);
    } catch (e, stack) {
      if (e is DioException && CancelToken.isCancel(e)) return;
      final error = e is AppException ? e : AppException.unknown(e);
      state = AsyncValue.error(error, stack);
    }
  }

  @override
  void dispose() {
    _cancelToken?.cancel();
    super.dispose();
  }
}

// Separate provider for single product details
final productDetailsProvider =
    StateNotifierProvider.family<
      SingleProductNotifier,
      AsyncValue<Product?>,
      String
    >((ref, productId) {
      final repository = ref.watch(productRepositoryProvider);
      return SingleProductNotifier(repository, productId);
    });

class SingleProductNotifier extends StateNotifier<AsyncValue<Product?>> {
  final ProductRepository _repository;
  final String productId;

  SingleProductNotifier(this._repository, this.productId)
    : super(const AsyncValue.loading()) {
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    state = const AsyncValue.loading();
    try {
      final product = await _repository.getProductDetails(productId);
      state = AsyncValue.data(product);
    } catch (e, stack) {
      final error = e is AppException ? e : AppException.unknown(e);
      state = AsyncValue.error(error, stack);
    }
  }
}

// Provider for specific AI Sentiment Analysis
final sentimentAnalysisProvider =
    StateNotifierProvider.family<
      SentimentAnalysisNotifier,
      AsyncValue<Map<String, dynamic>>,
      Product
    >((ref, product) {
      final repository = ref.watch(productRepositoryProvider);
      return SentimentAnalysisNotifier(repository, product);
    });

// Provider for AI Eco Score
final ecoScoreProvider =
    StateNotifierProvider.family<
      EcoScoreNotifier,
      AsyncValue<Map<String, dynamic>>,
      Product
    >((ref, product) {
      final repository = ref.watch(productRepositoryProvider);
      return EcoScoreNotifier(repository, product);
    });

// Provider for AI Recommendation
final aiRecommendationProvider =
    StateNotifierProvider.family<
      AIRecommendationNotifier,
      AsyncValue<Map<String, dynamic>>,
      Product
    >((ref, product) {
      final repository = ref.watch(productRepositoryProvider);
      return AIRecommendationNotifier(repository, product);
    });

class SentimentAnalysisNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final ProductRepository _repository;
  final Product product;

  SentimentAnalysisNotifier(this._repository, this.product)
    : super(const AsyncValue.loading()) {
    getSentiment();
  }

  Future<void> getSentiment() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.getSentimentAnalysis(product);
      state = AsyncValue.data(result);
    } catch (e, stack) {
      final error = e is AppException ? e : AppException.unknown(e);
      state = AsyncValue.error(error, stack);
    }
  }
}

class EcoScoreNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final ProductRepository _repository;
  final Product product;

  EcoScoreNotifier(this._repository, this.product)
    : super(const AsyncValue.loading()) {
    getEcoScore();
  }

  Future<void> getEcoScore() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.getEcoScore(product);
      state = AsyncValue.data(result);
    } catch (e, stack) {
      final error = e is AppException ? e : AppException.unknown(e);
      state = AsyncValue.error(error, stack);
    }
  }
}

class AIRecommendationNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final ProductRepository _repository;
  final Product product;

  AIRecommendationNotifier(this._repository, this.product)
    : super(const AsyncValue.loading()) {
    getRecommendation();
  }

  Future<void> getRecommendation() async {
    state = const AsyncValue.loading();
    try {
      final sentiment = await _repository.getSentimentAnalysis(product);
      final ecoScore = await _repository.getEcoScore(product);
      state = AsyncValue.data({'sentiment': sentiment, 'ecoScore': ecoScore});
    } catch (e, stack) {
      final error = e is AppException ? e : AppException.unknown(e);
      state = AsyncValue.error(error, stack);
    }
  }
}
