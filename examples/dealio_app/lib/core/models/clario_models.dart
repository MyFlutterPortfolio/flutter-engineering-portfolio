// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'clario_models.freezed.dart';
part 'clario_models.g.dart';

@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default('medium') String budget,
    @Default([]) List<String> needs,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

@freezed
abstract class ClarioAnalyzeRequest with _$ClarioAnalyzeRequest {
  const factory ClarioAnalyzeRequest({
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_links') @Default([]) List<String> productLinks,
    @JsonKey(name: 'selected_stores') @Default([]) List<String> selectedStores,
    @JsonKey(name: 'user_preferences') required UserPreferences userPreferences,
    @JsonKey(name: 'selected_language') @Default('uz') String selectedLanguage,
  }) = _ClarioAnalyzeRequest;

  factory ClarioAnalyzeRequest.fromJson(Map<String, dynamic> json) =>
      _$ClarioAnalyzeRequestFromJson(json);
}
