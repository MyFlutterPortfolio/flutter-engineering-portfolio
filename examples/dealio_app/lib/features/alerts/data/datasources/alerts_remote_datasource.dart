import 'package:dio/dio.dart';
import 'package:untitled5/core/network/api_endpoints.dart';
import 'package:untitled5/features/alerts/data/models/alert_dto.dart';

abstract class AlertsRemoteDataSource {
  Future<void> createOrUpdateAlert({
    required String productId,
    double? targetPrice,
    required String alertType,
    int? cooldownMinutes,
    String? selectedStore,
    String? selectedStoreDomain,
    String? preferredStoreLink,
    double? dropAmount,
    double? dropPercent,
    double? currentObservedPrice,
    String? language,
    String? countryCode,
    bool? realtimeMode,
    bool? autoBuyArmed,
    bool? autoBuyConsent,
    bool? checkoutPrepared,
  });
  Future<RealtimePriceQuoteDto> getRealtimeQuote({
    required String productId,
    String? selectedStore,
    String? selectedStoreDomain,
    String? preferredStoreLink,
    String? language,
    String? countryCode,
  });
  Future<RealtimePriceQuoteDto> getManualLinkQuote({
    required String storeLink,
    String? selectedStore,
    String? language,
    String? countryCode,
  });
  Future<void> createManualLinkAlert({
    required String storeLink,
    double? targetPrice,
    required String alertType,
    int? cooldownMinutes,
    String? selectedStore,
    double? dropAmount,
    double? dropPercent,
    double? currentObservedPrice,
    String? language,
    String? countryCode,
    bool? realtimeMode,
    bool? autoBuyArmed,
    bool? autoBuyConsent,
    bool? checkoutPrepared,
  });
  Future<List<AlertDto>> getAlerts();
  Future<Map<String, dynamic>> getAlertEvents({int limit = 30});
  Future<Map<String, dynamic>> checkAlertsNow();
  Future<void> disableAlert(String alertId);
  Future<void> enableAlert(String alertId);
  Future<void> deleteAlert(String alertId);
}

class AlertsRemoteDataSourceImpl implements AlertsRemoteDataSource {
  final Dio _dio;

  AlertsRemoteDataSourceImpl(this._dio);

  @override
  Future<void> createOrUpdateAlert({
    required String productId,
    double? targetPrice,
    required String alertType,
    int? cooldownMinutes,
    String? selectedStore,
    String? selectedStoreDomain,
    String? preferredStoreLink,
    double? dropAmount,
    double? dropPercent,
    double? currentObservedPrice,
    String? language,
    String? countryCode,
    bool? realtimeMode,
    bool? autoBuyArmed,
    bool? autoBuyConsent,
    bool? checkoutPrepared,
  }) async {
    final data = <String, dynamic>{
      'productId': productId,
      'alertType': alertType,
    };

    if (targetPrice != null) data['targetPrice'] = targetPrice;
    if (cooldownMinutes != null) data['cooldownMinutes'] = cooldownMinutes;
    if (selectedStore != null && selectedStore.trim().isNotEmpty) {
      data['selectedStore'] = selectedStore.trim();
    }
    if (selectedStoreDomain != null && selectedStoreDomain.trim().isNotEmpty) {
      data['selectedStoreDomain'] = selectedStoreDomain.trim();
    }
    if (preferredStoreLink != null && preferredStoreLink.trim().isNotEmpty) {
      data['preferredStoreLink'] = preferredStoreLink.trim();
    }
    if (dropAmount != null) data['dropAmount'] = dropAmount;
    if (dropPercent != null) data['dropPercent'] = dropPercent;
    if (currentObservedPrice != null) {
      data['currentObservedPrice'] = currentObservedPrice;
    }
    if (language != null && language.trim().isNotEmpty) {
      data['language'] = language.trim();
    }
    if (countryCode != null && countryCode.trim().isNotEmpty) {
      data['countryCode'] = countryCode.trim().toUpperCase();
    }
    if (realtimeMode != null) data['realtimeMode'] = realtimeMode;
    if (autoBuyArmed != null) data['autoBuyArmed'] = autoBuyArmed;
    if (autoBuyConsent != null) data['autoBuyConsent'] = autoBuyConsent;
    if (checkoutPrepared != null) data['checkoutPrepared'] = checkoutPrepared;

    await _dio.post(ApiEndpoints.alerts, data: data);
  }

  @override
  Future<RealtimePriceQuoteDto> getRealtimeQuote({
    required String productId,
    String? selectedStore,
    String? selectedStoreDomain,
    String? preferredStoreLink,
    String? language,
    String? countryCode,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.realtimeQuote(productId),
      queryParameters: {
        if (selectedStore != null && selectedStore.isNotEmpty)
          'selectedStore': selectedStore,
        if (selectedStoreDomain != null && selectedStoreDomain.isNotEmpty)
          'selectedStoreDomain': selectedStoreDomain,
        if (preferredStoreLink != null && preferredStoreLink.isNotEmpty)
          'preferredStoreLink': preferredStoreLink,
        if (language != null && language.isNotEmpty) 'language': language,
        if (countryCode != null && countryCode.isNotEmpty)
          'countryCode': countryCode.toUpperCase(),
      },
    );
    return RealtimePriceQuoteDto.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }

  @override
  Future<RealtimePriceQuoteDto> getManualLinkQuote({
    required String storeLink,
    String? selectedStore,
    String? language,
    String? countryCode,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.manualLinkQuote,
      data: {
        'storeLink': storeLink.trim(),
        if (selectedStore != null && selectedStore.trim().isNotEmpty)
          'selectedStore': selectedStore.trim(),
        if (language != null && language.trim().isNotEmpty)
          'language': language.trim(),
        if (countryCode != null && countryCode.trim().isNotEmpty)
          'countryCode': countryCode.trim().toUpperCase(),
      },
    );
    return RealtimePriceQuoteDto.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }

  @override
  Future<void> createManualLinkAlert({
    required String storeLink,
    double? targetPrice,
    required String alertType,
    int? cooldownMinutes,
    String? selectedStore,
    double? dropAmount,
    double? dropPercent,
    double? currentObservedPrice,
    String? language,
    String? countryCode,
    bool? realtimeMode,
    bool? autoBuyArmed,
    bool? autoBuyConsent,
    bool? checkoutPrepared,
  }) async {
    final data = <String, dynamic>{
      'storeLink': storeLink.trim(),
      'alertType': alertType,
    };

    if (targetPrice != null) data['targetPrice'] = targetPrice;
    if (cooldownMinutes != null) data['cooldownMinutes'] = cooldownMinutes;
    if (selectedStore != null && selectedStore.trim().isNotEmpty) {
      data['selectedStore'] = selectedStore.trim();
    }
    if (dropAmount != null) data['dropAmount'] = dropAmount;
    if (dropPercent != null) data['dropPercent'] = dropPercent;
    if (currentObservedPrice != null) {
      data['currentObservedPrice'] = currentObservedPrice;
    }
    if (language != null && language.trim().isNotEmpty) {
      data['language'] = language.trim();
    }
    if (countryCode != null && countryCode.trim().isNotEmpty) {
      data['countryCode'] = countryCode.trim().toUpperCase();
    }
    if (realtimeMode != null) data['realtimeMode'] = realtimeMode;
    if (autoBuyArmed != null) data['autoBuyArmed'] = autoBuyArmed;
    if (autoBuyConsent != null) data['autoBuyConsent'] = autoBuyConsent;
    if (checkoutPrepared != null) data['checkoutPrepared'] = checkoutPrepared;

    await _dio.post(ApiEndpoints.manualLinkAlert, data: data);
  }

  @override
  Future<List<AlertDto>> getAlerts() async {
    final response = await _dio.get(ApiEndpoints.alerts);
    final List<dynamic> data = response.data;
    return data.map((json) => AlertDto.fromJson(json)).toList();
  }

  @override
  Future<Map<String, dynamic>> getAlertEvents({int limit = 30}) async {
    final response = await _dio.get(
      ApiEndpoints.alertEvents,
      queryParameters: {'limit': limit},
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> checkAlertsNow() async {
    final response = await _dio.post(ApiEndpoints.checkAlertsNow);
    return response.data;
  }

  @override
  Future<void> disableAlert(String alertId) async {
    await _dio.patch(ApiEndpoints.disableAlert(alertId));
  }

  @override
  Future<void> enableAlert(String alertId) async {
    await _dio.patch(ApiEndpoints.enableAlert(alertId));
  }

  @override
  Future<void> deleteAlert(String alertId) async {
    await _dio.delete(ApiEndpoints.deleteAlert(alertId));
  }
}
