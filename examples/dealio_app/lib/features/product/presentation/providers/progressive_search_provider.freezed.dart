// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progressive_search_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProgressiveSearchState {

 AsyncValue<SearchResponse?> get searchResponse; int get currentStage; bool get isPolling; String? get requestId; String? get stage2Error; String? get stage3Error; String? get lastQueryKey; DateTime? get lastRequestTime;
/// Create a copy of ProgressiveSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressiveSearchStateCopyWith<ProgressiveSearchState> get copyWith => _$ProgressiveSearchStateCopyWithImpl<ProgressiveSearchState>(this as ProgressiveSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressiveSearchState&&(identical(other.searchResponse, searchResponse) || other.searchResponse == searchResponse)&&(identical(other.currentStage, currentStage) || other.currentStage == currentStage)&&(identical(other.isPolling, isPolling) || other.isPolling == isPolling)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.stage2Error, stage2Error) || other.stage2Error == stage2Error)&&(identical(other.stage3Error, stage3Error) || other.stage3Error == stage3Error)&&(identical(other.lastQueryKey, lastQueryKey) || other.lastQueryKey == lastQueryKey)&&(identical(other.lastRequestTime, lastRequestTime) || other.lastRequestTime == lastRequestTime));
}


@override
int get hashCode => Object.hash(runtimeType,searchResponse,currentStage,isPolling,requestId,stage2Error,stage3Error,lastQueryKey,lastRequestTime);

@override
String toString() {
  return 'ProgressiveSearchState(searchResponse: $searchResponse, currentStage: $currentStage, isPolling: $isPolling, requestId: $requestId, stage2Error: $stage2Error, stage3Error: $stage3Error, lastQueryKey: $lastQueryKey, lastRequestTime: $lastRequestTime)';
}


}

/// @nodoc
abstract mixin class $ProgressiveSearchStateCopyWith<$Res>  {
  factory $ProgressiveSearchStateCopyWith(ProgressiveSearchState value, $Res Function(ProgressiveSearchState) _then) = _$ProgressiveSearchStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<SearchResponse?> searchResponse, int currentStage, bool isPolling, String? requestId, String? stage2Error, String? stage3Error, String? lastQueryKey, DateTime? lastRequestTime
});




}
/// @nodoc
class _$ProgressiveSearchStateCopyWithImpl<$Res>
    implements $ProgressiveSearchStateCopyWith<$Res> {
  _$ProgressiveSearchStateCopyWithImpl(this._self, this._then);

  final ProgressiveSearchState _self;
  final $Res Function(ProgressiveSearchState) _then;

/// Create a copy of ProgressiveSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchResponse = null,Object? currentStage = null,Object? isPolling = null,Object? requestId = freezed,Object? stage2Error = freezed,Object? stage3Error = freezed,Object? lastQueryKey = freezed,Object? lastRequestTime = freezed,}) {
  return _then(_self.copyWith(
searchResponse: null == searchResponse ? _self.searchResponse : searchResponse // ignore: cast_nullable_to_non_nullable
as AsyncValue<SearchResponse?>,currentStage: null == currentStage ? _self.currentStage : currentStage // ignore: cast_nullable_to_non_nullable
as int,isPolling: null == isPolling ? _self.isPolling : isPolling // ignore: cast_nullable_to_non_nullable
as bool,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,stage2Error: freezed == stage2Error ? _self.stage2Error : stage2Error // ignore: cast_nullable_to_non_nullable
as String?,stage3Error: freezed == stage3Error ? _self.stage3Error : stage3Error // ignore: cast_nullable_to_non_nullable
as String?,lastQueryKey: freezed == lastQueryKey ? _self.lastQueryKey : lastQueryKey // ignore: cast_nullable_to_non_nullable
as String?,lastRequestTime: freezed == lastRequestTime ? _self.lastRequestTime : lastRequestTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressiveSearchState].
extension ProgressiveSearchStatePatterns on ProgressiveSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressiveSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressiveSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressiveSearchState value)  $default,){
final _that = this;
switch (_that) {
case _ProgressiveSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressiveSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressiveSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AsyncValue<SearchResponse?> searchResponse,  int currentStage,  bool isPolling,  String? requestId,  String? stage2Error,  String? stage3Error,  String? lastQueryKey,  DateTime? lastRequestTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressiveSearchState() when $default != null:
return $default(_that.searchResponse,_that.currentStage,_that.isPolling,_that.requestId,_that.stage2Error,_that.stage3Error,_that.lastQueryKey,_that.lastRequestTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AsyncValue<SearchResponse?> searchResponse,  int currentStage,  bool isPolling,  String? requestId,  String? stage2Error,  String? stage3Error,  String? lastQueryKey,  DateTime? lastRequestTime)  $default,) {final _that = this;
switch (_that) {
case _ProgressiveSearchState():
return $default(_that.searchResponse,_that.currentStage,_that.isPolling,_that.requestId,_that.stage2Error,_that.stage3Error,_that.lastQueryKey,_that.lastRequestTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AsyncValue<SearchResponse?> searchResponse,  int currentStage,  bool isPolling,  String? requestId,  String? stage2Error,  String? stage3Error,  String? lastQueryKey,  DateTime? lastRequestTime)?  $default,) {final _that = this;
switch (_that) {
case _ProgressiveSearchState() when $default != null:
return $default(_that.searchResponse,_that.currentStage,_that.isPolling,_that.requestId,_that.stage2Error,_that.stage3Error,_that.lastQueryKey,_that.lastRequestTime);case _:
  return null;

}
}

}

/// @nodoc


class _ProgressiveSearchState implements ProgressiveSearchState {
  const _ProgressiveSearchState({required this.searchResponse, this.currentStage = 0, this.isPolling = false, this.requestId, this.stage2Error, this.stage3Error, this.lastQueryKey, this.lastRequestTime});
  

@override final  AsyncValue<SearchResponse?> searchResponse;
@override@JsonKey() final  int currentStage;
@override@JsonKey() final  bool isPolling;
@override final  String? requestId;
@override final  String? stage2Error;
@override final  String? stage3Error;
@override final  String? lastQueryKey;
@override final  DateTime? lastRequestTime;

/// Create a copy of ProgressiveSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressiveSearchStateCopyWith<_ProgressiveSearchState> get copyWith => __$ProgressiveSearchStateCopyWithImpl<_ProgressiveSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressiveSearchState&&(identical(other.searchResponse, searchResponse) || other.searchResponse == searchResponse)&&(identical(other.currentStage, currentStage) || other.currentStage == currentStage)&&(identical(other.isPolling, isPolling) || other.isPolling == isPolling)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.stage2Error, stage2Error) || other.stage2Error == stage2Error)&&(identical(other.stage3Error, stage3Error) || other.stage3Error == stage3Error)&&(identical(other.lastQueryKey, lastQueryKey) || other.lastQueryKey == lastQueryKey)&&(identical(other.lastRequestTime, lastRequestTime) || other.lastRequestTime == lastRequestTime));
}


@override
int get hashCode => Object.hash(runtimeType,searchResponse,currentStage,isPolling,requestId,stage2Error,stage3Error,lastQueryKey,lastRequestTime);

@override
String toString() {
  return 'ProgressiveSearchState(searchResponse: $searchResponse, currentStage: $currentStage, isPolling: $isPolling, requestId: $requestId, stage2Error: $stage2Error, stage3Error: $stage3Error, lastQueryKey: $lastQueryKey, lastRequestTime: $lastRequestTime)';
}


}

/// @nodoc
abstract mixin class _$ProgressiveSearchStateCopyWith<$Res> implements $ProgressiveSearchStateCopyWith<$Res> {
  factory _$ProgressiveSearchStateCopyWith(_ProgressiveSearchState value, $Res Function(_ProgressiveSearchState) _then) = __$ProgressiveSearchStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<SearchResponse?> searchResponse, int currentStage, bool isPolling, String? requestId, String? stage2Error, String? stage3Error, String? lastQueryKey, DateTime? lastRequestTime
});




}
/// @nodoc
class __$ProgressiveSearchStateCopyWithImpl<$Res>
    implements _$ProgressiveSearchStateCopyWith<$Res> {
  __$ProgressiveSearchStateCopyWithImpl(this._self, this._then);

  final _ProgressiveSearchState _self;
  final $Res Function(_ProgressiveSearchState) _then;

/// Create a copy of ProgressiveSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchResponse = null,Object? currentStage = null,Object? isPolling = null,Object? requestId = freezed,Object? stage2Error = freezed,Object? stage3Error = freezed,Object? lastQueryKey = freezed,Object? lastRequestTime = freezed,}) {
  return _then(_ProgressiveSearchState(
searchResponse: null == searchResponse ? _self.searchResponse : searchResponse // ignore: cast_nullable_to_non_nullable
as AsyncValue<SearchResponse?>,currentStage: null == currentStage ? _self.currentStage : currentStage // ignore: cast_nullable_to_non_nullable
as int,isPolling: null == isPolling ? _self.isPolling : isPolling // ignore: cast_nullable_to_non_nullable
as bool,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,stage2Error: freezed == stage2Error ? _self.stage2Error : stage2Error // ignore: cast_nullable_to_non_nullable
as String?,stage3Error: freezed == stage3Error ? _self.stage3Error : stage3Error // ignore: cast_nullable_to_non_nullable
as String?,lastQueryKey: freezed == lastQueryKey ? _self.lastQueryKey : lastQueryKey // ignore: cast_nullable_to_non_nullable
as String?,lastRequestTime: freezed == lastRequestTime ? _self.lastRequestTime : lastRequestTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
