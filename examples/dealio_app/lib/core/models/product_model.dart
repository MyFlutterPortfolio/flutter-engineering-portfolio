// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    @Default('') String modelName,
    @Default('') String title,
    @Default('') String description,
    @Default({}) Map<String, dynamic> specifications,
    String? technicalProfile,
    @Default('') String brand,
    @Default('') String category,
    String? cachedAt,
    String? imageUrl,
    @Default([]) List<DynamicPrice> dynamicPrices,
    AIAnalysis? aiAnalysis,
    NeedsMatchAnalysis? needsMatch,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
abstract class AIAnalysis with _$AIAnalysis {
  const factory AIAnalysis({
    // Legacy fields for backward compatibility with existing UI
    double? sentimentScore,
    String? trustLevel,
    double? valueScore,
    @Default([]) List<String> pros,
    @Default([]) List<String> cons,

    // New Clario backend fields
    double? needsMatchScore,
    @JsonKey(name: 'fit_summary') String? fitSummary,
    @JsonKey(name: 'recommendation_for_user') String? recommendationForUser,
    @JsonKey(name: 'budget_fit') String? budgetFit,
    double? confidence,
    @JsonKey(name: 'authenticity_report') String? authenticityReport,
    @JsonKey(name: 'market_sentiment') String? marketSentiment,
    @JsonKey(name: 'pros_for_user') @Default([]) List<String> prosForUser,
    @JsonKey(name: 'cons_for_user') @Default([]) List<String> consForUser,
    @JsonKey(name: 'caution_flags') @Default([]) List<String> cautionFlags,
    @JsonKey(name: 'action_plan') String? actionPlan,
    @JsonKey(name: 'final_shopping_verdict') String? finalShoppingVerdict,
    String? reasoning,
    @Default([]) List<String> alternatives,
    @JsonKey(name: 'estimatedDeliveryDays') int? estimatedDeliveryDays,
  }) = _AIAnalysis;

  factory AIAnalysis.fromJson(Map<String, dynamic> json) =>
      _$AIAnalysisFromJson(json);
}

@freezed
abstract class NeedsMatchAnalysis with _$NeedsMatchAnalysis {
  const factory NeedsMatchAnalysis({
    required double matchPercentage,
    required String summary,
    required String compatibilityText,
    required List<MatchReason> reasons,
    required String userPreferenceNote,
    required String aiNoteResponse,
  }) = _NeedsMatchAnalysis;

  factory NeedsMatchAnalysis.fromJson(Map<String, dynamic> json) =>
      _$NeedsMatchAnalysisFromJson(json);
}

@freezed
abstract class MatchReason with _$MatchReason {
  const factory MatchReason({
    required String title,
    required String content,
    required String iconType,
  }) = _MatchReason;

  factory MatchReason.fromJson(Map<String, dynamic> json) =>
      _$MatchReasonFromJson(json);
}

@freezed
abstract class DynamicPrice with _$DynamicPrice {
  const factory DynamicPrice({
    required String store,
    required double price,
    @Default('USD') String currency,
    @Default('') String link,
    @Default(true) bool availability,
    @Default(0) int stock,
    String? updateTime,
  }) = _DynamicPrice;

  factory DynamicPrice.fromJson(Map<String, dynamic> json) =>
      _$DynamicPriceFromJson(json);
}
