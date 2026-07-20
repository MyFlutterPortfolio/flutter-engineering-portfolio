import 'package:untitled5/features/alerts/domain/entities/alert_entity.dart';

abstract class AlertsRepository {
  Future<void> createOrUpdateAlert({
    required String productId,
    double? targetPrice,
    required AlertType alertType,
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
  Future<RealtimePriceQuoteEntity> getRealtimeQuote({
    required String productId,
    String? selectedStore,
    String? selectedStoreDomain,
    String? preferredStoreLink,
    String? language,
    String? countryCode,
  });
  Future<RealtimePriceQuoteEntity> getManualLinkQuote({
    required String storeLink,
    String? selectedStore,
    String? language,
    String? countryCode,
  });
  Future<void> createManualLinkAlert({
    required String storeLink,
    double? targetPrice,
    required AlertType alertType,
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
  Future<List<AlertEntity>> getAlerts();
  Future<List<AlertEventEntity>> getAlertEvents({int limit = 30});
  Future<Map<String, dynamic>> checkAlertsNow();
  Future<void> disableAlert(String alertId);
  Future<void> enableAlert(String alertId);
  Future<void> deleteAlert(String alertId);
}
