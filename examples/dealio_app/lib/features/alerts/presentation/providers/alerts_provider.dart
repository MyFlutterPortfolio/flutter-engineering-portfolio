import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/features/alerts/data/datasources/alerts_remote_datasource.dart';
import 'package:untitled5/features/alerts/data/repositories/alerts_repository_impl.dart';
import 'package:untitled5/features/alerts/domain/entities/alert_entity.dart';
import 'package:untitled5/features/alerts/domain/repositories/alerts_repository.dart';

const Object _errorMessageUnchanged = Object();

final alertsRemoteDataSourceProvider = Provider<AlertsRemoteDataSource>((ref) {
  final dio = ref.watch(apiClientProvider).dio;
  return AlertsRemoteDataSourceImpl(dio);
});

final alertsRepositoryProvider = Provider<AlertsRepository>((ref) {
  final dataSource = ref.watch(alertsRemoteDataSourceProvider);
  return AlertsRepositoryImpl(dataSource);
});

class AlertsState {
  final List<AlertEntity> alerts;
  final bool isLoading;
  final bool isActionInProgress;
  final String? errorMessage;

  const AlertsState({
    this.alerts = const [],
    this.isLoading = false,
    this.isActionInProgress = false,
    this.errorMessage,
  });

  AlertsState copyWith({
    List<AlertEntity>? alerts,
    bool? isLoading,
    bool? isActionInProgress,
    Object? errorMessage = _errorMessageUnchanged,
  }) {
    return AlertsState(
      alerts: alerts ?? this.alerts,
      isLoading: isLoading ?? this.isLoading,
      isActionInProgress: isActionInProgress ?? this.isActionInProgress,
      errorMessage: identical(errorMessage, _errorMessageUnchanged)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

class AlertsNotifier extends StateNotifier<AlertsState> {
  final AlertsRepository _repository;

  AlertsNotifier(this._repository) : super(const AlertsState()) {
    fetchAlerts();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  Future<void> fetchAlerts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final alerts = await _repository.getAlerts();
      state = state.copyWith(
        alerts: alerts,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> createAlert({
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
    state = state.copyWith(isActionInProgress: true, errorMessage: null);
    try {
      await _repository.createOrUpdateAlert(
        productId: productId,
        targetPrice: targetPrice,
        alertType: alertType,
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
      await fetchAlerts();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isActionInProgress: false);
    }
  }

  Future<RealtimePriceQuoteEntity?> getRealtimeQuote({
    required String productId,
    String? selectedStore,
    String? selectedStoreDomain,
    String? preferredStoreLink,
    String? language,
    String? countryCode,
  }) async {
    state = state.copyWith(errorMessage: null);
    try {
      return await _repository.getRealtimeQuote(
        productId: productId,
        selectedStore: selectedStore,
        selectedStoreDomain: selectedStoreDomain,
        preferredStoreLink: preferredStoreLink,
        language: language,
        countryCode: countryCode,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return null;
    }
  }

  Future<RealtimePriceQuoteEntity?> getManualLinkQuote({
    required String storeLink,
    String? selectedStore,
    String? language,
    String? countryCode,
  }) async {
    state = state.copyWith(errorMessage: null);
    try {
      return await _repository.getManualLinkQuote(
        storeLink: storeLink,
        selectedStore: selectedStore,
        language: language,
        countryCode: countryCode,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return null;
    }
  }

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
    state = state.copyWith(isActionInProgress: true, errorMessage: null);
    try {
      await _repository.createManualLinkAlert(
        storeLink: storeLink,
        targetPrice: targetPrice,
        alertType: alertType,
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
      await fetchAlerts();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isActionInProgress: false);
    }
  }

  Future<void> toggleAlert(AlertEntity alert) async {
    final originalAlerts = [...state.alerts];
    final nextActive = !alert.isActive;

    // Optimistic UI update
    final updatedAlerts = state.alerts.map((a) {
      if (a.id == alert.id) {
        return AlertEntity(
          id: a.id,
          productId: a.productId,
          productTitle: a.productTitle,
          productImage: a.productImage,
          targetPrice: a.targetPrice,
          alertType: a.alertType,
          cooldownMinutes: a.cooldownMinutes,
          isActive: nextActive,
          triggeredCount: a.triggeredCount,
          lastTriggeredAt: a.lastTriggeredAt,
          recentEvents: a.recentEvents,
          createdAt: a.createdAt,
        );
      }
      return a;
    }).toList();

    state = state.copyWith(alerts: updatedAlerts);

    try {
      if (nextActive) {
        await _repository.enableAlert(alert.id);
      } else {
        await _repository.disableAlert(alert.id);
      }
    } catch (e) {
      // Rollback on fail
      state = state.copyWith(
        alerts: originalAlerts,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> deleteAlert(String alertId) async {
    final originalAlerts = [...state.alerts];

    // Optimistic UI update
    state = state.copyWith(
      alerts: state.alerts.where((a) => a.id != alertId).toList(),
    );

    try {
      await _repository.deleteAlert(alertId);
    } catch (e) {
      // Rollback
      state = state.copyWith(
        alerts: originalAlerts,
        errorMessage: e.toString(),
      );
    }
  }

  Future<Map<String, dynamic>?> checkNow() async {
    state = state.copyWith(isActionInProgress: true);
    try {
      final result = await _repository.checkAlertsNow();
      await fetchAlerts();
      return result;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return null;
    } finally {
      state = state.copyWith(isActionInProgress: false);
    }
  }
}

final alertsProvider = StateNotifierProvider<AlertsNotifier, AlertsState>((
  ref,
) {
  final repository = ref.watch(alertsRepositoryProvider);
  return AlertsNotifier(repository);
});

final alertEventsProvider = FutureProvider.autoDispose<List<AlertEventEntity>>((
  ref,
) async {
  final repository = ref.watch(alertsRepositoryProvider);
  return repository.getAlertEvents(limit: 30);
});
