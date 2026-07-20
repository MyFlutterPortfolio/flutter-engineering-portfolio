import 'package:dio/dio.dart';
import 'package:untitled5/features/alerts/data/datasources/alerts_remote_datasource.dart';
import 'package:untitled5/features/alerts/data/models/alert_dto.dart';
import 'package:untitled5/features/alerts/domain/entities/alert_entity.dart';
import 'package:untitled5/features/alerts/domain/repositories/alerts_repository.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  final AlertsRemoteDataSource _remoteDataSource;

  AlertsRepositoryImpl(this._remoteDataSource);

  @override
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
  }) async {
    try {
      await _remoteDataSource.createOrUpdateAlert(
        productId: productId,
        targetPrice: targetPrice,
        alertType: alertType.name,
        cooldownMinutes: cooldownMinutes,
        selectedStore: selectedStore,
        selectedStoreDomain: selectedStoreDomain,
        preferredStoreLink: preferredStoreLink,
        dropAmount: dropAmount,
        dropPercent: dropPercent,
        currentObservedPrice: currentObservedPrice,
        language: language,
        countryCode: countryCode,
        realtimeMode: realtimeMode,
        autoBuyArmed: autoBuyArmed,
        autoBuyConsent: autoBuyConsent,
        checkoutPrepared: checkoutPrepared,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    }
  }

  @override
  Future<RealtimePriceQuoteEntity> getRealtimeQuote({
    required String productId,
    String? selectedStore,
    String? selectedStoreDomain,
    String? preferredStoreLink,
    String? language,
    String? countryCode,
  }) async {
    try {
      final dto = await _remoteDataSource.getRealtimeQuote(
        productId: productId,
        selectedStore: selectedStore,
        selectedStoreDomain: selectedStoreDomain,
        preferredStoreLink: preferredStoreLink,
        language: language,
        countryCode: countryCode,
      );
      return dto.toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to fetch realtime quote';
    }
  }

  @override
  Future<RealtimePriceQuoteEntity> getManualLinkQuote({
    required String storeLink,
    String? selectedStore,
    String? language,
    String? countryCode,
  }) async {
    try {
      final dto = await _remoteDataSource.getManualLinkQuote(
        storeLink: storeLink,
        selectedStore: selectedStore,
        language: language,
        countryCode: countryCode,
      );
      return dto.toEntity();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to read price from this link';
    }
  }

  @override
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
  }) async {
    try {
      await _remoteDataSource.createManualLinkAlert(
        storeLink: storeLink,
        targetPrice: targetPrice,
        alertType: alertType.name,
        cooldownMinutes: cooldownMinutes,
        selectedStore: selectedStore,
        dropAmount: dropAmount,
        dropPercent: dropPercent,
        currentObservedPrice: currentObservedPrice,
        language: language,
        countryCode: countryCode,
        realtimeMode: realtimeMode,
        autoBuyArmed: autoBuyArmed,
        autoBuyConsent: autoBuyConsent,
        checkoutPrepared: checkoutPrepared,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to create alert from this link';
    }
  }

  @override
  Future<List<AlertEntity>> getAlerts() async {
    try {
      final dtos = await _remoteDataSource.getAlerts();
      return dtos.map((dto) => dto.toEntity()).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to load alerts';
    }
  }

  @override
  Future<List<AlertEventEntity>> getAlertEvents({int limit = 30}) async {
    try {
      final data = await _remoteDataSource.getAlertEvents(limit: limit);
      final List<dynamic> eventsJson = data['events'] ?? [];
      return eventsJson
          .map((json) => AlertEventDto.fromJson(json).toEntity())
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to load alert history';
    }
  }

  @override
  Future<Map<String, dynamic>> checkAlertsNow() async {
    try {
      return await _remoteDataSource.checkAlertsNow();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to check alerts';
    }
  }

  @override
  Future<void> disableAlert(String alertId) async {
    try {
      await _remoteDataSource.disableAlert(alertId);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to disable alert';
    }
  }

  @override
  Future<void> enableAlert(String alertId) async {
    try {
      await _remoteDataSource.enableAlert(alertId);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to enable alert';
    }
  }

  @override
  Future<void> deleteAlert(String alertId) async {
    try {
      await _remoteDataSource.deleteAlert(alertId);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to delete alert';
    }
  }

  String _handleDioError(DioException e) {
    if (e.response?.data != null && e.response?.data is Map) {
      final data = Map<String, dynamic>.from(e.response!.data as Map);
      final code = data['code']?.toString();
      if (code == 'MONTHLY_PRICE_ALERT_LIMIT_REACHED') {
        final quota = Map<String, dynamic>.from((data['quota'] as Map?) ?? {});
        final used = quota['used']?.toString();
        final limit = quota['limit']?.toString();
        final suffix = used != null && limit != null
            ? ' ($used/$limit used)'
            : '';
        return 'Monthly price alert limit reached$suffix. Upgrade to create more alerts.';
      }
      final error = data['error'];
      final message = data['message'];
      if (error is String && error.trim().isNotEmpty) {
        return error;
      }
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
      return 'Server error occurred';
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet.';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
