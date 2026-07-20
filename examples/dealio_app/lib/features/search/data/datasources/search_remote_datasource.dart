import 'package:dio/dio.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/network/api_endpoints.dart';

/// Owns HTTP transport for search-related endpoints.
/// Response mapping belongs to the repository layer.
final class SearchRemoteDataSource {
  final ApiClient _apiClient;

  const SearchRemoteDataSource(this._apiClient);

  Future<Response<dynamic>> search(
    Map<String, dynamic> payload, {
    CancelToken? cancelToken,
  }) => _apiClient.dio.post(
    ApiEndpoints.search,
    data: payload,
    cancelToken: cancelToken,
  );

  Future<Response<dynamic>> searchStatus(
    String requestId, {
    CancelToken? cancelToken,
  }) => _apiClient.dio.get(
    ApiEndpoints.getSearchStatus(requestId),
    cancelToken: cancelToken,
  );

  Future<Response<dynamic>> aiStatus(
    String requestId, {
    CancelToken? cancelToken,
  }) => _apiClient.dio.get(
    ApiEndpoints.getAiStatus(requestId),
    cancelToken: cancelToken,
  );

  Future<Response<dynamic>> countries() =>
      _apiClient.dio.get(ApiEndpoints.getCountries);

  Future<Response<dynamic>> stores(Map<String, dynamic> queryParameters) =>
      _apiClient.dio.get(
        ApiEndpoints.getStores,
        queryParameters: queryParameters,
      );

  Future<Response<dynamic>> scanBarcode(Map<String, dynamic> payload) =>
      _apiClient.dio.post(ApiEndpoints.barcodeScan, data: payload);

  Future<Response<dynamic>> recognizeImage(Map<String, dynamic> payload) =>
      _apiClient.dio.post(ApiEndpoints.imageRecognition, data: payload);

  Future<Response<dynamic>> analyzeProduct(Map<String, dynamic> payload) =>
      _apiClient.dio.post(ApiEndpoints.analyzeProduct, data: payload);
}
