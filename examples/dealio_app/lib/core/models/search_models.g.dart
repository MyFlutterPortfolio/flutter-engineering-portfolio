// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Country _$CountryFromJson(Map<String, dynamic> json) => _Country(
  code: json['code'] as String,
  name: json['name'] as String,
  gl: json['gl'] as String,
  hl: json['hl'] as String,
  location: json['location'] as String,
);

Map<String, dynamic> _$CountryToJson(_Country instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'gl': instance.gl,
  'hl': instance.hl,
  'location': instance.location,
};

_Store _$StoreFromJson(Map<String, dynamic> json) => _Store(
  name: json['name'] as String,
  domains: (json['domains'] as List<dynamic>).map((e) => e as String).toList(),
  countryCode: json['countryCode'] as String,
);

Map<String, dynamic> _$StoreToJson(_Store instance) => <String, dynamic>{
  'name': instance.name,
  'domains': instance.domains,
  'countryCode': instance.countryCode,
};

_StoreOffer _$StoreOfferFromJson(Map<String, dynamic> json) => _StoreOffer(
  store: json['store'] as String,
  price: (json['price'] as num).toDouble(),
  currency: json['currency'] as String,
  link: json['link'] as String,
  availability: json['availability'] as bool,
  stock: (json['stock'] as num).toInt(),
  productTitle: json['productTitle'] as String?,
  productId: json['productId'] as String?,
);

Map<String, dynamic> _$StoreOfferToJson(_StoreOffer instance) =>
    <String, dynamic>{
      'store': instance.store,
      'price': instance.price,
      'currency': instance.currency,
      'link': instance.link,
      'availability': instance.availability,
      'stock': instance.stock,
      'productTitle': instance.productTitle,
      'productId': instance.productId,
    };

_SearchRequest _$SearchRequestFromJson(Map<String, dynamic> json) =>
    _SearchRequest(
      query: json['query'] as String,
      country: json['country'] as String,
      storeScope: json['storeScope'] as String? ?? 'global',
      budget: (json['budget'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      language: json['language'] as String? ?? 'en',
      location: json['location'] as String?,
      selectedStores: (json['selectedStores'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SearchRequestToJson(_SearchRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'country': instance.country,
      'storeScope': instance.storeScope,
      'budget': instance.budget,
      'notes': instance.notes,
      'language': instance.language,
      'location': instance.location,
      'selectedStores': instance.selectedStores,
    };

_SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    _SearchResponse(
      query: json['query'] as String,
      count: (json['count'] as num?)?.toInt() ?? 0,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      country: json['country'] as String,
      storeScope: json['storeScope'] as String? ?? 'global',
      selectedStores:
          (json['selectedStores'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      selectedStoreLinks:
          (json['selectedStoreLinks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      storeOffers:
          (json['storeOffers'] as List<dynamic>?)
              ?.map((e) => StoreOffer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      aiAnalysisDeferred: json['aiAnalysisDeferred'] as bool? ?? false,
      requestId: json['requestId'] as String?,
      stage: (json['stage'] as num?)?.toInt(),
      isPartial: json['isPartial'] as bool?,
      nextPollMs: (json['nextPollMs'] as num?)?.toInt(),
      statusEndpoint: json['statusEndpoint'] as String?,
      stage1Source: json['stage1Source'] as String?,
      aiSummaryRequestId: json['aiSummaryRequestId'] as String?,
      timestamp: json['timestamp'] as String?,
      plan: $enumDecodeNullable(_$SubscriptionPlanEnumMap, json['plan']),
      searchProvider: json['searchProvider'] as String?,
      quota: json['quota'] == null
          ? null
          : QuotaInfo.fromJson(json['quota'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResponseToJson(_SearchResponse instance) =>
    <String, dynamic>{
      'query': instance.query,
      'count': instance.count,
      'results': instance.results,
      'country': instance.country,
      'storeScope': instance.storeScope,
      'selectedStores': instance.selectedStores,
      'selectedStoreLinks': instance.selectedStoreLinks,
      'storeOffers': instance.storeOffers,
      'aiAnalysisDeferred': instance.aiAnalysisDeferred,
      'requestId': instance.requestId,
      'stage': instance.stage,
      'isPartial': instance.isPartial,
      'nextPollMs': instance.nextPollMs,
      'statusEndpoint': instance.statusEndpoint,
      'stage1Source': instance.stage1Source,
      'aiSummaryRequestId': instance.aiSummaryRequestId,
      'timestamp': instance.timestamp,
      'plan': _$SubscriptionPlanEnumMap[instance.plan],
      'searchProvider': instance.searchProvider,
      'quota': instance.quota,
    };

const _$SubscriptionPlanEnumMap = {
  SubscriptionPlan.FREE: 'FREE',
  SubscriptionPlan.PLUS: 'PLUS',
  SubscriptionPlan.PRO: 'PRO',
  SubscriptionPlan.KVONT: 'KVONT',
};

_SearchSessionStatusResponse _$SearchSessionStatusResponseFromJson(
  Map<String, dynamic> json,
) => _SearchSessionStatusResponse(
  status: json['status'] as String,
  stage1: json['stage1'] == null
      ? null
      : StageData.fromJson(json['stage1'] as Map<String, dynamic>),
  stage2: json['stage2'] == null
      ? null
      : StageData.fromJson(json['stage2'] as Map<String, dynamic>),
  stage3: json['stage3'] == null
      ? null
      : StageData.fromJson(json['stage3'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SearchSessionStatusResponseToJson(
  _SearchSessionStatusResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'stage1': instance.stage1,
  'stage2': instance.stage2,
  'stage3': instance.stage3,
};

_StageData _$StageDataFromJson(Map<String, dynamic> json) => _StageData(
  status: json['status'] as String,
  data: json['data'] as Map<String, dynamic>?,
  error: json['error'] as String?,
);

Map<String, dynamic> _$StageDataToJson(_StageData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'error': instance.error,
    };

_AIStatusResponse _$AIStatusResponseFromJson(Map<String, dynamic> json) =>
    _AIStatusResponse(
      status: json['status'] as String,
      requestId: json['requestId'] as String,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      error: json['error'] as String?,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => AIResultUpdate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AIStatusResponseToJson(_AIStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'requestId': instance.requestId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'error': instance.error,
      'results': instance.results,
    };

_AIResultUpdate _$AIResultUpdateFromJson(Map<String, dynamic> json) =>
    _AIResultUpdate(
      productId: json['productId'] as String,
      productTitle: json['productTitle'] as String?,
      aiAnalysis: AIAnalysis.fromJson(
        json['aiAnalysis'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AIResultUpdateToJson(_AIResultUpdate instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productTitle': instance.productTitle,
      'aiAnalysis': instance.aiAnalysis,
    };

_BarcodeRequest _$BarcodeRequestFromJson(Map<String, dynamic> json) =>
    _BarcodeRequest(
      rawValue: json['rawValue'] as String,
      format: json['format'] as String,
      type: json['type'] as String?,
      displayValue: json['displayValue'] as String?,
    );

Map<String, dynamic> _$BarcodeRequestToJson(_BarcodeRequest instance) =>
    <String, dynamic>{
      'rawValue': instance.rawValue,
      'format': instance.format,
      'type': instance.type,
      'displayValue': instance.displayValue,
    };

_ImageRecognitionRequest _$ImageRecognitionRequestFromJson(
  Map<String, dynamic> json,
) => _ImageRecognitionRequest(
  imageBase64: json['imageBase64'] as String?,
  imageUrl: json['imageUrl'] as String?,
  image_data: json['image_data'] as String?,
);

Map<String, dynamic> _$ImageRecognitionRequestToJson(
  _ImageRecognitionRequest instance,
) => <String, dynamic>{
  'imageBase64': instance.imageBase64,
  'imageUrl': instance.imageUrl,
  'image_data': instance.image_data,
};
