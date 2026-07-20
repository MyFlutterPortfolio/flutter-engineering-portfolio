// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanCapabilities {

 int? get searchLimitPerMonth; String? get searchProvider; bool get aiAnalysis; bool get deepSeekChat; bool get barcode; bool get reviews; bool get selectedStoreSearch; int get maxSelectedStores; bool get superAlerts;
/// Create a copy of PlanCapabilities
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCapabilitiesCopyWith<PlanCapabilities> get copyWith => _$PlanCapabilitiesCopyWithImpl<PlanCapabilities>(this as PlanCapabilities, _$identity);

  /// Serializes this PlanCapabilities to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanCapabilities&&(identical(other.searchLimitPerMonth, searchLimitPerMonth) || other.searchLimitPerMonth == searchLimitPerMonth)&&(identical(other.searchProvider, searchProvider) || other.searchProvider == searchProvider)&&(identical(other.aiAnalysis, aiAnalysis) || other.aiAnalysis == aiAnalysis)&&(identical(other.deepSeekChat, deepSeekChat) || other.deepSeekChat == deepSeekChat)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.selectedStoreSearch, selectedStoreSearch) || other.selectedStoreSearch == selectedStoreSearch)&&(identical(other.maxSelectedStores, maxSelectedStores) || other.maxSelectedStores == maxSelectedStores)&&(identical(other.superAlerts, superAlerts) || other.superAlerts == superAlerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchLimitPerMonth,searchProvider,aiAnalysis,deepSeekChat,barcode,reviews,selectedStoreSearch,maxSelectedStores,superAlerts);

@override
String toString() {
  return 'PlanCapabilities(searchLimitPerMonth: $searchLimitPerMonth, searchProvider: $searchProvider, aiAnalysis: $aiAnalysis, deepSeekChat: $deepSeekChat, barcode: $barcode, reviews: $reviews, selectedStoreSearch: $selectedStoreSearch, maxSelectedStores: $maxSelectedStores, superAlerts: $superAlerts)';
}


}

/// @nodoc
abstract mixin class $PlanCapabilitiesCopyWith<$Res>  {
  factory $PlanCapabilitiesCopyWith(PlanCapabilities value, $Res Function(PlanCapabilities) _then) = _$PlanCapabilitiesCopyWithImpl;
@useResult
$Res call({
 int? searchLimitPerMonth, String? searchProvider, bool aiAnalysis, bool deepSeekChat, bool barcode, bool reviews, bool selectedStoreSearch, int maxSelectedStores, bool superAlerts
});




}
/// @nodoc
class _$PlanCapabilitiesCopyWithImpl<$Res>
    implements $PlanCapabilitiesCopyWith<$Res> {
  _$PlanCapabilitiesCopyWithImpl(this._self, this._then);

  final PlanCapabilities _self;
  final $Res Function(PlanCapabilities) _then;

/// Create a copy of PlanCapabilities
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchLimitPerMonth = freezed,Object? searchProvider = freezed,Object? aiAnalysis = null,Object? deepSeekChat = null,Object? barcode = null,Object? reviews = null,Object? selectedStoreSearch = null,Object? maxSelectedStores = null,Object? superAlerts = null,}) {
  return _then(_self.copyWith(
searchLimitPerMonth: freezed == searchLimitPerMonth ? _self.searchLimitPerMonth : searchLimitPerMonth // ignore: cast_nullable_to_non_nullable
as int?,searchProvider: freezed == searchProvider ? _self.searchProvider : searchProvider // ignore: cast_nullable_to_non_nullable
as String?,aiAnalysis: null == aiAnalysis ? _self.aiAnalysis : aiAnalysis // ignore: cast_nullable_to_non_nullable
as bool,deepSeekChat: null == deepSeekChat ? _self.deepSeekChat : deepSeekChat // ignore: cast_nullable_to_non_nullable
as bool,barcode: null == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as bool,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as bool,selectedStoreSearch: null == selectedStoreSearch ? _self.selectedStoreSearch : selectedStoreSearch // ignore: cast_nullable_to_non_nullable
as bool,maxSelectedStores: null == maxSelectedStores ? _self.maxSelectedStores : maxSelectedStores // ignore: cast_nullable_to_non_nullable
as int,superAlerts: null == superAlerts ? _self.superAlerts : superAlerts // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanCapabilities].
extension PlanCapabilitiesPatterns on PlanCapabilities {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanCapabilities value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanCapabilities() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanCapabilities value)  $default,){
final _that = this;
switch (_that) {
case _PlanCapabilities():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanCapabilities value)?  $default,){
final _that = this;
switch (_that) {
case _PlanCapabilities() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? searchLimitPerMonth,  String? searchProvider,  bool aiAnalysis,  bool deepSeekChat,  bool barcode,  bool reviews,  bool selectedStoreSearch,  int maxSelectedStores,  bool superAlerts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanCapabilities() when $default != null:
return $default(_that.searchLimitPerMonth,_that.searchProvider,_that.aiAnalysis,_that.deepSeekChat,_that.barcode,_that.reviews,_that.selectedStoreSearch,_that.maxSelectedStores,_that.superAlerts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? searchLimitPerMonth,  String? searchProvider,  bool aiAnalysis,  bool deepSeekChat,  bool barcode,  bool reviews,  bool selectedStoreSearch,  int maxSelectedStores,  bool superAlerts)  $default,) {final _that = this;
switch (_that) {
case _PlanCapabilities():
return $default(_that.searchLimitPerMonth,_that.searchProvider,_that.aiAnalysis,_that.deepSeekChat,_that.barcode,_that.reviews,_that.selectedStoreSearch,_that.maxSelectedStores,_that.superAlerts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? searchLimitPerMonth,  String? searchProvider,  bool aiAnalysis,  bool deepSeekChat,  bool barcode,  bool reviews,  bool selectedStoreSearch,  int maxSelectedStores,  bool superAlerts)?  $default,) {final _that = this;
switch (_that) {
case _PlanCapabilities() when $default != null:
return $default(_that.searchLimitPerMonth,_that.searchProvider,_that.aiAnalysis,_that.deepSeekChat,_that.barcode,_that.reviews,_that.selectedStoreSearch,_that.maxSelectedStores,_that.superAlerts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanCapabilities implements PlanCapabilities {
  const _PlanCapabilities({this.searchLimitPerMonth, this.searchProvider, this.aiAnalysis = false, this.deepSeekChat = false, this.barcode = false, this.reviews = false, this.selectedStoreSearch = false, this.maxSelectedStores = 0, this.superAlerts = false});
  factory _PlanCapabilities.fromJson(Map<String, dynamic> json) => _$PlanCapabilitiesFromJson(json);

@override final  int? searchLimitPerMonth;
@override final  String? searchProvider;
@override@JsonKey() final  bool aiAnalysis;
@override@JsonKey() final  bool deepSeekChat;
@override@JsonKey() final  bool barcode;
@override@JsonKey() final  bool reviews;
@override@JsonKey() final  bool selectedStoreSearch;
@override@JsonKey() final  int maxSelectedStores;
@override@JsonKey() final  bool superAlerts;

/// Create a copy of PlanCapabilities
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCapabilitiesCopyWith<_PlanCapabilities> get copyWith => __$PlanCapabilitiesCopyWithImpl<_PlanCapabilities>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanCapabilitiesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanCapabilities&&(identical(other.searchLimitPerMonth, searchLimitPerMonth) || other.searchLimitPerMonth == searchLimitPerMonth)&&(identical(other.searchProvider, searchProvider) || other.searchProvider == searchProvider)&&(identical(other.aiAnalysis, aiAnalysis) || other.aiAnalysis == aiAnalysis)&&(identical(other.deepSeekChat, deepSeekChat) || other.deepSeekChat == deepSeekChat)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.selectedStoreSearch, selectedStoreSearch) || other.selectedStoreSearch == selectedStoreSearch)&&(identical(other.maxSelectedStores, maxSelectedStores) || other.maxSelectedStores == maxSelectedStores)&&(identical(other.superAlerts, superAlerts) || other.superAlerts == superAlerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchLimitPerMonth,searchProvider,aiAnalysis,deepSeekChat,barcode,reviews,selectedStoreSearch,maxSelectedStores,superAlerts);

@override
String toString() {
  return 'PlanCapabilities(searchLimitPerMonth: $searchLimitPerMonth, searchProvider: $searchProvider, aiAnalysis: $aiAnalysis, deepSeekChat: $deepSeekChat, barcode: $barcode, reviews: $reviews, selectedStoreSearch: $selectedStoreSearch, maxSelectedStores: $maxSelectedStores, superAlerts: $superAlerts)';
}


}

/// @nodoc
abstract mixin class _$PlanCapabilitiesCopyWith<$Res> implements $PlanCapabilitiesCopyWith<$Res> {
  factory _$PlanCapabilitiesCopyWith(_PlanCapabilities value, $Res Function(_PlanCapabilities) _then) = __$PlanCapabilitiesCopyWithImpl;
@override @useResult
$Res call({
 int? searchLimitPerMonth, String? searchProvider, bool aiAnalysis, bool deepSeekChat, bool barcode, bool reviews, bool selectedStoreSearch, int maxSelectedStores, bool superAlerts
});




}
/// @nodoc
class __$PlanCapabilitiesCopyWithImpl<$Res>
    implements _$PlanCapabilitiesCopyWith<$Res> {
  __$PlanCapabilitiesCopyWithImpl(this._self, this._then);

  final _PlanCapabilities _self;
  final $Res Function(_PlanCapabilities) _then;

/// Create a copy of PlanCapabilities
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchLimitPerMonth = freezed,Object? searchProvider = freezed,Object? aiAnalysis = null,Object? deepSeekChat = null,Object? barcode = null,Object? reviews = null,Object? selectedStoreSearch = null,Object? maxSelectedStores = null,Object? superAlerts = null,}) {
  return _then(_PlanCapabilities(
searchLimitPerMonth: freezed == searchLimitPerMonth ? _self.searchLimitPerMonth : searchLimitPerMonth // ignore: cast_nullable_to_non_nullable
as int?,searchProvider: freezed == searchProvider ? _self.searchProvider : searchProvider // ignore: cast_nullable_to_non_nullable
as String?,aiAnalysis: null == aiAnalysis ? _self.aiAnalysis : aiAnalysis // ignore: cast_nullable_to_non_nullable
as bool,deepSeekChat: null == deepSeekChat ? _self.deepSeekChat : deepSeekChat // ignore: cast_nullable_to_non_nullable
as bool,barcode: null == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as bool,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as bool,selectedStoreSearch: null == selectedStoreSearch ? _self.selectedStoreSearch : selectedStoreSearch // ignore: cast_nullable_to_non_nullable
as bool,maxSelectedStores: null == maxSelectedStores ? _self.maxSelectedStores : maxSelectedStores // ignore: cast_nullable_to_non_nullable
as int,superAlerts: null == superAlerts ? _self.superAlerts : superAlerts // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SearchQuota {

 int get used; int get limit; int get remaining; String get resetAt; bool get allowed;
/// Create a copy of SearchQuota
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchQuotaCopyWith<SearchQuota> get copyWith => _$SearchQuotaCopyWithImpl<SearchQuota>(this as SearchQuota, _$identity);

  /// Serializes this SearchQuota to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchQuota&&(identical(other.used, used) || other.used == used)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.resetAt, resetAt) || other.resetAt == resetAt)&&(identical(other.allowed, allowed) || other.allowed == allowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,used,limit,remaining,resetAt,allowed);

@override
String toString() {
  return 'SearchQuota(used: $used, limit: $limit, remaining: $remaining, resetAt: $resetAt, allowed: $allowed)';
}


}

/// @nodoc
abstract mixin class $SearchQuotaCopyWith<$Res>  {
  factory $SearchQuotaCopyWith(SearchQuota value, $Res Function(SearchQuota) _then) = _$SearchQuotaCopyWithImpl;
@useResult
$Res call({
 int used, int limit, int remaining, String resetAt, bool allowed
});




}
/// @nodoc
class _$SearchQuotaCopyWithImpl<$Res>
    implements $SearchQuotaCopyWith<$Res> {
  _$SearchQuotaCopyWithImpl(this._self, this._then);

  final SearchQuota _self;
  final $Res Function(SearchQuota) _then;

/// Create a copy of SearchQuota
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? used = null,Object? limit = null,Object? remaining = null,Object? resetAt = null,Object? allowed = null,}) {
  return _then(_self.copyWith(
used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as int,resetAt: null == resetAt ? _self.resetAt : resetAt // ignore: cast_nullable_to_non_nullable
as String,allowed: null == allowed ? _self.allowed : allowed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchQuota].
extension SearchQuotaPatterns on SearchQuota {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchQuota value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchQuota() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchQuota value)  $default,){
final _that = this;
switch (_that) {
case _SearchQuota():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchQuota value)?  $default,){
final _that = this;
switch (_that) {
case _SearchQuota() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int used,  int limit,  int remaining,  String resetAt,  bool allowed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchQuota() when $default != null:
return $default(_that.used,_that.limit,_that.remaining,_that.resetAt,_that.allowed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int used,  int limit,  int remaining,  String resetAt,  bool allowed)  $default,) {final _that = this;
switch (_that) {
case _SearchQuota():
return $default(_that.used,_that.limit,_that.remaining,_that.resetAt,_that.allowed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int used,  int limit,  int remaining,  String resetAt,  bool allowed)?  $default,) {final _that = this;
switch (_that) {
case _SearchQuota() when $default != null:
return $default(_that.used,_that.limit,_that.remaining,_that.resetAt,_that.allowed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchQuota implements SearchQuota {
  const _SearchQuota({required this.used, required this.limit, required this.remaining, required this.resetAt, required this.allowed});
  factory _SearchQuota.fromJson(Map<String, dynamic> json) => _$SearchQuotaFromJson(json);

@override final  int used;
@override final  int limit;
@override final  int remaining;
@override final  String resetAt;
@override final  bool allowed;

/// Create a copy of SearchQuota
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchQuotaCopyWith<_SearchQuota> get copyWith => __$SearchQuotaCopyWithImpl<_SearchQuota>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchQuotaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchQuota&&(identical(other.used, used) || other.used == used)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.resetAt, resetAt) || other.resetAt == resetAt)&&(identical(other.allowed, allowed) || other.allowed == allowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,used,limit,remaining,resetAt,allowed);

@override
String toString() {
  return 'SearchQuota(used: $used, limit: $limit, remaining: $remaining, resetAt: $resetAt, allowed: $allowed)';
}


}

/// @nodoc
abstract mixin class _$SearchQuotaCopyWith<$Res> implements $SearchQuotaCopyWith<$Res> {
  factory _$SearchQuotaCopyWith(_SearchQuota value, $Res Function(_SearchQuota) _then) = __$SearchQuotaCopyWithImpl;
@override @useResult
$Res call({
 int used, int limit, int remaining, String resetAt, bool allowed
});




}
/// @nodoc
class __$SearchQuotaCopyWithImpl<$Res>
    implements _$SearchQuotaCopyWith<$Res> {
  __$SearchQuotaCopyWithImpl(this._self, this._then);

  final _SearchQuota _self;
  final $Res Function(_SearchQuota) _then;

/// Create a copy of SearchQuota
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? used = null,Object? limit = null,Object? remaining = null,Object? resetAt = null,Object? allowed = null,}) {
  return _then(_SearchQuota(
used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as int,resetAt: null == resetAt ? _self.resetAt : resetAt // ignore: cast_nullable_to_non_nullable
as String,allowed: null == allowed ? _self.allowed : allowed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$QuotaInfo {

 SearchQuota get search;
/// Create a copy of QuotaInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuotaInfoCopyWith<QuotaInfo> get copyWith => _$QuotaInfoCopyWithImpl<QuotaInfo>(this as QuotaInfo, _$identity);

  /// Serializes this QuotaInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuotaInfo&&(identical(other.search, search) || other.search == search));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,search);

@override
String toString() {
  return 'QuotaInfo(search: $search)';
}


}

/// @nodoc
abstract mixin class $QuotaInfoCopyWith<$Res>  {
  factory $QuotaInfoCopyWith(QuotaInfo value, $Res Function(QuotaInfo) _then) = _$QuotaInfoCopyWithImpl;
@useResult
$Res call({
 SearchQuota search
});


$SearchQuotaCopyWith<$Res> get search;

}
/// @nodoc
class _$QuotaInfoCopyWithImpl<$Res>
    implements $QuotaInfoCopyWith<$Res> {
  _$QuotaInfoCopyWithImpl(this._self, this._then);

  final QuotaInfo _self;
  final $Res Function(QuotaInfo) _then;

/// Create a copy of QuotaInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? search = null,}) {
  return _then(_self.copyWith(
search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as SearchQuota,
  ));
}
/// Create a copy of QuotaInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchQuotaCopyWith<$Res> get search {
  
  return $SearchQuotaCopyWith<$Res>(_self.search, (value) {
    return _then(_self.copyWith(search: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuotaInfo].
extension QuotaInfoPatterns on QuotaInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuotaInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuotaInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuotaInfo value)  $default,){
final _that = this;
switch (_that) {
case _QuotaInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuotaInfo value)?  $default,){
final _that = this;
switch (_that) {
case _QuotaInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SearchQuota search)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuotaInfo() when $default != null:
return $default(_that.search);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SearchQuota search)  $default,) {final _that = this;
switch (_that) {
case _QuotaInfo():
return $default(_that.search);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SearchQuota search)?  $default,) {final _that = this;
switch (_that) {
case _QuotaInfo() when $default != null:
return $default(_that.search);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuotaInfo implements QuotaInfo {
  const _QuotaInfo({required this.search});
  factory _QuotaInfo.fromJson(Map<String, dynamic> json) => _$QuotaInfoFromJson(json);

@override final  SearchQuota search;

/// Create a copy of QuotaInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuotaInfoCopyWith<_QuotaInfo> get copyWith => __$QuotaInfoCopyWithImpl<_QuotaInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuotaInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuotaInfo&&(identical(other.search, search) || other.search == search));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,search);

@override
String toString() {
  return 'QuotaInfo(search: $search)';
}


}

/// @nodoc
abstract mixin class _$QuotaInfoCopyWith<$Res> implements $QuotaInfoCopyWith<$Res> {
  factory _$QuotaInfoCopyWith(_QuotaInfo value, $Res Function(_QuotaInfo) _then) = __$QuotaInfoCopyWithImpl;
@override @useResult
$Res call({
 SearchQuota search
});


@override $SearchQuotaCopyWith<$Res> get search;

}
/// @nodoc
class __$QuotaInfoCopyWithImpl<$Res>
    implements _$QuotaInfoCopyWith<$Res> {
  __$QuotaInfoCopyWithImpl(this._self, this._then);

  final _QuotaInfo _self;
  final $Res Function(_QuotaInfo) _then;

/// Create a copy of QuotaInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? search = null,}) {
  return _then(_QuotaInfo(
search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as SearchQuota,
  ));
}

/// Create a copy of QuotaInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchQuotaCopyWith<$Res> get search {
  
  return $SearchQuotaCopyWith<$Res>(_self.search, (value) {
    return _then(_self.copyWith(search: value));
  });
}
}


/// @nodoc
mixin _$Subscription {

 String get userId; SubscriptionPlan get plan; SubscriptionStatus get status; String? get provider; String? get productId; String? get expiresAt;
/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionCopyWith<Subscription> get copyWith => _$SubscriptionCopyWithImpl<Subscription>(this as Subscription, _$identity);

  /// Serializes this Subscription to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Subscription&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,plan,status,provider,productId,expiresAt);

@override
String toString() {
  return 'Subscription(userId: $userId, plan: $plan, status: $status, provider: $provider, productId: $productId, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $SubscriptionCopyWith<$Res>  {
  factory $SubscriptionCopyWith(Subscription value, $Res Function(Subscription) _then) = _$SubscriptionCopyWithImpl;
@useResult
$Res call({
 String userId, SubscriptionPlan plan, SubscriptionStatus status, String? provider, String? productId, String? expiresAt
});




}
/// @nodoc
class _$SubscriptionCopyWithImpl<$Res>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._self, this._then);

  final Subscription _self;
  final $Res Function(Subscription) _then;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? plan = null,Object? status = null,Object? provider = freezed,Object? productId = freezed,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Subscription].
extension SubscriptionPatterns on Subscription {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Subscription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Subscription() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Subscription value)  $default,){
final _that = this;
switch (_that) {
case _Subscription():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Subscription value)?  $default,){
final _that = this;
switch (_that) {
case _Subscription() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  SubscriptionPlan plan,  SubscriptionStatus status,  String? provider,  String? productId,  String? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Subscription() when $default != null:
return $default(_that.userId,_that.plan,_that.status,_that.provider,_that.productId,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  SubscriptionPlan plan,  SubscriptionStatus status,  String? provider,  String? productId,  String? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _Subscription():
return $default(_that.userId,_that.plan,_that.status,_that.provider,_that.productId,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  SubscriptionPlan plan,  SubscriptionStatus status,  String? provider,  String? productId,  String? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _Subscription() when $default != null:
return $default(_that.userId,_that.plan,_that.status,_that.provider,_that.productId,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Subscription implements Subscription {
  const _Subscription({required this.userId, this.plan = SubscriptionPlan.FREE, this.status = SubscriptionStatus.NONE, this.provider, this.productId, this.expiresAt});
  factory _Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

@override final  String userId;
@override@JsonKey() final  SubscriptionPlan plan;
@override@JsonKey() final  SubscriptionStatus status;
@override final  String? provider;
@override final  String? productId;
@override final  String? expiresAt;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionCopyWith<_Subscription> get copyWith => __$SubscriptionCopyWithImpl<_Subscription>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Subscription&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,plan,status,provider,productId,expiresAt);

@override
String toString() {
  return 'Subscription(userId: $userId, plan: $plan, status: $status, provider: $provider, productId: $productId, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionCopyWith<$Res> implements $SubscriptionCopyWith<$Res> {
  factory _$SubscriptionCopyWith(_Subscription value, $Res Function(_Subscription) _then) = __$SubscriptionCopyWithImpl;
@override @useResult
$Res call({
 String userId, SubscriptionPlan plan, SubscriptionStatus status, String? provider, String? productId, String? expiresAt
});




}
/// @nodoc
class __$SubscriptionCopyWithImpl<$Res>
    implements _$SubscriptionCopyWith<$Res> {
  __$SubscriptionCopyWithImpl(this._self, this._then);

  final _Subscription _self;
  final $Res Function(_Subscription) _then;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? plan = null,Object? status = null,Object? provider = freezed,Object? productId = freezed,Object? expiresAt = freezed,}) {
  return _then(_Subscription(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BillingStatusResponse {

 Subscription get subscription; PlanCapabilities get capabilities; QuotaInfo get quota;
/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingStatusResponseCopyWith<BillingStatusResponse> get copyWith => _$BillingStatusResponseCopyWithImpl<BillingStatusResponse>(this as BillingStatusResponse, _$identity);

  /// Serializes this BillingStatusResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillingStatusResponse&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.capabilities, capabilities) || other.capabilities == capabilities)&&(identical(other.quota, quota) || other.quota == quota));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscription,capabilities,quota);

@override
String toString() {
  return 'BillingStatusResponse(subscription: $subscription, capabilities: $capabilities, quota: $quota)';
}


}

/// @nodoc
abstract mixin class $BillingStatusResponseCopyWith<$Res>  {
  factory $BillingStatusResponseCopyWith(BillingStatusResponse value, $Res Function(BillingStatusResponse) _then) = _$BillingStatusResponseCopyWithImpl;
@useResult
$Res call({
 Subscription subscription, PlanCapabilities capabilities, QuotaInfo quota
});


$SubscriptionCopyWith<$Res> get subscription;$PlanCapabilitiesCopyWith<$Res> get capabilities;$QuotaInfoCopyWith<$Res> get quota;

}
/// @nodoc
class _$BillingStatusResponseCopyWithImpl<$Res>
    implements $BillingStatusResponseCopyWith<$Res> {
  _$BillingStatusResponseCopyWithImpl(this._self, this._then);

  final BillingStatusResponse _self;
  final $Res Function(BillingStatusResponse) _then;

/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subscription = null,Object? capabilities = null,Object? quota = null,}) {
  return _then(_self.copyWith(
subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as Subscription,capabilities: null == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as PlanCapabilities,quota: null == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as QuotaInfo,
  ));
}
/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionCopyWith<$Res> get subscription {
  
  return $SubscriptionCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanCapabilitiesCopyWith<$Res> get capabilities {
  
  return $PlanCapabilitiesCopyWith<$Res>(_self.capabilities, (value) {
    return _then(_self.copyWith(capabilities: value));
  });
}/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuotaInfoCopyWith<$Res> get quota {
  
  return $QuotaInfoCopyWith<$Res>(_self.quota, (value) {
    return _then(_self.copyWith(quota: value));
  });
}
}


/// Adds pattern-matching-related methods to [BillingStatusResponse].
extension BillingStatusResponsePatterns on BillingStatusResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillingStatusResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillingStatusResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillingStatusResponse value)  $default,){
final _that = this;
switch (_that) {
case _BillingStatusResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillingStatusResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BillingStatusResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Subscription subscription,  PlanCapabilities capabilities,  QuotaInfo quota)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillingStatusResponse() when $default != null:
return $default(_that.subscription,_that.capabilities,_that.quota);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Subscription subscription,  PlanCapabilities capabilities,  QuotaInfo quota)  $default,) {final _that = this;
switch (_that) {
case _BillingStatusResponse():
return $default(_that.subscription,_that.capabilities,_that.quota);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Subscription subscription,  PlanCapabilities capabilities,  QuotaInfo quota)?  $default,) {final _that = this;
switch (_that) {
case _BillingStatusResponse() when $default != null:
return $default(_that.subscription,_that.capabilities,_that.quota);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillingStatusResponse extends BillingStatusResponse {
  const _BillingStatusResponse({required this.subscription, required this.capabilities, required this.quota}): super._();
  factory _BillingStatusResponse.fromJson(Map<String, dynamic> json) => _$BillingStatusResponseFromJson(json);

@override final  Subscription subscription;
@override final  PlanCapabilities capabilities;
@override final  QuotaInfo quota;

/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingStatusResponseCopyWith<_BillingStatusResponse> get copyWith => __$BillingStatusResponseCopyWithImpl<_BillingStatusResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillingStatusResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillingStatusResponse&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.capabilities, capabilities) || other.capabilities == capabilities)&&(identical(other.quota, quota) || other.quota == quota));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscription,capabilities,quota);

@override
String toString() {
  return 'BillingStatusResponse(subscription: $subscription, capabilities: $capabilities, quota: $quota)';
}


}

/// @nodoc
abstract mixin class _$BillingStatusResponseCopyWith<$Res> implements $BillingStatusResponseCopyWith<$Res> {
  factory _$BillingStatusResponseCopyWith(_BillingStatusResponse value, $Res Function(_BillingStatusResponse) _then) = __$BillingStatusResponseCopyWithImpl;
@override @useResult
$Res call({
 Subscription subscription, PlanCapabilities capabilities, QuotaInfo quota
});


@override $SubscriptionCopyWith<$Res> get subscription;@override $PlanCapabilitiesCopyWith<$Res> get capabilities;@override $QuotaInfoCopyWith<$Res> get quota;

}
/// @nodoc
class __$BillingStatusResponseCopyWithImpl<$Res>
    implements _$BillingStatusResponseCopyWith<$Res> {
  __$BillingStatusResponseCopyWithImpl(this._self, this._then);

  final _BillingStatusResponse _self;
  final $Res Function(_BillingStatusResponse) _then;

/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subscription = null,Object? capabilities = null,Object? quota = null,}) {
  return _then(_BillingStatusResponse(
subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as Subscription,capabilities: null == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as PlanCapabilities,quota: null == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as QuotaInfo,
  ));
}

/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionCopyWith<$Res> get subscription {
  
  return $SubscriptionCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanCapabilitiesCopyWith<$Res> get capabilities {
  
  return $PlanCapabilitiesCopyWith<$Res>(_self.capabilities, (value) {
    return _then(_self.copyWith(capabilities: value));
  });
}/// Create a copy of BillingStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuotaInfoCopyWith<$Res> get quota {
  
  return $QuotaInfoCopyWith<$Res>(_self.quota, (value) {
    return _then(_self.copyWith(quota: value));
  });
}
}


/// @nodoc
mixin _$ActivateGooglePlayRequest {

 String get subscriptionId; String get purchaseToken; String get orderId; String get packageName;
/// Create a copy of ActivateGooglePlayRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivateGooglePlayRequestCopyWith<ActivateGooglePlayRequest> get copyWith => _$ActivateGooglePlayRequestCopyWithImpl<ActivateGooglePlayRequest>(this as ActivateGooglePlayRequest, _$identity);

  /// Serializes this ActivateGooglePlayRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivateGooglePlayRequest&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.purchaseToken, purchaseToken) || other.purchaseToken == purchaseToken)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.packageName, packageName) || other.packageName == packageName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscriptionId,purchaseToken,orderId,packageName);

@override
String toString() {
  return 'ActivateGooglePlayRequest(subscriptionId: $subscriptionId, purchaseToken: $purchaseToken, orderId: $orderId, packageName: $packageName)';
}


}

/// @nodoc
abstract mixin class $ActivateGooglePlayRequestCopyWith<$Res>  {
  factory $ActivateGooglePlayRequestCopyWith(ActivateGooglePlayRequest value, $Res Function(ActivateGooglePlayRequest) _then) = _$ActivateGooglePlayRequestCopyWithImpl;
@useResult
$Res call({
 String subscriptionId, String purchaseToken, String orderId, String packageName
});




}
/// @nodoc
class _$ActivateGooglePlayRequestCopyWithImpl<$Res>
    implements $ActivateGooglePlayRequestCopyWith<$Res> {
  _$ActivateGooglePlayRequestCopyWithImpl(this._self, this._then);

  final ActivateGooglePlayRequest _self;
  final $Res Function(ActivateGooglePlayRequest) _then;

/// Create a copy of ActivateGooglePlayRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subscriptionId = null,Object? purchaseToken = null,Object? orderId = null,Object? packageName = null,}) {
  return _then(_self.copyWith(
subscriptionId: null == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String,purchaseToken: null == purchaseToken ? _self.purchaseToken : purchaseToken // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,packageName: null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivateGooglePlayRequest].
extension ActivateGooglePlayRequestPatterns on ActivateGooglePlayRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivateGooglePlayRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivateGooglePlayRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivateGooglePlayRequest value)  $default,){
final _that = this;
switch (_that) {
case _ActivateGooglePlayRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivateGooglePlayRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ActivateGooglePlayRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subscriptionId,  String purchaseToken,  String orderId,  String packageName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivateGooglePlayRequest() when $default != null:
return $default(_that.subscriptionId,_that.purchaseToken,_that.orderId,_that.packageName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subscriptionId,  String purchaseToken,  String orderId,  String packageName)  $default,) {final _that = this;
switch (_that) {
case _ActivateGooglePlayRequest():
return $default(_that.subscriptionId,_that.purchaseToken,_that.orderId,_that.packageName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subscriptionId,  String purchaseToken,  String orderId,  String packageName)?  $default,) {final _that = this;
switch (_that) {
case _ActivateGooglePlayRequest() when $default != null:
return $default(_that.subscriptionId,_that.purchaseToken,_that.orderId,_that.packageName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivateGooglePlayRequest implements ActivateGooglePlayRequest {
  const _ActivateGooglePlayRequest({required this.subscriptionId, required this.purchaseToken, required this.orderId, required this.packageName});
  factory _ActivateGooglePlayRequest.fromJson(Map<String, dynamic> json) => _$ActivateGooglePlayRequestFromJson(json);

@override final  String subscriptionId;
@override final  String purchaseToken;
@override final  String orderId;
@override final  String packageName;

/// Create a copy of ActivateGooglePlayRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivateGooglePlayRequestCopyWith<_ActivateGooglePlayRequest> get copyWith => __$ActivateGooglePlayRequestCopyWithImpl<_ActivateGooglePlayRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivateGooglePlayRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivateGooglePlayRequest&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.purchaseToken, purchaseToken) || other.purchaseToken == purchaseToken)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.packageName, packageName) || other.packageName == packageName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscriptionId,purchaseToken,orderId,packageName);

@override
String toString() {
  return 'ActivateGooglePlayRequest(subscriptionId: $subscriptionId, purchaseToken: $purchaseToken, orderId: $orderId, packageName: $packageName)';
}


}

/// @nodoc
abstract mixin class _$ActivateGooglePlayRequestCopyWith<$Res> implements $ActivateGooglePlayRequestCopyWith<$Res> {
  factory _$ActivateGooglePlayRequestCopyWith(_ActivateGooglePlayRequest value, $Res Function(_ActivateGooglePlayRequest) _then) = __$ActivateGooglePlayRequestCopyWithImpl;
@override @useResult
$Res call({
 String subscriptionId, String purchaseToken, String orderId, String packageName
});




}
/// @nodoc
class __$ActivateGooglePlayRequestCopyWithImpl<$Res>
    implements _$ActivateGooglePlayRequestCopyWith<$Res> {
  __$ActivateGooglePlayRequestCopyWithImpl(this._self, this._then);

  final _ActivateGooglePlayRequest _self;
  final $Res Function(_ActivateGooglePlayRequest) _then;

/// Create a copy of ActivateGooglePlayRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subscriptionId = null,Object? purchaseToken = null,Object? orderId = null,Object? packageName = null,}) {
  return _then(_ActivateGooglePlayRequest(
subscriptionId: null == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String,purchaseToken: null == purchaseToken ? _self.purchaseToken : purchaseToken // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,packageName: null == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
