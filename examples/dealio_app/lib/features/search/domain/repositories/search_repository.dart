import 'package:dio/dio.dart';
import 'package:untitled5/core/models/search_models.dart';

abstract class SearchRepository {
  Future<SearchResponse> search(
    SearchRequest request, {
    CancelToken? cancelToken,
  });
  Future<SearchSessionStatusResponse> getSearchStatus(
    String requestId, {
    CancelToken? cancelToken,
  });
  Future<AIStatusResponse> getAiStatus(
    String requestId, {
    CancelToken? cancelToken,
  });
  Future<List<Country>> getCountries();
  Future<List<Store>> getStores(String country, {String? q, int limit = 20});

  // Barcode & Image flows
  Future<String> scanBarcode(BarcodeRequest request);
  Future<String> recognizeImage(ImageRecognitionRequest request);

  // KVONT precision flow
  Future<SearchResponse> analyzeProduct(Map<String, dynamic> data);
}
