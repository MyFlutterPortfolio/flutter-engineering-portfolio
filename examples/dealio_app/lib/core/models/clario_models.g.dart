// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clario_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    _UserPreferences(
      budget: json['budget'] as String? ?? 'medium',
      needs:
          (json['needs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$UserPreferencesToJson(_UserPreferences instance) =>
    <String, dynamic>{'budget': instance.budget, 'needs': instance.needs};

_ClarioAnalyzeRequest _$ClarioAnalyzeRequestFromJson(
  Map<String, dynamic> json,
) => _ClarioAnalyzeRequest(
  productName: json['product_name'] as String,
  productLinks:
      (json['product_links'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  selectedStores:
      (json['selected_stores'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  userPreferences: UserPreferences.fromJson(
    json['user_preferences'] as Map<String, dynamic>,
  ),
  selectedLanguage: json['selected_language'] as String? ?? 'uz',
);

Map<String, dynamic> _$ClarioAnalyzeRequestToJson(
  _ClarioAnalyzeRequest instance,
) => <String, dynamic>{
  'product_name': instance.productName,
  'product_links': instance.productLinks,
  'selected_stores': instance.selectedStores,
  'user_preferences': instance.userPreferences,
  'selected_language': instance.selectedLanguage,
};
