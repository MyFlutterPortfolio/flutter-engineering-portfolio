// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {

 String get id; String get modelName; String get title; String get description; Map<String, dynamic> get specifications; String? get technicalProfile; String get brand; String get category; String? get cachedAt; String? get imageUrl; List<DynamicPrice> get dynamicPrices; AIAnalysis? get aiAnalysis; NeedsMatchAnalysis? get needsMatch;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.modelName, modelName) || other.modelName == modelName)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.specifications, specifications)&&(identical(other.technicalProfile, technicalProfile) || other.technicalProfile == technicalProfile)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.category, category) || other.category == category)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.dynamicPrices, dynamicPrices)&&(identical(other.aiAnalysis, aiAnalysis) || other.aiAnalysis == aiAnalysis)&&(identical(other.needsMatch, needsMatch) || other.needsMatch == needsMatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,modelName,title,description,const DeepCollectionEquality().hash(specifications),technicalProfile,brand,category,cachedAt,imageUrl,const DeepCollectionEquality().hash(dynamicPrices),aiAnalysis,needsMatch);

@override
String toString() {
  return 'Product(id: $id, modelName: $modelName, title: $title, description: $description, specifications: $specifications, technicalProfile: $technicalProfile, brand: $brand, category: $category, cachedAt: $cachedAt, imageUrl: $imageUrl, dynamicPrices: $dynamicPrices, aiAnalysis: $aiAnalysis, needsMatch: $needsMatch)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 String id, String modelName, String title, String description, Map<String, dynamic> specifications, String? technicalProfile, String brand, String category, String? cachedAt, String? imageUrl, List<DynamicPrice> dynamicPrices, AIAnalysis? aiAnalysis, NeedsMatchAnalysis? needsMatch
});


$AIAnalysisCopyWith<$Res>? get aiAnalysis;$NeedsMatchAnalysisCopyWith<$Res>? get needsMatch;

}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? modelName = null,Object? title = null,Object? description = null,Object? specifications = null,Object? technicalProfile = freezed,Object? brand = null,Object? category = null,Object? cachedAt = freezed,Object? imageUrl = freezed,Object? dynamicPrices = null,Object? aiAnalysis = freezed,Object? needsMatch = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,modelName: null == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,specifications: null == specifications ? _self.specifications : specifications // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,technicalProfile: freezed == technicalProfile ? _self.technicalProfile : technicalProfile // ignore: cast_nullable_to_non_nullable
as String?,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,cachedAt: freezed == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,dynamicPrices: null == dynamicPrices ? _self.dynamicPrices : dynamicPrices // ignore: cast_nullable_to_non_nullable
as List<DynamicPrice>,aiAnalysis: freezed == aiAnalysis ? _self.aiAnalysis : aiAnalysis // ignore: cast_nullable_to_non_nullable
as AIAnalysis?,needsMatch: freezed == needsMatch ? _self.needsMatch : needsMatch // ignore: cast_nullable_to_non_nullable
as NeedsMatchAnalysis?,
  ));
}
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AIAnalysisCopyWith<$Res>? get aiAnalysis {
    if (_self.aiAnalysis == null) {
    return null;
  }

  return $AIAnalysisCopyWith<$Res>(_self.aiAnalysis!, (value) {
    return _then(_self.copyWith(aiAnalysis: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NeedsMatchAnalysisCopyWith<$Res>? get needsMatch {
    if (_self.needsMatch == null) {
    return null;
  }

  return $NeedsMatchAnalysisCopyWith<$Res>(_self.needsMatch!, (value) {
    return _then(_self.copyWith(needsMatch: value));
  });
}
}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String modelName,  String title,  String description,  Map<String, dynamic> specifications,  String? technicalProfile,  String brand,  String category,  String? cachedAt,  String? imageUrl,  List<DynamicPrice> dynamicPrices,  AIAnalysis? aiAnalysis,  NeedsMatchAnalysis? needsMatch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.modelName,_that.title,_that.description,_that.specifications,_that.technicalProfile,_that.brand,_that.category,_that.cachedAt,_that.imageUrl,_that.dynamicPrices,_that.aiAnalysis,_that.needsMatch);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String modelName,  String title,  String description,  Map<String, dynamic> specifications,  String? technicalProfile,  String brand,  String category,  String? cachedAt,  String? imageUrl,  List<DynamicPrice> dynamicPrices,  AIAnalysis? aiAnalysis,  NeedsMatchAnalysis? needsMatch)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.modelName,_that.title,_that.description,_that.specifications,_that.technicalProfile,_that.brand,_that.category,_that.cachedAt,_that.imageUrl,_that.dynamicPrices,_that.aiAnalysis,_that.needsMatch);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String modelName,  String title,  String description,  Map<String, dynamic> specifications,  String? technicalProfile,  String brand,  String category,  String? cachedAt,  String? imageUrl,  List<DynamicPrice> dynamicPrices,  AIAnalysis? aiAnalysis,  NeedsMatchAnalysis? needsMatch)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.modelName,_that.title,_that.description,_that.specifications,_that.technicalProfile,_that.brand,_that.category,_that.cachedAt,_that.imageUrl,_that.dynamicPrices,_that.aiAnalysis,_that.needsMatch);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Product implements Product {
  const _Product({required this.id, this.modelName = '', this.title = '', this.description = '', final  Map<String, dynamic> specifications = const {}, this.technicalProfile, this.brand = '', this.category = '', this.cachedAt, this.imageUrl, final  List<DynamicPrice> dynamicPrices = const [], this.aiAnalysis, this.needsMatch}): _specifications = specifications,_dynamicPrices = dynamicPrices;
  factory _Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

@override final  String id;
@override@JsonKey() final  String modelName;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
 final  Map<String, dynamic> _specifications;
@override@JsonKey() Map<String, dynamic> get specifications {
  if (_specifications is EqualUnmodifiableMapView) return _specifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_specifications);
}

@override final  String? technicalProfile;
@override@JsonKey() final  String brand;
@override@JsonKey() final  String category;
@override final  String? cachedAt;
@override final  String? imageUrl;
 final  List<DynamicPrice> _dynamicPrices;
@override@JsonKey() List<DynamicPrice> get dynamicPrices {
  if (_dynamicPrices is EqualUnmodifiableListView) return _dynamicPrices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dynamicPrices);
}

@override final  AIAnalysis? aiAnalysis;
@override final  NeedsMatchAnalysis? needsMatch;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.modelName, modelName) || other.modelName == modelName)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._specifications, _specifications)&&(identical(other.technicalProfile, technicalProfile) || other.technicalProfile == technicalProfile)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.category, category) || other.category == category)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._dynamicPrices, _dynamicPrices)&&(identical(other.aiAnalysis, aiAnalysis) || other.aiAnalysis == aiAnalysis)&&(identical(other.needsMatch, needsMatch) || other.needsMatch == needsMatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,modelName,title,description,const DeepCollectionEquality().hash(_specifications),technicalProfile,brand,category,cachedAt,imageUrl,const DeepCollectionEquality().hash(_dynamicPrices),aiAnalysis,needsMatch);

@override
String toString() {
  return 'Product(id: $id, modelName: $modelName, title: $title, description: $description, specifications: $specifications, technicalProfile: $technicalProfile, brand: $brand, category: $category, cachedAt: $cachedAt, imageUrl: $imageUrl, dynamicPrices: $dynamicPrices, aiAnalysis: $aiAnalysis, needsMatch: $needsMatch)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String modelName, String title, String description, Map<String, dynamic> specifications, String? technicalProfile, String brand, String category, String? cachedAt, String? imageUrl, List<DynamicPrice> dynamicPrices, AIAnalysis? aiAnalysis, NeedsMatchAnalysis? needsMatch
});


@override $AIAnalysisCopyWith<$Res>? get aiAnalysis;@override $NeedsMatchAnalysisCopyWith<$Res>? get needsMatch;

}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? modelName = null,Object? title = null,Object? description = null,Object? specifications = null,Object? technicalProfile = freezed,Object? brand = null,Object? category = null,Object? cachedAt = freezed,Object? imageUrl = freezed,Object? dynamicPrices = null,Object? aiAnalysis = freezed,Object? needsMatch = freezed,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,modelName: null == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,specifications: null == specifications ? _self._specifications : specifications // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,technicalProfile: freezed == technicalProfile ? _self.technicalProfile : technicalProfile // ignore: cast_nullable_to_non_nullable
as String?,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,cachedAt: freezed == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,dynamicPrices: null == dynamicPrices ? _self._dynamicPrices : dynamicPrices // ignore: cast_nullable_to_non_nullable
as List<DynamicPrice>,aiAnalysis: freezed == aiAnalysis ? _self.aiAnalysis : aiAnalysis // ignore: cast_nullable_to_non_nullable
as AIAnalysis?,needsMatch: freezed == needsMatch ? _self.needsMatch : needsMatch // ignore: cast_nullable_to_non_nullable
as NeedsMatchAnalysis?,
  ));
}

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AIAnalysisCopyWith<$Res>? get aiAnalysis {
    if (_self.aiAnalysis == null) {
    return null;
  }

  return $AIAnalysisCopyWith<$Res>(_self.aiAnalysis!, (value) {
    return _then(_self.copyWith(aiAnalysis: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NeedsMatchAnalysisCopyWith<$Res>? get needsMatch {
    if (_self.needsMatch == null) {
    return null;
  }

  return $NeedsMatchAnalysisCopyWith<$Res>(_self.needsMatch!, (value) {
    return _then(_self.copyWith(needsMatch: value));
  });
}
}


/// @nodoc
mixin _$AIAnalysis {

// Legacy fields for backward compatibility with existing UI
 double? get sentimentScore; String? get trustLevel; double? get valueScore; List<String> get pros; List<String> get cons;// New Clario backend fields
 double? get needsMatchScore;@JsonKey(name: 'fit_summary') String? get fitSummary;@JsonKey(name: 'recommendation_for_user') String? get recommendationForUser;@JsonKey(name: 'budget_fit') String? get budgetFit; double? get confidence;@JsonKey(name: 'authenticity_report') String? get authenticityReport;@JsonKey(name: 'market_sentiment') String? get marketSentiment;@JsonKey(name: 'pros_for_user') List<String> get prosForUser;@JsonKey(name: 'cons_for_user') List<String> get consForUser;@JsonKey(name: 'caution_flags') List<String> get cautionFlags;@JsonKey(name: 'action_plan') String? get actionPlan;@JsonKey(name: 'final_shopping_verdict') String? get finalShoppingVerdict; String? get reasoning; List<String> get alternatives;@JsonKey(name: 'estimatedDeliveryDays') int? get estimatedDeliveryDays;
/// Create a copy of AIAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AIAnalysisCopyWith<AIAnalysis> get copyWith => _$AIAnalysisCopyWithImpl<AIAnalysis>(this as AIAnalysis, _$identity);

  /// Serializes this AIAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AIAnalysis&&(identical(other.sentimentScore, sentimentScore) || other.sentimentScore == sentimentScore)&&(identical(other.trustLevel, trustLevel) || other.trustLevel == trustLevel)&&(identical(other.valueScore, valueScore) || other.valueScore == valueScore)&&const DeepCollectionEquality().equals(other.pros, pros)&&const DeepCollectionEquality().equals(other.cons, cons)&&(identical(other.needsMatchScore, needsMatchScore) || other.needsMatchScore == needsMatchScore)&&(identical(other.fitSummary, fitSummary) || other.fitSummary == fitSummary)&&(identical(other.recommendationForUser, recommendationForUser) || other.recommendationForUser == recommendationForUser)&&(identical(other.budgetFit, budgetFit) || other.budgetFit == budgetFit)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.authenticityReport, authenticityReport) || other.authenticityReport == authenticityReport)&&(identical(other.marketSentiment, marketSentiment) || other.marketSentiment == marketSentiment)&&const DeepCollectionEquality().equals(other.prosForUser, prosForUser)&&const DeepCollectionEquality().equals(other.consForUser, consForUser)&&const DeepCollectionEquality().equals(other.cautionFlags, cautionFlags)&&(identical(other.actionPlan, actionPlan) || other.actionPlan == actionPlan)&&(identical(other.finalShoppingVerdict, finalShoppingVerdict) || other.finalShoppingVerdict == finalShoppingVerdict)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning)&&const DeepCollectionEquality().equals(other.alternatives, alternatives)&&(identical(other.estimatedDeliveryDays, estimatedDeliveryDays) || other.estimatedDeliveryDays == estimatedDeliveryDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentimentScore,trustLevel,valueScore,const DeepCollectionEquality().hash(pros),const DeepCollectionEquality().hash(cons),needsMatchScore,fitSummary,recommendationForUser,budgetFit,confidence,authenticityReport,marketSentiment,const DeepCollectionEquality().hash(prosForUser),const DeepCollectionEquality().hash(consForUser),const DeepCollectionEquality().hash(cautionFlags),actionPlan,finalShoppingVerdict,reasoning,const DeepCollectionEquality().hash(alternatives),estimatedDeliveryDays]);

@override
String toString() {
  return 'AIAnalysis(sentimentScore: $sentimentScore, trustLevel: $trustLevel, valueScore: $valueScore, pros: $pros, cons: $cons, needsMatchScore: $needsMatchScore, fitSummary: $fitSummary, recommendationForUser: $recommendationForUser, budgetFit: $budgetFit, confidence: $confidence, authenticityReport: $authenticityReport, marketSentiment: $marketSentiment, prosForUser: $prosForUser, consForUser: $consForUser, cautionFlags: $cautionFlags, actionPlan: $actionPlan, finalShoppingVerdict: $finalShoppingVerdict, reasoning: $reasoning, alternatives: $alternatives, estimatedDeliveryDays: $estimatedDeliveryDays)';
}


}

/// @nodoc
abstract mixin class $AIAnalysisCopyWith<$Res>  {
  factory $AIAnalysisCopyWith(AIAnalysis value, $Res Function(AIAnalysis) _then) = _$AIAnalysisCopyWithImpl;
@useResult
$Res call({
 double? sentimentScore, String? trustLevel, double? valueScore, List<String> pros, List<String> cons, double? needsMatchScore,@JsonKey(name: 'fit_summary') String? fitSummary,@JsonKey(name: 'recommendation_for_user') String? recommendationForUser,@JsonKey(name: 'budget_fit') String? budgetFit, double? confidence,@JsonKey(name: 'authenticity_report') String? authenticityReport,@JsonKey(name: 'market_sentiment') String? marketSentiment,@JsonKey(name: 'pros_for_user') List<String> prosForUser,@JsonKey(name: 'cons_for_user') List<String> consForUser,@JsonKey(name: 'caution_flags') List<String> cautionFlags,@JsonKey(name: 'action_plan') String? actionPlan,@JsonKey(name: 'final_shopping_verdict') String? finalShoppingVerdict, String? reasoning, List<String> alternatives,@JsonKey(name: 'estimatedDeliveryDays') int? estimatedDeliveryDays
});




}
/// @nodoc
class _$AIAnalysisCopyWithImpl<$Res>
    implements $AIAnalysisCopyWith<$Res> {
  _$AIAnalysisCopyWithImpl(this._self, this._then);

  final AIAnalysis _self;
  final $Res Function(AIAnalysis) _then;

/// Create a copy of AIAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sentimentScore = freezed,Object? trustLevel = freezed,Object? valueScore = freezed,Object? pros = null,Object? cons = null,Object? needsMatchScore = freezed,Object? fitSummary = freezed,Object? recommendationForUser = freezed,Object? budgetFit = freezed,Object? confidence = freezed,Object? authenticityReport = freezed,Object? marketSentiment = freezed,Object? prosForUser = null,Object? consForUser = null,Object? cautionFlags = null,Object? actionPlan = freezed,Object? finalShoppingVerdict = freezed,Object? reasoning = freezed,Object? alternatives = null,Object? estimatedDeliveryDays = freezed,}) {
  return _then(_self.copyWith(
sentimentScore: freezed == sentimentScore ? _self.sentimentScore : sentimentScore // ignore: cast_nullable_to_non_nullable
as double?,trustLevel: freezed == trustLevel ? _self.trustLevel : trustLevel // ignore: cast_nullable_to_non_nullable
as String?,valueScore: freezed == valueScore ? _self.valueScore : valueScore // ignore: cast_nullable_to_non_nullable
as double?,pros: null == pros ? _self.pros : pros // ignore: cast_nullable_to_non_nullable
as List<String>,cons: null == cons ? _self.cons : cons // ignore: cast_nullable_to_non_nullable
as List<String>,needsMatchScore: freezed == needsMatchScore ? _self.needsMatchScore : needsMatchScore // ignore: cast_nullable_to_non_nullable
as double?,fitSummary: freezed == fitSummary ? _self.fitSummary : fitSummary // ignore: cast_nullable_to_non_nullable
as String?,recommendationForUser: freezed == recommendationForUser ? _self.recommendationForUser : recommendationForUser // ignore: cast_nullable_to_non_nullable
as String?,budgetFit: freezed == budgetFit ? _self.budgetFit : budgetFit // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,authenticityReport: freezed == authenticityReport ? _self.authenticityReport : authenticityReport // ignore: cast_nullable_to_non_nullable
as String?,marketSentiment: freezed == marketSentiment ? _self.marketSentiment : marketSentiment // ignore: cast_nullable_to_non_nullable
as String?,prosForUser: null == prosForUser ? _self.prosForUser : prosForUser // ignore: cast_nullable_to_non_nullable
as List<String>,consForUser: null == consForUser ? _self.consForUser : consForUser // ignore: cast_nullable_to_non_nullable
as List<String>,cautionFlags: null == cautionFlags ? _self.cautionFlags : cautionFlags // ignore: cast_nullable_to_non_nullable
as List<String>,actionPlan: freezed == actionPlan ? _self.actionPlan : actionPlan // ignore: cast_nullable_to_non_nullable
as String?,finalShoppingVerdict: freezed == finalShoppingVerdict ? _self.finalShoppingVerdict : finalShoppingVerdict // ignore: cast_nullable_to_non_nullable
as String?,reasoning: freezed == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String?,alternatives: null == alternatives ? _self.alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<String>,estimatedDeliveryDays: freezed == estimatedDeliveryDays ? _self.estimatedDeliveryDays : estimatedDeliveryDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AIAnalysis].
extension AIAnalysisPatterns on AIAnalysis {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AIAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AIAnalysis() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AIAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _AIAnalysis():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AIAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _AIAnalysis() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? sentimentScore,  String? trustLevel,  double? valueScore,  List<String> pros,  List<String> cons,  double? needsMatchScore, @JsonKey(name: 'fit_summary')  String? fitSummary, @JsonKey(name: 'recommendation_for_user')  String? recommendationForUser, @JsonKey(name: 'budget_fit')  String? budgetFit,  double? confidence, @JsonKey(name: 'authenticity_report')  String? authenticityReport, @JsonKey(name: 'market_sentiment')  String? marketSentiment, @JsonKey(name: 'pros_for_user')  List<String> prosForUser, @JsonKey(name: 'cons_for_user')  List<String> consForUser, @JsonKey(name: 'caution_flags')  List<String> cautionFlags, @JsonKey(name: 'action_plan')  String? actionPlan, @JsonKey(name: 'final_shopping_verdict')  String? finalShoppingVerdict,  String? reasoning,  List<String> alternatives, @JsonKey(name: 'estimatedDeliveryDays')  int? estimatedDeliveryDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AIAnalysis() when $default != null:
return $default(_that.sentimentScore,_that.trustLevel,_that.valueScore,_that.pros,_that.cons,_that.needsMatchScore,_that.fitSummary,_that.recommendationForUser,_that.budgetFit,_that.confidence,_that.authenticityReport,_that.marketSentiment,_that.prosForUser,_that.consForUser,_that.cautionFlags,_that.actionPlan,_that.finalShoppingVerdict,_that.reasoning,_that.alternatives,_that.estimatedDeliveryDays);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? sentimentScore,  String? trustLevel,  double? valueScore,  List<String> pros,  List<String> cons,  double? needsMatchScore, @JsonKey(name: 'fit_summary')  String? fitSummary, @JsonKey(name: 'recommendation_for_user')  String? recommendationForUser, @JsonKey(name: 'budget_fit')  String? budgetFit,  double? confidence, @JsonKey(name: 'authenticity_report')  String? authenticityReport, @JsonKey(name: 'market_sentiment')  String? marketSentiment, @JsonKey(name: 'pros_for_user')  List<String> prosForUser, @JsonKey(name: 'cons_for_user')  List<String> consForUser, @JsonKey(name: 'caution_flags')  List<String> cautionFlags, @JsonKey(name: 'action_plan')  String? actionPlan, @JsonKey(name: 'final_shopping_verdict')  String? finalShoppingVerdict,  String? reasoning,  List<String> alternatives, @JsonKey(name: 'estimatedDeliveryDays')  int? estimatedDeliveryDays)  $default,) {final _that = this;
switch (_that) {
case _AIAnalysis():
return $default(_that.sentimentScore,_that.trustLevel,_that.valueScore,_that.pros,_that.cons,_that.needsMatchScore,_that.fitSummary,_that.recommendationForUser,_that.budgetFit,_that.confidence,_that.authenticityReport,_that.marketSentiment,_that.prosForUser,_that.consForUser,_that.cautionFlags,_that.actionPlan,_that.finalShoppingVerdict,_that.reasoning,_that.alternatives,_that.estimatedDeliveryDays);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? sentimentScore,  String? trustLevel,  double? valueScore,  List<String> pros,  List<String> cons,  double? needsMatchScore, @JsonKey(name: 'fit_summary')  String? fitSummary, @JsonKey(name: 'recommendation_for_user')  String? recommendationForUser, @JsonKey(name: 'budget_fit')  String? budgetFit,  double? confidence, @JsonKey(name: 'authenticity_report')  String? authenticityReport, @JsonKey(name: 'market_sentiment')  String? marketSentiment, @JsonKey(name: 'pros_for_user')  List<String> prosForUser, @JsonKey(name: 'cons_for_user')  List<String> consForUser, @JsonKey(name: 'caution_flags')  List<String> cautionFlags, @JsonKey(name: 'action_plan')  String? actionPlan, @JsonKey(name: 'final_shopping_verdict')  String? finalShoppingVerdict,  String? reasoning,  List<String> alternatives, @JsonKey(name: 'estimatedDeliveryDays')  int? estimatedDeliveryDays)?  $default,) {final _that = this;
switch (_that) {
case _AIAnalysis() when $default != null:
return $default(_that.sentimentScore,_that.trustLevel,_that.valueScore,_that.pros,_that.cons,_that.needsMatchScore,_that.fitSummary,_that.recommendationForUser,_that.budgetFit,_that.confidence,_that.authenticityReport,_that.marketSentiment,_that.prosForUser,_that.consForUser,_that.cautionFlags,_that.actionPlan,_that.finalShoppingVerdict,_that.reasoning,_that.alternatives,_that.estimatedDeliveryDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AIAnalysis implements AIAnalysis {
  const _AIAnalysis({this.sentimentScore, this.trustLevel, this.valueScore, final  List<String> pros = const [], final  List<String> cons = const [], this.needsMatchScore, @JsonKey(name: 'fit_summary') this.fitSummary, @JsonKey(name: 'recommendation_for_user') this.recommendationForUser, @JsonKey(name: 'budget_fit') this.budgetFit, this.confidence, @JsonKey(name: 'authenticity_report') this.authenticityReport, @JsonKey(name: 'market_sentiment') this.marketSentiment, @JsonKey(name: 'pros_for_user') final  List<String> prosForUser = const [], @JsonKey(name: 'cons_for_user') final  List<String> consForUser = const [], @JsonKey(name: 'caution_flags') final  List<String> cautionFlags = const [], @JsonKey(name: 'action_plan') this.actionPlan, @JsonKey(name: 'final_shopping_verdict') this.finalShoppingVerdict, this.reasoning, final  List<String> alternatives = const [], @JsonKey(name: 'estimatedDeliveryDays') this.estimatedDeliveryDays}): _pros = pros,_cons = cons,_prosForUser = prosForUser,_consForUser = consForUser,_cautionFlags = cautionFlags,_alternatives = alternatives;
  factory _AIAnalysis.fromJson(Map<String, dynamic> json) => _$AIAnalysisFromJson(json);

// Legacy fields for backward compatibility with existing UI
@override final  double? sentimentScore;
@override final  String? trustLevel;
@override final  double? valueScore;
 final  List<String> _pros;
@override@JsonKey() List<String> get pros {
  if (_pros is EqualUnmodifiableListView) return _pros;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pros);
}

 final  List<String> _cons;
@override@JsonKey() List<String> get cons {
  if (_cons is EqualUnmodifiableListView) return _cons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cons);
}

// New Clario backend fields
@override final  double? needsMatchScore;
@override@JsonKey(name: 'fit_summary') final  String? fitSummary;
@override@JsonKey(name: 'recommendation_for_user') final  String? recommendationForUser;
@override@JsonKey(name: 'budget_fit') final  String? budgetFit;
@override final  double? confidence;
@override@JsonKey(name: 'authenticity_report') final  String? authenticityReport;
@override@JsonKey(name: 'market_sentiment') final  String? marketSentiment;
 final  List<String> _prosForUser;
@override@JsonKey(name: 'pros_for_user') List<String> get prosForUser {
  if (_prosForUser is EqualUnmodifiableListView) return _prosForUser;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prosForUser);
}

 final  List<String> _consForUser;
@override@JsonKey(name: 'cons_for_user') List<String> get consForUser {
  if (_consForUser is EqualUnmodifiableListView) return _consForUser;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_consForUser);
}

 final  List<String> _cautionFlags;
@override@JsonKey(name: 'caution_flags') List<String> get cautionFlags {
  if (_cautionFlags is EqualUnmodifiableListView) return _cautionFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cautionFlags);
}

@override@JsonKey(name: 'action_plan') final  String? actionPlan;
@override@JsonKey(name: 'final_shopping_verdict') final  String? finalShoppingVerdict;
@override final  String? reasoning;
 final  List<String> _alternatives;
@override@JsonKey() List<String> get alternatives {
  if (_alternatives is EqualUnmodifiableListView) return _alternatives;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alternatives);
}

@override@JsonKey(name: 'estimatedDeliveryDays') final  int? estimatedDeliveryDays;

/// Create a copy of AIAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AIAnalysisCopyWith<_AIAnalysis> get copyWith => __$AIAnalysisCopyWithImpl<_AIAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AIAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AIAnalysis&&(identical(other.sentimentScore, sentimentScore) || other.sentimentScore == sentimentScore)&&(identical(other.trustLevel, trustLevel) || other.trustLevel == trustLevel)&&(identical(other.valueScore, valueScore) || other.valueScore == valueScore)&&const DeepCollectionEquality().equals(other._pros, _pros)&&const DeepCollectionEquality().equals(other._cons, _cons)&&(identical(other.needsMatchScore, needsMatchScore) || other.needsMatchScore == needsMatchScore)&&(identical(other.fitSummary, fitSummary) || other.fitSummary == fitSummary)&&(identical(other.recommendationForUser, recommendationForUser) || other.recommendationForUser == recommendationForUser)&&(identical(other.budgetFit, budgetFit) || other.budgetFit == budgetFit)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.authenticityReport, authenticityReport) || other.authenticityReport == authenticityReport)&&(identical(other.marketSentiment, marketSentiment) || other.marketSentiment == marketSentiment)&&const DeepCollectionEquality().equals(other._prosForUser, _prosForUser)&&const DeepCollectionEquality().equals(other._consForUser, _consForUser)&&const DeepCollectionEquality().equals(other._cautionFlags, _cautionFlags)&&(identical(other.actionPlan, actionPlan) || other.actionPlan == actionPlan)&&(identical(other.finalShoppingVerdict, finalShoppingVerdict) || other.finalShoppingVerdict == finalShoppingVerdict)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning)&&const DeepCollectionEquality().equals(other._alternatives, _alternatives)&&(identical(other.estimatedDeliveryDays, estimatedDeliveryDays) || other.estimatedDeliveryDays == estimatedDeliveryDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,sentimentScore,trustLevel,valueScore,const DeepCollectionEquality().hash(_pros),const DeepCollectionEquality().hash(_cons),needsMatchScore,fitSummary,recommendationForUser,budgetFit,confidence,authenticityReport,marketSentiment,const DeepCollectionEquality().hash(_prosForUser),const DeepCollectionEquality().hash(_consForUser),const DeepCollectionEquality().hash(_cautionFlags),actionPlan,finalShoppingVerdict,reasoning,const DeepCollectionEquality().hash(_alternatives),estimatedDeliveryDays]);

@override
String toString() {
  return 'AIAnalysis(sentimentScore: $sentimentScore, trustLevel: $trustLevel, valueScore: $valueScore, pros: $pros, cons: $cons, needsMatchScore: $needsMatchScore, fitSummary: $fitSummary, recommendationForUser: $recommendationForUser, budgetFit: $budgetFit, confidence: $confidence, authenticityReport: $authenticityReport, marketSentiment: $marketSentiment, prosForUser: $prosForUser, consForUser: $consForUser, cautionFlags: $cautionFlags, actionPlan: $actionPlan, finalShoppingVerdict: $finalShoppingVerdict, reasoning: $reasoning, alternatives: $alternatives, estimatedDeliveryDays: $estimatedDeliveryDays)';
}


}

/// @nodoc
abstract mixin class _$AIAnalysisCopyWith<$Res> implements $AIAnalysisCopyWith<$Res> {
  factory _$AIAnalysisCopyWith(_AIAnalysis value, $Res Function(_AIAnalysis) _then) = __$AIAnalysisCopyWithImpl;
@override @useResult
$Res call({
 double? sentimentScore, String? trustLevel, double? valueScore, List<String> pros, List<String> cons, double? needsMatchScore,@JsonKey(name: 'fit_summary') String? fitSummary,@JsonKey(name: 'recommendation_for_user') String? recommendationForUser,@JsonKey(name: 'budget_fit') String? budgetFit, double? confidence,@JsonKey(name: 'authenticity_report') String? authenticityReport,@JsonKey(name: 'market_sentiment') String? marketSentiment,@JsonKey(name: 'pros_for_user') List<String> prosForUser,@JsonKey(name: 'cons_for_user') List<String> consForUser,@JsonKey(name: 'caution_flags') List<String> cautionFlags,@JsonKey(name: 'action_plan') String? actionPlan,@JsonKey(name: 'final_shopping_verdict') String? finalShoppingVerdict, String? reasoning, List<String> alternatives,@JsonKey(name: 'estimatedDeliveryDays') int? estimatedDeliveryDays
});




}
/// @nodoc
class __$AIAnalysisCopyWithImpl<$Res>
    implements _$AIAnalysisCopyWith<$Res> {
  __$AIAnalysisCopyWithImpl(this._self, this._then);

  final _AIAnalysis _self;
  final $Res Function(_AIAnalysis) _then;

/// Create a copy of AIAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentimentScore = freezed,Object? trustLevel = freezed,Object? valueScore = freezed,Object? pros = null,Object? cons = null,Object? needsMatchScore = freezed,Object? fitSummary = freezed,Object? recommendationForUser = freezed,Object? budgetFit = freezed,Object? confidence = freezed,Object? authenticityReport = freezed,Object? marketSentiment = freezed,Object? prosForUser = null,Object? consForUser = null,Object? cautionFlags = null,Object? actionPlan = freezed,Object? finalShoppingVerdict = freezed,Object? reasoning = freezed,Object? alternatives = null,Object? estimatedDeliveryDays = freezed,}) {
  return _then(_AIAnalysis(
sentimentScore: freezed == sentimentScore ? _self.sentimentScore : sentimentScore // ignore: cast_nullable_to_non_nullable
as double?,trustLevel: freezed == trustLevel ? _self.trustLevel : trustLevel // ignore: cast_nullable_to_non_nullable
as String?,valueScore: freezed == valueScore ? _self.valueScore : valueScore // ignore: cast_nullable_to_non_nullable
as double?,pros: null == pros ? _self._pros : pros // ignore: cast_nullable_to_non_nullable
as List<String>,cons: null == cons ? _self._cons : cons // ignore: cast_nullable_to_non_nullable
as List<String>,needsMatchScore: freezed == needsMatchScore ? _self.needsMatchScore : needsMatchScore // ignore: cast_nullable_to_non_nullable
as double?,fitSummary: freezed == fitSummary ? _self.fitSummary : fitSummary // ignore: cast_nullable_to_non_nullable
as String?,recommendationForUser: freezed == recommendationForUser ? _self.recommendationForUser : recommendationForUser // ignore: cast_nullable_to_non_nullable
as String?,budgetFit: freezed == budgetFit ? _self.budgetFit : budgetFit // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,authenticityReport: freezed == authenticityReport ? _self.authenticityReport : authenticityReport // ignore: cast_nullable_to_non_nullable
as String?,marketSentiment: freezed == marketSentiment ? _self.marketSentiment : marketSentiment // ignore: cast_nullable_to_non_nullable
as String?,prosForUser: null == prosForUser ? _self._prosForUser : prosForUser // ignore: cast_nullable_to_non_nullable
as List<String>,consForUser: null == consForUser ? _self._consForUser : consForUser // ignore: cast_nullable_to_non_nullable
as List<String>,cautionFlags: null == cautionFlags ? _self._cautionFlags : cautionFlags // ignore: cast_nullable_to_non_nullable
as List<String>,actionPlan: freezed == actionPlan ? _self.actionPlan : actionPlan // ignore: cast_nullable_to_non_nullable
as String?,finalShoppingVerdict: freezed == finalShoppingVerdict ? _self.finalShoppingVerdict : finalShoppingVerdict // ignore: cast_nullable_to_non_nullable
as String?,reasoning: freezed == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String?,alternatives: null == alternatives ? _self._alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<String>,estimatedDeliveryDays: freezed == estimatedDeliveryDays ? _self.estimatedDeliveryDays : estimatedDeliveryDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$NeedsMatchAnalysis {

 double get matchPercentage; String get summary; String get compatibilityText; List<MatchReason> get reasons; String get userPreferenceNote; String get aiNoteResponse;
/// Create a copy of NeedsMatchAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NeedsMatchAnalysisCopyWith<NeedsMatchAnalysis> get copyWith => _$NeedsMatchAnalysisCopyWithImpl<NeedsMatchAnalysis>(this as NeedsMatchAnalysis, _$identity);

  /// Serializes this NeedsMatchAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NeedsMatchAnalysis&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.compatibilityText, compatibilityText) || other.compatibilityText == compatibilityText)&&const DeepCollectionEquality().equals(other.reasons, reasons)&&(identical(other.userPreferenceNote, userPreferenceNote) || other.userPreferenceNote == userPreferenceNote)&&(identical(other.aiNoteResponse, aiNoteResponse) || other.aiNoteResponse == aiNoteResponse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchPercentage,summary,compatibilityText,const DeepCollectionEquality().hash(reasons),userPreferenceNote,aiNoteResponse);

@override
String toString() {
  return 'NeedsMatchAnalysis(matchPercentage: $matchPercentage, summary: $summary, compatibilityText: $compatibilityText, reasons: $reasons, userPreferenceNote: $userPreferenceNote, aiNoteResponse: $aiNoteResponse)';
}


}

/// @nodoc
abstract mixin class $NeedsMatchAnalysisCopyWith<$Res>  {
  factory $NeedsMatchAnalysisCopyWith(NeedsMatchAnalysis value, $Res Function(NeedsMatchAnalysis) _then) = _$NeedsMatchAnalysisCopyWithImpl;
@useResult
$Res call({
 double matchPercentage, String summary, String compatibilityText, List<MatchReason> reasons, String userPreferenceNote, String aiNoteResponse
});




}
/// @nodoc
class _$NeedsMatchAnalysisCopyWithImpl<$Res>
    implements $NeedsMatchAnalysisCopyWith<$Res> {
  _$NeedsMatchAnalysisCopyWithImpl(this._self, this._then);

  final NeedsMatchAnalysis _self;
  final $Res Function(NeedsMatchAnalysis) _then;

/// Create a copy of NeedsMatchAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchPercentage = null,Object? summary = null,Object? compatibilityText = null,Object? reasons = null,Object? userPreferenceNote = null,Object? aiNoteResponse = null,}) {
  return _then(_self.copyWith(
matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as double,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,compatibilityText: null == compatibilityText ? _self.compatibilityText : compatibilityText // ignore: cast_nullable_to_non_nullable
as String,reasons: null == reasons ? _self.reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<MatchReason>,userPreferenceNote: null == userPreferenceNote ? _self.userPreferenceNote : userPreferenceNote // ignore: cast_nullable_to_non_nullable
as String,aiNoteResponse: null == aiNoteResponse ? _self.aiNoteResponse : aiNoteResponse // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NeedsMatchAnalysis].
extension NeedsMatchAnalysisPatterns on NeedsMatchAnalysis {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NeedsMatchAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NeedsMatchAnalysis() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NeedsMatchAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _NeedsMatchAnalysis():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NeedsMatchAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _NeedsMatchAnalysis() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double matchPercentage,  String summary,  String compatibilityText,  List<MatchReason> reasons,  String userPreferenceNote,  String aiNoteResponse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NeedsMatchAnalysis() when $default != null:
return $default(_that.matchPercentage,_that.summary,_that.compatibilityText,_that.reasons,_that.userPreferenceNote,_that.aiNoteResponse);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double matchPercentage,  String summary,  String compatibilityText,  List<MatchReason> reasons,  String userPreferenceNote,  String aiNoteResponse)  $default,) {final _that = this;
switch (_that) {
case _NeedsMatchAnalysis():
return $default(_that.matchPercentage,_that.summary,_that.compatibilityText,_that.reasons,_that.userPreferenceNote,_that.aiNoteResponse);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double matchPercentage,  String summary,  String compatibilityText,  List<MatchReason> reasons,  String userPreferenceNote,  String aiNoteResponse)?  $default,) {final _that = this;
switch (_that) {
case _NeedsMatchAnalysis() when $default != null:
return $default(_that.matchPercentage,_that.summary,_that.compatibilityText,_that.reasons,_that.userPreferenceNote,_that.aiNoteResponse);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NeedsMatchAnalysis implements NeedsMatchAnalysis {
  const _NeedsMatchAnalysis({required this.matchPercentage, required this.summary, required this.compatibilityText, required final  List<MatchReason> reasons, required this.userPreferenceNote, required this.aiNoteResponse}): _reasons = reasons;
  factory _NeedsMatchAnalysis.fromJson(Map<String, dynamic> json) => _$NeedsMatchAnalysisFromJson(json);

@override final  double matchPercentage;
@override final  String summary;
@override final  String compatibilityText;
 final  List<MatchReason> _reasons;
@override List<MatchReason> get reasons {
  if (_reasons is EqualUnmodifiableListView) return _reasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reasons);
}

@override final  String userPreferenceNote;
@override final  String aiNoteResponse;

/// Create a copy of NeedsMatchAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NeedsMatchAnalysisCopyWith<_NeedsMatchAnalysis> get copyWith => __$NeedsMatchAnalysisCopyWithImpl<_NeedsMatchAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NeedsMatchAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NeedsMatchAnalysis&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.compatibilityText, compatibilityText) || other.compatibilityText == compatibilityText)&&const DeepCollectionEquality().equals(other._reasons, _reasons)&&(identical(other.userPreferenceNote, userPreferenceNote) || other.userPreferenceNote == userPreferenceNote)&&(identical(other.aiNoteResponse, aiNoteResponse) || other.aiNoteResponse == aiNoteResponse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchPercentage,summary,compatibilityText,const DeepCollectionEquality().hash(_reasons),userPreferenceNote,aiNoteResponse);

@override
String toString() {
  return 'NeedsMatchAnalysis(matchPercentage: $matchPercentage, summary: $summary, compatibilityText: $compatibilityText, reasons: $reasons, userPreferenceNote: $userPreferenceNote, aiNoteResponse: $aiNoteResponse)';
}


}

/// @nodoc
abstract mixin class _$NeedsMatchAnalysisCopyWith<$Res> implements $NeedsMatchAnalysisCopyWith<$Res> {
  factory _$NeedsMatchAnalysisCopyWith(_NeedsMatchAnalysis value, $Res Function(_NeedsMatchAnalysis) _then) = __$NeedsMatchAnalysisCopyWithImpl;
@override @useResult
$Res call({
 double matchPercentage, String summary, String compatibilityText, List<MatchReason> reasons, String userPreferenceNote, String aiNoteResponse
});




}
/// @nodoc
class __$NeedsMatchAnalysisCopyWithImpl<$Res>
    implements _$NeedsMatchAnalysisCopyWith<$Res> {
  __$NeedsMatchAnalysisCopyWithImpl(this._self, this._then);

  final _NeedsMatchAnalysis _self;
  final $Res Function(_NeedsMatchAnalysis) _then;

/// Create a copy of NeedsMatchAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchPercentage = null,Object? summary = null,Object? compatibilityText = null,Object? reasons = null,Object? userPreferenceNote = null,Object? aiNoteResponse = null,}) {
  return _then(_NeedsMatchAnalysis(
matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as double,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,compatibilityText: null == compatibilityText ? _self.compatibilityText : compatibilityText // ignore: cast_nullable_to_non_nullable
as String,reasons: null == reasons ? _self._reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<MatchReason>,userPreferenceNote: null == userPreferenceNote ? _self.userPreferenceNote : userPreferenceNote // ignore: cast_nullable_to_non_nullable
as String,aiNoteResponse: null == aiNoteResponse ? _self.aiNoteResponse : aiNoteResponse // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MatchReason {

 String get title; String get content; String get iconType;
/// Create a copy of MatchReason
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchReasonCopyWith<MatchReason> get copyWith => _$MatchReasonCopyWithImpl<MatchReason>(this as MatchReason, _$identity);

  /// Serializes this MatchReason to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchReason&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.iconType, iconType) || other.iconType == iconType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,content,iconType);

@override
String toString() {
  return 'MatchReason(title: $title, content: $content, iconType: $iconType)';
}


}

/// @nodoc
abstract mixin class $MatchReasonCopyWith<$Res>  {
  factory $MatchReasonCopyWith(MatchReason value, $Res Function(MatchReason) _then) = _$MatchReasonCopyWithImpl;
@useResult
$Res call({
 String title, String content, String iconType
});




}
/// @nodoc
class _$MatchReasonCopyWithImpl<$Res>
    implements $MatchReasonCopyWith<$Res> {
  _$MatchReasonCopyWithImpl(this._self, this._then);

  final MatchReason _self;
  final $Res Function(MatchReason) _then;

/// Create a copy of MatchReason
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? content = null,Object? iconType = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,iconType: null == iconType ? _self.iconType : iconType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchReason].
extension MatchReasonPatterns on MatchReason {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchReason value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchReason() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchReason value)  $default,){
final _that = this;
switch (_that) {
case _MatchReason():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchReason value)?  $default,){
final _that = this;
switch (_that) {
case _MatchReason() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String content,  String iconType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchReason() when $default != null:
return $default(_that.title,_that.content,_that.iconType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String content,  String iconType)  $default,) {final _that = this;
switch (_that) {
case _MatchReason():
return $default(_that.title,_that.content,_that.iconType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String content,  String iconType)?  $default,) {final _that = this;
switch (_that) {
case _MatchReason() when $default != null:
return $default(_that.title,_that.content,_that.iconType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchReason implements MatchReason {
  const _MatchReason({required this.title, required this.content, required this.iconType});
  factory _MatchReason.fromJson(Map<String, dynamic> json) => _$MatchReasonFromJson(json);

@override final  String title;
@override final  String content;
@override final  String iconType;

/// Create a copy of MatchReason
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchReasonCopyWith<_MatchReason> get copyWith => __$MatchReasonCopyWithImpl<_MatchReason>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchReasonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchReason&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.iconType, iconType) || other.iconType == iconType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,content,iconType);

@override
String toString() {
  return 'MatchReason(title: $title, content: $content, iconType: $iconType)';
}


}

/// @nodoc
abstract mixin class _$MatchReasonCopyWith<$Res> implements $MatchReasonCopyWith<$Res> {
  factory _$MatchReasonCopyWith(_MatchReason value, $Res Function(_MatchReason) _then) = __$MatchReasonCopyWithImpl;
@override @useResult
$Res call({
 String title, String content, String iconType
});




}
/// @nodoc
class __$MatchReasonCopyWithImpl<$Res>
    implements _$MatchReasonCopyWith<$Res> {
  __$MatchReasonCopyWithImpl(this._self, this._then);

  final _MatchReason _self;
  final $Res Function(_MatchReason) _then;

/// Create a copy of MatchReason
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? content = null,Object? iconType = null,}) {
  return _then(_MatchReason(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,iconType: null == iconType ? _self.iconType : iconType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DynamicPrice {

 String get store; double get price; String get currency; String get link; bool get availability; int get stock; String? get updateTime;
/// Create a copy of DynamicPrice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicPriceCopyWith<DynamicPrice> get copyWith => _$DynamicPriceCopyWithImpl<DynamicPrice>(this as DynamicPrice, _$identity);

  /// Serializes this DynamicPrice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicPrice&&(identical(other.store, store) || other.store == store)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.link, link) || other.link == link)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,store,price,currency,link,availability,stock,updateTime);

@override
String toString() {
  return 'DynamicPrice(store: $store, price: $price, currency: $currency, link: $link, availability: $availability, stock: $stock, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class $DynamicPriceCopyWith<$Res>  {
  factory $DynamicPriceCopyWith(DynamicPrice value, $Res Function(DynamicPrice) _then) = _$DynamicPriceCopyWithImpl;
@useResult
$Res call({
 String store, double price, String currency, String link, bool availability, int stock, String? updateTime
});




}
/// @nodoc
class _$DynamicPriceCopyWithImpl<$Res>
    implements $DynamicPriceCopyWith<$Res> {
  _$DynamicPriceCopyWithImpl(this._self, this._then);

  final DynamicPrice _self;
  final $Res Function(DynamicPrice) _then;

/// Create a copy of DynamicPrice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? store = null,Object? price = null,Object? currency = null,Object? link = null,Object? availability = null,Object? stock = null,Object? updateTime = freezed,}) {
  return _then(_self.copyWith(
store: null == store ? _self.store : store // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as bool,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,updateTime: freezed == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DynamicPrice].
extension DynamicPricePatterns on DynamicPrice {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DynamicPrice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DynamicPrice() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DynamicPrice value)  $default,){
final _that = this;
switch (_that) {
case _DynamicPrice():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DynamicPrice value)?  $default,){
final _that = this;
switch (_that) {
case _DynamicPrice() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String store,  double price,  String currency,  String link,  bool availability,  int stock,  String? updateTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DynamicPrice() when $default != null:
return $default(_that.store,_that.price,_that.currency,_that.link,_that.availability,_that.stock,_that.updateTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String store,  double price,  String currency,  String link,  bool availability,  int stock,  String? updateTime)  $default,) {final _that = this;
switch (_that) {
case _DynamicPrice():
return $default(_that.store,_that.price,_that.currency,_that.link,_that.availability,_that.stock,_that.updateTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String store,  double price,  String currency,  String link,  bool availability,  int stock,  String? updateTime)?  $default,) {final _that = this;
switch (_that) {
case _DynamicPrice() when $default != null:
return $default(_that.store,_that.price,_that.currency,_that.link,_that.availability,_that.stock,_that.updateTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DynamicPrice implements DynamicPrice {
  const _DynamicPrice({required this.store, required this.price, this.currency = 'USD', this.link = '', this.availability = true, this.stock = 0, this.updateTime});
  factory _DynamicPrice.fromJson(Map<String, dynamic> json) => _$DynamicPriceFromJson(json);

@override final  String store;
@override final  double price;
@override@JsonKey() final  String currency;
@override@JsonKey() final  String link;
@override@JsonKey() final  bool availability;
@override@JsonKey() final  int stock;
@override final  String? updateTime;

/// Create a copy of DynamicPrice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DynamicPriceCopyWith<_DynamicPrice> get copyWith => __$DynamicPriceCopyWithImpl<_DynamicPrice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicPriceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DynamicPrice&&(identical(other.store, store) || other.store == store)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.link, link) || other.link == link)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.updateTime, updateTime) || other.updateTime == updateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,store,price,currency,link,availability,stock,updateTime);

@override
String toString() {
  return 'DynamicPrice(store: $store, price: $price, currency: $currency, link: $link, availability: $availability, stock: $stock, updateTime: $updateTime)';
}


}

/// @nodoc
abstract mixin class _$DynamicPriceCopyWith<$Res> implements $DynamicPriceCopyWith<$Res> {
  factory _$DynamicPriceCopyWith(_DynamicPrice value, $Res Function(_DynamicPrice) _then) = __$DynamicPriceCopyWithImpl;
@override @useResult
$Res call({
 String store, double price, String currency, String link, bool availability, int stock, String? updateTime
});




}
/// @nodoc
class __$DynamicPriceCopyWithImpl<$Res>
    implements _$DynamicPriceCopyWith<$Res> {
  __$DynamicPriceCopyWithImpl(this._self, this._then);

  final _DynamicPrice _self;
  final $Res Function(_DynamicPrice) _then;

/// Create a copy of DynamicPrice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? store = null,Object? price = null,Object? currency = null,Object? link = null,Object? availability = null,Object? stock = null,Object? updateTime = freezed,}) {
  return _then(_DynamicPrice(
store: null == store ? _self.store : store // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as bool,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,updateTime: freezed == updateTime ? _self.updateTime : updateTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
