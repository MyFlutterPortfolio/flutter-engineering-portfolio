// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  modelName: json['modelName'] as String? ?? '',
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  specifications: json['specifications'] as Map<String, dynamic>? ?? const {},
  technicalProfile: json['technicalProfile'] as String?,
  brand: json['brand'] as String? ?? '',
  category: json['category'] as String? ?? '',
  cachedAt: json['cachedAt'] as String?,
  imageUrl: json['imageUrl'] as String?,
  dynamicPrices:
      (json['dynamicPrices'] as List<dynamic>?)
          ?.map((e) => DynamicPrice.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  aiAnalysis: json['aiAnalysis'] == null
      ? null
      : AIAnalysis.fromJson(json['aiAnalysis'] as Map<String, dynamic>),
  needsMatch: json['needsMatch'] == null
      ? null
      : NeedsMatchAnalysis.fromJson(json['needsMatch'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'modelName': instance.modelName,
  'title': instance.title,
  'description': instance.description,
  'specifications': instance.specifications,
  'technicalProfile': instance.technicalProfile,
  'brand': instance.brand,
  'category': instance.category,
  'cachedAt': instance.cachedAt,
  'imageUrl': instance.imageUrl,
  'dynamicPrices': instance.dynamicPrices,
  'aiAnalysis': instance.aiAnalysis,
  'needsMatch': instance.needsMatch,
};

_AIAnalysis _$AIAnalysisFromJson(Map<String, dynamic> json) => _AIAnalysis(
  sentimentScore: (json['sentimentScore'] as num?)?.toDouble(),
  trustLevel: json['trustLevel'] as String?,
  valueScore: (json['valueScore'] as num?)?.toDouble(),
  pros:
      (json['pros'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  cons:
      (json['cons'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  needsMatchScore: (json['needsMatchScore'] as num?)?.toDouble(),
  fitSummary: json['fit_summary'] as String?,
  recommendationForUser: json['recommendation_for_user'] as String?,
  budgetFit: json['budget_fit'] as String?,
  confidence: (json['confidence'] as num?)?.toDouble(),
  authenticityReport: json['authenticity_report'] as String?,
  marketSentiment: json['market_sentiment'] as String?,
  prosForUser:
      (json['pros_for_user'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  consForUser:
      (json['cons_for_user'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  cautionFlags:
      (json['caution_flags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  actionPlan: json['action_plan'] as String?,
  finalShoppingVerdict: json['final_shopping_verdict'] as String?,
  reasoning: json['reasoning'] as String?,
  alternatives:
      (json['alternatives'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  estimatedDeliveryDays: (json['estimatedDeliveryDays'] as num?)?.toInt(),
);

Map<String, dynamic> _$AIAnalysisToJson(_AIAnalysis instance) =>
    <String, dynamic>{
      'sentimentScore': instance.sentimentScore,
      'trustLevel': instance.trustLevel,
      'valueScore': instance.valueScore,
      'pros': instance.pros,
      'cons': instance.cons,
      'needsMatchScore': instance.needsMatchScore,
      'fit_summary': instance.fitSummary,
      'recommendation_for_user': instance.recommendationForUser,
      'budget_fit': instance.budgetFit,
      'confidence': instance.confidence,
      'authenticity_report': instance.authenticityReport,
      'market_sentiment': instance.marketSentiment,
      'pros_for_user': instance.prosForUser,
      'cons_for_user': instance.consForUser,
      'caution_flags': instance.cautionFlags,
      'action_plan': instance.actionPlan,
      'final_shopping_verdict': instance.finalShoppingVerdict,
      'reasoning': instance.reasoning,
      'alternatives': instance.alternatives,
      'estimatedDeliveryDays': instance.estimatedDeliveryDays,
    };

_NeedsMatchAnalysis _$NeedsMatchAnalysisFromJson(Map<String, dynamic> json) =>
    _NeedsMatchAnalysis(
      matchPercentage: (json['matchPercentage'] as num).toDouble(),
      summary: json['summary'] as String,
      compatibilityText: json['compatibilityText'] as String,
      reasons: (json['reasons'] as List<dynamic>)
          .map((e) => MatchReason.fromJson(e as Map<String, dynamic>))
          .toList(),
      userPreferenceNote: json['userPreferenceNote'] as String,
      aiNoteResponse: json['aiNoteResponse'] as String,
    );

Map<String, dynamic> _$NeedsMatchAnalysisToJson(_NeedsMatchAnalysis instance) =>
    <String, dynamic>{
      'matchPercentage': instance.matchPercentage,
      'summary': instance.summary,
      'compatibilityText': instance.compatibilityText,
      'reasons': instance.reasons,
      'userPreferenceNote': instance.userPreferenceNote,
      'aiNoteResponse': instance.aiNoteResponse,
    };

_MatchReason _$MatchReasonFromJson(Map<String, dynamic> json) => _MatchReason(
  title: json['title'] as String,
  content: json['content'] as String,
  iconType: json['iconType'] as String,
);

Map<String, dynamic> _$MatchReasonToJson(_MatchReason instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'iconType': instance.iconType,
    };

_DynamicPrice _$DynamicPriceFromJson(Map<String, dynamic> json) =>
    _DynamicPrice(
      store: json['store'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      link: json['link'] as String? ?? '',
      availability: json['availability'] as bool? ?? true,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      updateTime: json['updateTime'] as String?,
    );

Map<String, dynamic> _$DynamicPriceToJson(_DynamicPrice instance) =>
    <String, dynamic>{
      'store': instance.store,
      'price': instance.price,
      'currency': instance.currency,
      'link': instance.link,
      'availability': instance.availability,
      'stock': instance.stock,
      'updateTime': instance.updateTime,
    };
