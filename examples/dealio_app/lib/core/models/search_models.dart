import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled5/core/models/subscription_model.dart';

import 'product_model.dart';

part 'search_models.freezed.dart';
part 'search_models.g.dart';

@freezed
abstract class Country with _$Country {
  const factory Country({
    required String code,
    required String name,
    required String gl,
    required String hl,
    required String location,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@freezed
abstract class Store with _$Store {
  const factory Store({
    required String name,
    required List<String> domains,
    required String countryCode,
  }) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}

@freezed
abstract class StoreOffer with _$StoreOffer {
  const factory StoreOffer({
    required String store,
    required double price,
    required String currency,
    required String link,
    required bool availability,
    required int stock,
    String? productTitle,
    String? productId,
  }) = _StoreOffer;

  factory StoreOffer.fromJson(Map<String, dynamic> json) =>
      _$StoreOfferFromJson(json);
}

@freezed
abstract class SearchRequest with _$SearchRequest {
  const factory SearchRequest({
    required String query,
    required String country,
    @Default('global') String storeScope,
    double? budget,
    String? notes,
    @Default('en') String language,
    String? location,
    List<String>? selectedStores,
  }) = _SearchRequest;

  factory SearchRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestFromJson(json);
}

@freezed
abstract class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    required String query,
    @Default(0) int count,
    @Default([]) List<Product> results,
    required String country,
    @Default('global') String storeScope,
    @Default([]) List<String> selectedStores,
    @Default([]) List<String> selectedStoreLinks,
    @Default([]) List<StoreOffer> storeOffers,
    @Default(false) bool aiAnalysisDeferred,
    String? requestId,
    int? stage,
    bool? isPartial,
    int? nextPollMs,
    String? statusEndpoint,
    String? stage1Source,
    String? aiSummaryRequestId,
    String? timestamp,
    SubscriptionPlan? plan,
    String? searchProvider,
    QuotaInfo? quota,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}

@freezed
abstract class SearchSessionStatusResponse with _$SearchSessionStatusResponse {
  const factory SearchSessionStatusResponse({
    required String status, // pending|ready|failed
    StageData? stage1,
    StageData? stage2,
    StageData? stage3,
  }) = _SearchSessionStatusResponse;

  factory SearchSessionStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchSessionStatusResponseFromJson(json);
}

@freezed
abstract class StageData with _$StageData {
  const factory StageData({
    required String status,
    Map<String, dynamic>? data,
    String? error,
  }) = _StageData;

  factory StageData.fromJson(Map<String, dynamic> json) =>
      _$StageDataFromJson(json);
}

@freezed
abstract class AIStatusResponse with _$AIStatusResponse {
  const factory AIStatusResponse({
    required String status, // pending, ready, failed
    required String requestId,
    String? createdAt,
    String? updatedAt,
    String? error,
    @Default([]) List<AIResultUpdate> results,
  }) = _AIStatusResponse;

  factory AIStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$AIStatusResponseFromJson(json);
}

@freezed
abstract class AIResultUpdate with _$AIResultUpdate {
  const factory AIResultUpdate({
    required String productId,
    String? productTitle,
    required AIAnalysis aiAnalysis,
  }) = _AIResultUpdate;

  factory AIResultUpdate.fromJson(Map<String, dynamic> json) =>
      _$AIResultUpdateFromJson(json);
}

@freezed
abstract class BarcodeRequest with _$BarcodeRequest {
  const factory BarcodeRequest({
    required String rawValue,
    required String format,
    String? type,
    String? displayValue,
  }) = _BarcodeRequest;

  factory BarcodeRequest.fromJson(Map<String, dynamic> json) =>
      _$BarcodeRequestFromJson(json);
}

@freezed
abstract class ImageRecognitionRequest with _$ImageRecognitionRequest {
  const factory ImageRecognitionRequest({
    String? imageBase64,
    String? imageUrl,
    // ignore: non_constant_identifier_names
    String? image_data,
  }) = _ImageRecognitionRequest;

  factory ImageRecognitionRequest.fromJson(Map<String, dynamic> json) =>
      _$ImageRecognitionRequestFromJson(json);
}
