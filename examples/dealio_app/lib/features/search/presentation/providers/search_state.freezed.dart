// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {

 SearchStatus get status; List<Product> get results; List<StoreOffer> get storeOffers; String? get requestId; String? get aiSummaryRequestId; String? get errorMessage; SearchRequest? get lastRequest;// Quota and Plan info from Stage 1
 SubscriptionPlan? get plan; String? get searchProvider; QuotaInfo? get quota;// Progressive tracking
 bool get stage2Error; bool get stage3Error; String get stage1Source;
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateCopyWith<SearchState> get copyWith => _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.results, results)&&const DeepCollectionEquality().equals(other.storeOffers, storeOffers)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.aiSummaryRequestId, aiSummaryRequestId) || other.aiSummaryRequestId == aiSummaryRequestId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastRequest, lastRequest) || other.lastRequest == lastRequest)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.searchProvider, searchProvider) || other.searchProvider == searchProvider)&&(identical(other.quota, quota) || other.quota == quota)&&(identical(other.stage2Error, stage2Error) || other.stage2Error == stage2Error)&&(identical(other.stage3Error, stage3Error) || other.stage3Error == stage3Error)&&(identical(other.stage1Source, stage1Source) || other.stage1Source == stage1Source));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(results),const DeepCollectionEquality().hash(storeOffers),requestId,aiSummaryRequestId,errorMessage,lastRequest,plan,searchProvider,quota,stage2Error,stage3Error,stage1Source);

@override
String toString() {
  return 'SearchState(status: $status, results: $results, storeOffers: $storeOffers, requestId: $requestId, aiSummaryRequestId: $aiSummaryRequestId, errorMessage: $errorMessage, lastRequest: $lastRequest, plan: $plan, searchProvider: $searchProvider, quota: $quota, stage2Error: $stage2Error, stage3Error: $stage3Error, stage1Source: $stage1Source)';
}


}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res>  {
  factory $SearchStateCopyWith(SearchState value, $Res Function(SearchState) _then) = _$SearchStateCopyWithImpl;
@useResult
$Res call({
 SearchStatus status, List<Product> results, List<StoreOffer> storeOffers, String? requestId, String? aiSummaryRequestId, String? errorMessage, SearchRequest? lastRequest, SubscriptionPlan? plan, String? searchProvider, QuotaInfo? quota, bool stage2Error, bool stage3Error, String stage1Source
});


$SearchRequestCopyWith<$Res>? get lastRequest;$QuotaInfoCopyWith<$Res>? get quota;

}
/// @nodoc
class _$SearchStateCopyWithImpl<$Res>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? results = null,Object? storeOffers = null,Object? requestId = freezed,Object? aiSummaryRequestId = freezed,Object? errorMessage = freezed,Object? lastRequest = freezed,Object? plan = freezed,Object? searchProvider = freezed,Object? quota = freezed,Object? stage2Error = null,Object? stage3Error = null,Object? stage1Source = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SearchStatus,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<Product>,storeOffers: null == storeOffers ? _self.storeOffers : storeOffers // ignore: cast_nullable_to_non_nullable
as List<StoreOffer>,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,aiSummaryRequestId: freezed == aiSummaryRequestId ? _self.aiSummaryRequestId : aiSummaryRequestId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastRequest: freezed == lastRequest ? _self.lastRequest : lastRequest // ignore: cast_nullable_to_non_nullable
as SearchRequest?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan?,searchProvider: freezed == searchProvider ? _self.searchProvider : searchProvider // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as QuotaInfo?,stage2Error: null == stage2Error ? _self.stage2Error : stage2Error // ignore: cast_nullable_to_non_nullable
as bool,stage3Error: null == stage3Error ? _self.stage3Error : stage3Error // ignore: cast_nullable_to_non_nullable
as bool,stage1Source: null == stage1Source ? _self.stage1Source : stage1Source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchRequestCopyWith<$Res>? get lastRequest {
    if (_self.lastRequest == null) {
    return null;
  }

  return $SearchRequestCopyWith<$Res>(_self.lastRequest!, (value) {
    return _then(_self.copyWith(lastRequest: value));
  });
}/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuotaInfoCopyWith<$Res>? get quota {
    if (_self.quota == null) {
    return null;
  }

  return $QuotaInfoCopyWith<$Res>(_self.quota!, (value) {
    return _then(_self.copyWith(quota: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchState value)  $default,){
final _that = this;
switch (_that) {
case _SearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchState value)?  $default,){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SearchStatus status,  List<Product> results,  List<StoreOffer> storeOffers,  String? requestId,  String? aiSummaryRequestId,  String? errorMessage,  SearchRequest? lastRequest,  SubscriptionPlan? plan,  String? searchProvider,  QuotaInfo? quota,  bool stage2Error,  bool stage3Error,  String stage1Source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.status,_that.results,_that.storeOffers,_that.requestId,_that.aiSummaryRequestId,_that.errorMessage,_that.lastRequest,_that.plan,_that.searchProvider,_that.quota,_that.stage2Error,_that.stage3Error,_that.stage1Source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SearchStatus status,  List<Product> results,  List<StoreOffer> storeOffers,  String? requestId,  String? aiSummaryRequestId,  String? errorMessage,  SearchRequest? lastRequest,  SubscriptionPlan? plan,  String? searchProvider,  QuotaInfo? quota,  bool stage2Error,  bool stage3Error,  String stage1Source)  $default,) {final _that = this;
switch (_that) {
case _SearchState():
return $default(_that.status,_that.results,_that.storeOffers,_that.requestId,_that.aiSummaryRequestId,_that.errorMessage,_that.lastRequest,_that.plan,_that.searchProvider,_that.quota,_that.stage2Error,_that.stage3Error,_that.stage1Source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SearchStatus status,  List<Product> results,  List<StoreOffer> storeOffers,  String? requestId,  String? aiSummaryRequestId,  String? errorMessage,  SearchRequest? lastRequest,  SubscriptionPlan? plan,  String? searchProvider,  QuotaInfo? quota,  bool stage2Error,  bool stage3Error,  String stage1Source)?  $default,) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.status,_that.results,_that.storeOffers,_that.requestId,_that.aiSummaryRequestId,_that.errorMessage,_that.lastRequest,_that.plan,_that.searchProvider,_that.quota,_that.stage2Error,_that.stage3Error,_that.stage1Source);case _:
  return null;

}
}

}

/// @nodoc


class _SearchState implements SearchState {
  const _SearchState({this.status = SearchStatus.idle, final  List<Product> results = const [], final  List<StoreOffer> storeOffers = const [], this.requestId, this.aiSummaryRequestId, this.errorMessage, this.lastRequest, this.plan, this.searchProvider, this.quota, this.stage2Error = false, this.stage3Error = false, this.stage1Source = ''}): _results = results,_storeOffers = storeOffers;
  

@override@JsonKey() final  SearchStatus status;
 final  List<Product> _results;
@override@JsonKey() List<Product> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  List<StoreOffer> _storeOffers;
@override@JsonKey() List<StoreOffer> get storeOffers {
  if (_storeOffers is EqualUnmodifiableListView) return _storeOffers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_storeOffers);
}

@override final  String? requestId;
@override final  String? aiSummaryRequestId;
@override final  String? errorMessage;
@override final  SearchRequest? lastRequest;
// Quota and Plan info from Stage 1
@override final  SubscriptionPlan? plan;
@override final  String? searchProvider;
@override final  QuotaInfo? quota;
// Progressive tracking
@override@JsonKey() final  bool stage2Error;
@override@JsonKey() final  bool stage3Error;
@override@JsonKey() final  String stage1Source;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStateCopyWith<_SearchState> get copyWith => __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._results, _results)&&const DeepCollectionEquality().equals(other._storeOffers, _storeOffers)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.aiSummaryRequestId, aiSummaryRequestId) || other.aiSummaryRequestId == aiSummaryRequestId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastRequest, lastRequest) || other.lastRequest == lastRequest)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.searchProvider, searchProvider) || other.searchProvider == searchProvider)&&(identical(other.quota, quota) || other.quota == quota)&&(identical(other.stage2Error, stage2Error) || other.stage2Error == stage2Error)&&(identical(other.stage3Error, stage3Error) || other.stage3Error == stage3Error)&&(identical(other.stage1Source, stage1Source) || other.stage1Source == stage1Source));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(_storeOffers),requestId,aiSummaryRequestId,errorMessage,lastRequest,plan,searchProvider,quota,stage2Error,stage3Error,stage1Source);

@override
String toString() {
  return 'SearchState(status: $status, results: $results, storeOffers: $storeOffers, requestId: $requestId, aiSummaryRequestId: $aiSummaryRequestId, errorMessage: $errorMessage, lastRequest: $lastRequest, plan: $plan, searchProvider: $searchProvider, quota: $quota, stage2Error: $stage2Error, stage3Error: $stage3Error, stage1Source: $stage1Source)';
}


}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(_SearchState value, $Res Function(_SearchState) _then) = __$SearchStateCopyWithImpl;
@override @useResult
$Res call({
 SearchStatus status, List<Product> results, List<StoreOffer> storeOffers, String? requestId, String? aiSummaryRequestId, String? errorMessage, SearchRequest? lastRequest, SubscriptionPlan? plan, String? searchProvider, QuotaInfo? quota, bool stage2Error, bool stage3Error, String stage1Source
});


@override $SearchRequestCopyWith<$Res>? get lastRequest;@override $QuotaInfoCopyWith<$Res>? get quota;

}
/// @nodoc
class __$SearchStateCopyWithImpl<$Res>
    implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? results = null,Object? storeOffers = null,Object? requestId = freezed,Object? aiSummaryRequestId = freezed,Object? errorMessage = freezed,Object? lastRequest = freezed,Object? plan = freezed,Object? searchProvider = freezed,Object? quota = freezed,Object? stage2Error = null,Object? stage3Error = null,Object? stage1Source = null,}) {
  return _then(_SearchState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SearchStatus,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Product>,storeOffers: null == storeOffers ? _self._storeOffers : storeOffers // ignore: cast_nullable_to_non_nullable
as List<StoreOffer>,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,aiSummaryRequestId: freezed == aiSummaryRequestId ? _self.aiSummaryRequestId : aiSummaryRequestId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastRequest: freezed == lastRequest ? _self.lastRequest : lastRequest // ignore: cast_nullable_to_non_nullable
as SearchRequest?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan?,searchProvider: freezed == searchProvider ? _self.searchProvider : searchProvider // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as QuotaInfo?,stage2Error: null == stage2Error ? _self.stage2Error : stage2Error // ignore: cast_nullable_to_non_nullable
as bool,stage3Error: null == stage3Error ? _self.stage3Error : stage3Error // ignore: cast_nullable_to_non_nullable
as bool,stage1Source: null == stage1Source ? _self.stage1Source : stage1Source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchRequestCopyWith<$Res>? get lastRequest {
    if (_self.lastRequest == null) {
    return null;
  }

  return $SearchRequestCopyWith<$Res>(_self.lastRequest!, (value) {
    return _then(_self.copyWith(lastRequest: value));
  });
}/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuotaInfoCopyWith<$Res>? get quota {
    if (_self.quota == null) {
    return null;
  }

  return $QuotaInfoCopyWith<$Res>(_self.quota!, (value) {
    return _then(_self.copyWith(quota: value));
  });
}
}

// dart format on
