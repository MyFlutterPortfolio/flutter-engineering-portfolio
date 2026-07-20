// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clario_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPreferences {

 String get budget; List<String> get needs;
/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<UserPreferences> get copyWith => _$UserPreferencesCopyWithImpl<UserPreferences>(this as UserPreferences, _$identity);

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferences&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other.needs, needs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,budget,const DeepCollectionEquality().hash(needs));

@override
String toString() {
  return 'UserPreferences(budget: $budget, needs: $needs)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesCopyWith<$Res>  {
  factory $UserPreferencesCopyWith(UserPreferences value, $Res Function(UserPreferences) _then) = _$UserPreferencesCopyWithImpl;
@useResult
$Res call({
 String budget, List<String> needs
});




}
/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._self, this._then);

  final UserPreferences _self;
  final $Res Function(UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? budget = null,Object? needs = null,}) {
  return _then(_self.copyWith(
budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as String,needs: null == needs ? _self.needs : needs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreferences].
extension UserPreferencesPatterns on UserPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferences value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String budget,  List<String> needs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.budget,_that.needs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String budget,  List<String> needs)  $default,) {final _that = this;
switch (_that) {
case _UserPreferences():
return $default(_that.budget,_that.needs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String budget,  List<String> needs)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.budget,_that.needs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPreferences implements UserPreferences {
  const _UserPreferences({this.budget = 'medium', final  List<String> needs = const []}): _needs = needs;
  factory _UserPreferences.fromJson(Map<String, dynamic> json) => _$UserPreferencesFromJson(json);

@override@JsonKey() final  String budget;
 final  List<String> _needs;
@override@JsonKey() List<String> get needs {
  if (_needs is EqualUnmodifiableListView) return _needs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_needs);
}


/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesCopyWith<_UserPreferences> get copyWith => __$UserPreferencesCopyWithImpl<_UserPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferences&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other._needs, _needs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,budget,const DeepCollectionEquality().hash(_needs));

@override
String toString() {
  return 'UserPreferences(budget: $budget, needs: $needs)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesCopyWith<$Res> implements $UserPreferencesCopyWith<$Res> {
  factory _$UserPreferencesCopyWith(_UserPreferences value, $Res Function(_UserPreferences) _then) = __$UserPreferencesCopyWithImpl;
@override @useResult
$Res call({
 String budget, List<String> needs
});




}
/// @nodoc
class __$UserPreferencesCopyWithImpl<$Res>
    implements _$UserPreferencesCopyWith<$Res> {
  __$UserPreferencesCopyWithImpl(this._self, this._then);

  final _UserPreferences _self;
  final $Res Function(_UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? budget = null,Object? needs = null,}) {
  return _then(_UserPreferences(
budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as String,needs: null == needs ? _self._needs : needs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ClarioAnalyzeRequest {

@JsonKey(name: 'product_name') String get productName;@JsonKey(name: 'product_links') List<String> get productLinks;@JsonKey(name: 'selected_stores') List<String> get selectedStores;@JsonKey(name: 'user_preferences') UserPreferences get userPreferences;@JsonKey(name: 'selected_language') String get selectedLanguage;
/// Create a copy of ClarioAnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClarioAnalyzeRequestCopyWith<ClarioAnalyzeRequest> get copyWith => _$ClarioAnalyzeRequestCopyWithImpl<ClarioAnalyzeRequest>(this as ClarioAnalyzeRequest, _$identity);

  /// Serializes this ClarioAnalyzeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClarioAnalyzeRequest&&(identical(other.productName, productName) || other.productName == productName)&&const DeepCollectionEquality().equals(other.productLinks, productLinks)&&const DeepCollectionEquality().equals(other.selectedStores, selectedStores)&&(identical(other.userPreferences, userPreferences) || other.userPreferences == userPreferences)&&(identical(other.selectedLanguage, selectedLanguage) || other.selectedLanguage == selectedLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,const DeepCollectionEquality().hash(productLinks),const DeepCollectionEquality().hash(selectedStores),userPreferences,selectedLanguage);

@override
String toString() {
  return 'ClarioAnalyzeRequest(productName: $productName, productLinks: $productLinks, selectedStores: $selectedStores, userPreferences: $userPreferences, selectedLanguage: $selectedLanguage)';
}


}

/// @nodoc
abstract mixin class $ClarioAnalyzeRequestCopyWith<$Res>  {
  factory $ClarioAnalyzeRequestCopyWith(ClarioAnalyzeRequest value, $Res Function(ClarioAnalyzeRequest) _then) = _$ClarioAnalyzeRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'product_name') String productName,@JsonKey(name: 'product_links') List<String> productLinks,@JsonKey(name: 'selected_stores') List<String> selectedStores,@JsonKey(name: 'user_preferences') UserPreferences userPreferences,@JsonKey(name: 'selected_language') String selectedLanguage
});


$UserPreferencesCopyWith<$Res> get userPreferences;

}
/// @nodoc
class _$ClarioAnalyzeRequestCopyWithImpl<$Res>
    implements $ClarioAnalyzeRequestCopyWith<$Res> {
  _$ClarioAnalyzeRequestCopyWithImpl(this._self, this._then);

  final ClarioAnalyzeRequest _self;
  final $Res Function(ClarioAnalyzeRequest) _then;

/// Create a copy of ClarioAnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productName = null,Object? productLinks = null,Object? selectedStores = null,Object? userPreferences = null,Object? selectedLanguage = null,}) {
  return _then(_self.copyWith(
productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productLinks: null == productLinks ? _self.productLinks : productLinks // ignore: cast_nullable_to_non_nullable
as List<String>,selectedStores: null == selectedStores ? _self.selectedStores : selectedStores // ignore: cast_nullable_to_non_nullable
as List<String>,userPreferences: null == userPreferences ? _self.userPreferences : userPreferences // ignore: cast_nullable_to_non_nullable
as UserPreferences,selectedLanguage: null == selectedLanguage ? _self.selectedLanguage : selectedLanguage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ClarioAnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<$Res> get userPreferences {
  
  return $UserPreferencesCopyWith<$Res>(_self.userPreferences, (value) {
    return _then(_self.copyWith(userPreferences: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClarioAnalyzeRequest].
extension ClarioAnalyzeRequestPatterns on ClarioAnalyzeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClarioAnalyzeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClarioAnalyzeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClarioAnalyzeRequest value)  $default,){
final _that = this;
switch (_that) {
case _ClarioAnalyzeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClarioAnalyzeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ClarioAnalyzeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String productName, @JsonKey(name: 'product_links')  List<String> productLinks, @JsonKey(name: 'selected_stores')  List<String> selectedStores, @JsonKey(name: 'user_preferences')  UserPreferences userPreferences, @JsonKey(name: 'selected_language')  String selectedLanguage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClarioAnalyzeRequest() when $default != null:
return $default(_that.productName,_that.productLinks,_that.selectedStores,_that.userPreferences,_that.selectedLanguage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String productName, @JsonKey(name: 'product_links')  List<String> productLinks, @JsonKey(name: 'selected_stores')  List<String> selectedStores, @JsonKey(name: 'user_preferences')  UserPreferences userPreferences, @JsonKey(name: 'selected_language')  String selectedLanguage)  $default,) {final _that = this;
switch (_that) {
case _ClarioAnalyzeRequest():
return $default(_that.productName,_that.productLinks,_that.selectedStores,_that.userPreferences,_that.selectedLanguage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'product_name')  String productName, @JsonKey(name: 'product_links')  List<String> productLinks, @JsonKey(name: 'selected_stores')  List<String> selectedStores, @JsonKey(name: 'user_preferences')  UserPreferences userPreferences, @JsonKey(name: 'selected_language')  String selectedLanguage)?  $default,) {final _that = this;
switch (_that) {
case _ClarioAnalyzeRequest() when $default != null:
return $default(_that.productName,_that.productLinks,_that.selectedStores,_that.userPreferences,_that.selectedLanguage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClarioAnalyzeRequest implements ClarioAnalyzeRequest {
  const _ClarioAnalyzeRequest({@JsonKey(name: 'product_name') required this.productName, @JsonKey(name: 'product_links') final  List<String> productLinks = const [], @JsonKey(name: 'selected_stores') final  List<String> selectedStores = const [], @JsonKey(name: 'user_preferences') required this.userPreferences, @JsonKey(name: 'selected_language') this.selectedLanguage = 'uz'}): _productLinks = productLinks,_selectedStores = selectedStores;
  factory _ClarioAnalyzeRequest.fromJson(Map<String, dynamic> json) => _$ClarioAnalyzeRequestFromJson(json);

@override@JsonKey(name: 'product_name') final  String productName;
 final  List<String> _productLinks;
@override@JsonKey(name: 'product_links') List<String> get productLinks {
  if (_productLinks is EqualUnmodifiableListView) return _productLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_productLinks);
}

 final  List<String> _selectedStores;
@override@JsonKey(name: 'selected_stores') List<String> get selectedStores {
  if (_selectedStores is EqualUnmodifiableListView) return _selectedStores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedStores);
}

@override@JsonKey(name: 'user_preferences') final  UserPreferences userPreferences;
@override@JsonKey(name: 'selected_language') final  String selectedLanguage;

/// Create a copy of ClarioAnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClarioAnalyzeRequestCopyWith<_ClarioAnalyzeRequest> get copyWith => __$ClarioAnalyzeRequestCopyWithImpl<_ClarioAnalyzeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClarioAnalyzeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClarioAnalyzeRequest&&(identical(other.productName, productName) || other.productName == productName)&&const DeepCollectionEquality().equals(other._productLinks, _productLinks)&&const DeepCollectionEquality().equals(other._selectedStores, _selectedStores)&&(identical(other.userPreferences, userPreferences) || other.userPreferences == userPreferences)&&(identical(other.selectedLanguage, selectedLanguage) || other.selectedLanguage == selectedLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,const DeepCollectionEquality().hash(_productLinks),const DeepCollectionEquality().hash(_selectedStores),userPreferences,selectedLanguage);

@override
String toString() {
  return 'ClarioAnalyzeRequest(productName: $productName, productLinks: $productLinks, selectedStores: $selectedStores, userPreferences: $userPreferences, selectedLanguage: $selectedLanguage)';
}


}

/// @nodoc
abstract mixin class _$ClarioAnalyzeRequestCopyWith<$Res> implements $ClarioAnalyzeRequestCopyWith<$Res> {
  factory _$ClarioAnalyzeRequestCopyWith(_ClarioAnalyzeRequest value, $Res Function(_ClarioAnalyzeRequest) _then) = __$ClarioAnalyzeRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'product_name') String productName,@JsonKey(name: 'product_links') List<String> productLinks,@JsonKey(name: 'selected_stores') List<String> selectedStores,@JsonKey(name: 'user_preferences') UserPreferences userPreferences,@JsonKey(name: 'selected_language') String selectedLanguage
});


@override $UserPreferencesCopyWith<$Res> get userPreferences;

}
/// @nodoc
class __$ClarioAnalyzeRequestCopyWithImpl<$Res>
    implements _$ClarioAnalyzeRequestCopyWith<$Res> {
  __$ClarioAnalyzeRequestCopyWithImpl(this._self, this._then);

  final _ClarioAnalyzeRequest _self;
  final $Res Function(_ClarioAnalyzeRequest) _then;

/// Create a copy of ClarioAnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productName = null,Object? productLinks = null,Object? selectedStores = null,Object? userPreferences = null,Object? selectedLanguage = null,}) {
  return _then(_ClarioAnalyzeRequest(
productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productLinks: null == productLinks ? _self._productLinks : productLinks // ignore: cast_nullable_to_non_nullable
as List<String>,selectedStores: null == selectedStores ? _self._selectedStores : selectedStores // ignore: cast_nullable_to_non_nullable
as List<String>,userPreferences: null == userPreferences ? _self.userPreferences : userPreferences // ignore: cast_nullable_to_non_nullable
as UserPreferences,selectedLanguage: null == selectedLanguage ? _self.selectedLanguage : selectedLanguage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ClarioAnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<$Res> get userPreferences {
  
  return $UserPreferencesCopyWith<$Res>(_self.userPreferences, (value) {
    return _then(_self.copyWith(userPreferences: value));
  });
}
}

// dart format on
