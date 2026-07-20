import 'package:dio/dio.dart';
import 'package:untitled5/core/models/clario_models.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/network/api_endpoints.dart';
import 'package:untitled5/core/network/failures.dart';

class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository(this._apiClient);

  // --- BILLING & SUBSCRIPTION ---

  Future<BillingStatusResponse> getBillingStatus() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.billingMe);
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return BillingStatusResponse.fromJson(_normalizeQuotaPayload(data));
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<void> activateGooglePlayPurchase(ActivateGooglePlayRequest req) async {
    try {
      await _apiClient.dio.post(
        ApiEndpoints.activateGooglePlay,
        data: req.toJson(),
      );
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  // --- CLARIO AI ANALYSIS (PRO/PLUS) ---

  Future<Map<String, dynamic>> analyzeProductClario(
    ClarioAnalyzeRequest req,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.analyzeProduct,
        data: req.toJson(),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  // --- SEARCH, COUNTRIES & STORES ---

  Future<List<Country>> getCountries() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.getCountries);
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final List countries = data['countries'] ?? [];
        return countries.map((json) => Country.fromJson(json)).toList();
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<List<Store>> searchStores({
    required String country,
    String q = '',
    int limit = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.getStores,
        queryParameters: {'country': country, 'q': q, 'limit': limit},
        cancelToken: cancelToken,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final List stores = data['stores'] ?? [];
        return stores.map((json) => Store.fromJson(json)).toList();
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) rethrow;
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<SearchResponse> searchProducts(
    SearchRequest req, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.search,
        data: req.toJson(),
        cancelToken: cancelToken,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return SearchResponse.fromJson(_normalizeQuotaPayload(data));
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<SearchSessionStatusResponse> getSearchStatus(
    String requestId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.getSearchStatus(requestId),
        cancelToken: cancelToken,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return SearchSessionStatusResponse.fromJson(data);
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) rethrow;
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<AIStatusResponse> getAiStatus(
    String requestId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.getAiStatus(requestId),
        cancelToken: cancelToken,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return AIStatusResponse.fromJson(data);
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) rethrow;
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  // --- ANALYSIS & LEGACY SUPPORT ---

  Future<Map<String, dynamic>> analyzeProduct({
    required String name,
    String? model,
    double? budget,
    String? notes,
    String? country,
  }) async {
    try {
      final payload = <String, dynamic>{
        'query': name,
        'country': country ?? 'US',
        'storeScope': 'global',
      };
      if (model != null && model.trim().isNotEmpty) {
        payload['model'] = model.trim();
      }
      if (budget != null) {
        payload['budget'] = budget;
      }
      if (notes != null && notes.trim().isNotEmpty) {
        payload['notes'] = notes.trim();
      }

      final response = await _apiClient.dio.post(
        ApiEndpoints.search,
        data: payload,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<Map<String, dynamic>> getSentimentAnalysis(Product product) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.sentimentAnalysis,
        data: {'productId': product.id},
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<Map<String, dynamic>> getEcoScore(Product product) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.ecoScore,
        data: {'productId': product.id},
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  // --- AI & OTHER ---

  Future<Map<String, dynamic>> recognizeImage(
    ImageRecognitionRequest req,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/ai/image-recognition',
        data: req.toJson(),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<Map<String, dynamic>> scanBarcode(BarcodeRequest req) async {
    try {
      final response = await _apiClient.dio.post(
        '/ai/barcode-scan',
        data: req.toJson(),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<Product> getProductDetails(String productId) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.getProduct(productId),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return Product.fromJson(data);
      }
      throw AppException.unknown('Invalid response format');
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Map<String, dynamic> _normalizeQuotaPayload(Map<String, dynamic> raw) {
    if (raw['quota'] is! Map<String, dynamic>) {
      return raw;
    }

    final normalized = Map<String, dynamic>.from(raw);
    final quota = Map<String, dynamic>.from(
      normalized['quota'] as Map<String, dynamic>,
    );

    if (quota['search'] is Map<String, dynamic>) {
      final search = Map<String, dynamic>.from(
        quota['search'] as Map<String, dynamic>,
      );
      final used = (search['used'] as num?)?.toInt() ?? 0;
      final limit = (search['limit'] as num?)?.toInt() ?? 999999;
      final remaining =
          (search['remaining'] as num?)?.toInt() ?? (limit - used);

      search['used'] = used < 0 ? 0 : used;
      search['limit'] = limit <= 0 ? 99999 : limit;
      search['remaining'] = remaining < 0 ? 0 : remaining;
      search['allowed'] = search['allowed'] ?? true;
      search['resetAt'] = search['resetAt'] ?? '';

      quota['search'] = search;
      normalized['quota'] = quota;
    }

    return normalized;
  }
}
