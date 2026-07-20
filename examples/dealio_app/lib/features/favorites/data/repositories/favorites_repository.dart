import 'package:dio/dio.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/network/api_endpoints.dart';
import 'package:untitled5/core/network/failures.dart';

class FavoritesRepository {
  final ApiClient _apiClient;

  FavoritesRepository(this._apiClient);

  Future<List<Product>> getFavorites() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.getFavorites);
      return _parseFavorites(response.data);
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<void> addFavorite(Product product) async {
    try {
      final productId = _safeProductId(product.id);
      await _apiClient.dio.post(
        ApiEndpoints.addFavorite,
        data: {'productId': productId},
      );
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Future<void> removeFavorite(String productId) async {
    try {
      final safeId = _safeProductId(productId);
      await _apiClient.dio.post(
        ApiEndpoints.removeFavorite,
        data: {'productId': safeId},
      );
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  List<Product> _parseFavorites(Object? data) {
    final rows = _extractList(data);
    final products = <Product>[];

    for (final row in rows) {
      final productJson = _extractProductJson(row);
      if (productJson == null) continue;

      try {
        products.add(Product.fromJson(productJson));
      } catch (_) {
        continue;
      }
    }

    return products;
  }

  List<Object?> _extractList(Object? data) {
    if (data is List) return data.cast<Object?>();
    if (data is! Map) return const <Object?>[];

    for (final key in const ['data', 'favorites', 'items', 'results']) {
      final value = data[key];
      if (value is List) return value.cast<Object?>();
      if (value is Map) {
        final nested = _extractList(value);
        if (nested.isNotEmpty) return nested;
      }
    }

    return const <Object?>[];
  }

  Map<String, dynamic>? _extractProductJson(Object? row) {
    if (row is! Map) return null;
    final json = Map<String, dynamic>.from(row);

    for (final key in const ['product', 'item']) {
      final nested = json[key];
      if (nested is Map) {
        final productJson = Map<String, dynamic>.from(nested);
        productJson['id'] ??= _stringField(json, 'productId');
        return _withSafeId(productJson);
      }
    }

    return _withSafeId(json);
  }

  Map<String, dynamic>? _withSafeId(Map<String, dynamic> json) {
    final id =
        _stringField(json, 'id') ??
        _stringField(json, 'productId') ??
        _stringField(json, '_id');
    if (id == null) return null;

    return {...json, 'id': id};
  }

  String? _stringField(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String _safeProductId(String productId) {
    final trimmed = productId.trim();
    if (trimmed.isEmpty) {
      throw AppException.unknown('Invalid product id');
    }
    return trimmed;
  }
}
