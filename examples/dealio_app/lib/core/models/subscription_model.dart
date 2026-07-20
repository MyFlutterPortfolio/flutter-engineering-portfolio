import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

// ignore: constant_identifier_names
enum SubscriptionPlan { FREE, PLUS, PRO, KVONT }

// ignore: constant_identifier_names
enum SubscriptionStatus { ACTIVE, EXPIRED, CANCELED, PENDING, NONE }

@freezed
abstract class PlanCapabilities with _$PlanCapabilities {
  const factory PlanCapabilities({
    int? searchLimitPerMonth,
    String? searchProvider,
    @Default(false) bool aiAnalysis,
    @Default(false) bool deepSeekChat,
    @Default(false) bool barcode,
    @Default(false) bool reviews,
    @Default(false) bool selectedStoreSearch,
    @Default(0) int maxSelectedStores,
    @Default(false) bool superAlerts,
  }) = _PlanCapabilities;

  factory PlanCapabilities.fromJson(Map<String, dynamic> json) =>
      _$PlanCapabilitiesFromJson(json);
}

@freezed
abstract class SearchQuota with _$SearchQuota {
  const factory SearchQuota({
    required int used,
    required int limit,
    required int remaining,
    required String resetAt,
    required bool allowed,
  }) = _SearchQuota;

  factory SearchQuota.fromJson(Map<String, dynamic> json) =>
      _$SearchQuotaFromJson(json);
}

@freezed
abstract class QuotaInfo with _$QuotaInfo {
  const factory QuotaInfo({required SearchQuota search}) = _QuotaInfo;

  factory QuotaInfo.fromJson(Map<String, dynamic> json) =>
      _$QuotaInfoFromJson(json);
}

@freezed
abstract class Subscription with _$Subscription {
  const factory Subscription({
    required String userId,
    @Default(SubscriptionPlan.FREE) SubscriptionPlan plan,
    @Default(SubscriptionStatus.NONE) SubscriptionStatus status,
    String? provider,
    String? productId,
    String? expiresAt,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
}

@freezed
abstract class BillingStatusResponse with _$BillingStatusResponse {
  const BillingStatusResponse._();

  const factory BillingStatusResponse({
    required Subscription subscription,
    required PlanCapabilities capabilities,
    required QuotaInfo quota,
  }) = _BillingStatusResponse;

  factory BillingStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$BillingStatusResponseFromJson(json);

  bool get proPlusAccess => subscription.plan != SubscriptionPlan.FREE;
}

@freezed
abstract class ActivateGooglePlayRequest with _$ActivateGooglePlayRequest {
  const factory ActivateGooglePlayRequest({
    required String subscriptionId,
    required String purchaseToken,
    required String orderId,
    required String packageName,
  }) = _ActivateGooglePlayRequest;

  factory ActivateGooglePlayRequest.fromJson(Map<String, dynamic> json) =>
      _$ActivateGooglePlayRequestFromJson(json);
}
