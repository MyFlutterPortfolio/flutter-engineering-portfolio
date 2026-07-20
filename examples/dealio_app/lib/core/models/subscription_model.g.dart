// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanCapabilities _$PlanCapabilitiesFromJson(Map<String, dynamic> json) =>
    _PlanCapabilities(
      searchLimitPerMonth: (json['searchLimitPerMonth'] as num?)?.toInt(),
      searchProvider: json['searchProvider'] as String?,
      aiAnalysis: json['aiAnalysis'] as bool? ?? false,
      deepSeekChat: json['deepSeekChat'] as bool? ?? false,
      barcode: json['barcode'] as bool? ?? false,
      reviews: json['reviews'] as bool? ?? false,
      selectedStoreSearch: json['selectedStoreSearch'] as bool? ?? false,
      maxSelectedStores: (json['maxSelectedStores'] as num?)?.toInt() ?? 0,
      superAlerts: json['superAlerts'] as bool? ?? false,
    );

Map<String, dynamic> _$PlanCapabilitiesToJson(_PlanCapabilities instance) =>
    <String, dynamic>{
      'searchLimitPerMonth': instance.searchLimitPerMonth,
      'searchProvider': instance.searchProvider,
      'aiAnalysis': instance.aiAnalysis,
      'deepSeekChat': instance.deepSeekChat,
      'barcode': instance.barcode,
      'reviews': instance.reviews,
      'selectedStoreSearch': instance.selectedStoreSearch,
      'maxSelectedStores': instance.maxSelectedStores,
      'superAlerts': instance.superAlerts,
    };

_SearchQuota _$SearchQuotaFromJson(Map<String, dynamic> json) => _SearchQuota(
  used: (json['used'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  remaining: (json['remaining'] as num).toInt(),
  resetAt: json['resetAt'] as String,
  allowed: json['allowed'] as bool,
);

Map<String, dynamic> _$SearchQuotaToJson(_SearchQuota instance) =>
    <String, dynamic>{
      'used': instance.used,
      'limit': instance.limit,
      'remaining': instance.remaining,
      'resetAt': instance.resetAt,
      'allowed': instance.allowed,
    };

_QuotaInfo _$QuotaInfoFromJson(Map<String, dynamic> json) => _QuotaInfo(
  search: SearchQuota.fromJson(json['search'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuotaInfoToJson(_QuotaInfo instance) =>
    <String, dynamic>{'search': instance.search};

_Subscription _$SubscriptionFromJson(Map<String, dynamic> json) =>
    _Subscription(
      userId: json['userId'] as String,
      plan:
          $enumDecodeNullable(_$SubscriptionPlanEnumMap, json['plan']) ??
          SubscriptionPlan.FREE,
      status:
          $enumDecodeNullable(_$SubscriptionStatusEnumMap, json['status']) ??
          SubscriptionStatus.NONE,
      provider: json['provider'] as String?,
      productId: json['productId'] as String?,
      expiresAt: json['expiresAt'] as String?,
    );

Map<String, dynamic> _$SubscriptionToJson(_Subscription instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'plan': _$SubscriptionPlanEnumMap[instance.plan]!,
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'provider': instance.provider,
      'productId': instance.productId,
      'expiresAt': instance.expiresAt,
    };

const _$SubscriptionPlanEnumMap = {
  SubscriptionPlan.FREE: 'FREE',
  SubscriptionPlan.PLUS: 'PLUS',
  SubscriptionPlan.PRO: 'PRO',
  SubscriptionPlan.KVONT: 'KVONT',
};

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.ACTIVE: 'ACTIVE',
  SubscriptionStatus.EXPIRED: 'EXPIRED',
  SubscriptionStatus.CANCELED: 'CANCELED',
  SubscriptionStatus.PENDING: 'PENDING',
  SubscriptionStatus.NONE: 'NONE',
};

_BillingStatusResponse _$BillingStatusResponseFromJson(
  Map<String, dynamic> json,
) => _BillingStatusResponse(
  subscription: Subscription.fromJson(
    json['subscription'] as Map<String, dynamic>,
  ),
  capabilities: PlanCapabilities.fromJson(
    json['capabilities'] as Map<String, dynamic>,
  ),
  quota: QuotaInfo.fromJson(json['quota'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BillingStatusResponseToJson(
  _BillingStatusResponse instance,
) => <String, dynamic>{
  'subscription': instance.subscription,
  'capabilities': instance.capabilities,
  'quota': instance.quota,
};

_ActivateGooglePlayRequest _$ActivateGooglePlayRequestFromJson(
  Map<String, dynamic> json,
) => _ActivateGooglePlayRequest(
  subscriptionId: json['subscriptionId'] as String,
  purchaseToken: json['purchaseToken'] as String,
  orderId: json['orderId'] as String,
  packageName: json['packageName'] as String,
);

Map<String, dynamic> _$ActivateGooglePlayRequestToJson(
  _ActivateGooglePlayRequest instance,
) => <String, dynamic>{
  'subscriptionId': instance.subscriptionId,
  'purchaseToken': instance.purchaseToken,
  'orderId': instance.orderId,
  'packageName': instance.packageName,
};
