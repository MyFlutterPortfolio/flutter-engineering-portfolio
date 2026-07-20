// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_analysis_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageAnalysisResponseDto {

 bool get success; ImageAnalysisDataDto get imageAnalysis;
/// Create a copy of ImageAnalysisResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageAnalysisResponseDtoCopyWith<ImageAnalysisResponseDto> get copyWith => _$ImageAnalysisResponseDtoCopyWithImpl<ImageAnalysisResponseDto>(this as ImageAnalysisResponseDto, _$identity);

  /// Serializes this ImageAnalysisResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageAnalysisResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.imageAnalysis, imageAnalysis) || other.imageAnalysis == imageAnalysis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,imageAnalysis);

@override
String toString() {
  return 'ImageAnalysisResponseDto(success: $success, imageAnalysis: $imageAnalysis)';
}


}

/// @nodoc
abstract mixin class $ImageAnalysisResponseDtoCopyWith<$Res>  {
  factory $ImageAnalysisResponseDtoCopyWith(ImageAnalysisResponseDto value, $Res Function(ImageAnalysisResponseDto) _then) = _$ImageAnalysisResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool success, ImageAnalysisDataDto imageAnalysis
});


$ImageAnalysisDataDtoCopyWith<$Res> get imageAnalysis;

}
/// @nodoc
class _$ImageAnalysisResponseDtoCopyWithImpl<$Res>
    implements $ImageAnalysisResponseDtoCopyWith<$Res> {
  _$ImageAnalysisResponseDtoCopyWithImpl(this._self, this._then);

  final ImageAnalysisResponseDto _self;
  final $Res Function(ImageAnalysisResponseDto) _then;

/// Create a copy of ImageAnalysisResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? imageAnalysis = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,imageAnalysis: null == imageAnalysis ? _self.imageAnalysis : imageAnalysis // ignore: cast_nullable_to_non_nullable
as ImageAnalysisDataDto,
  ));
}
/// Create a copy of ImageAnalysisResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageAnalysisDataDtoCopyWith<$Res> get imageAnalysis {
  
  return $ImageAnalysisDataDtoCopyWith<$Res>(_self.imageAnalysis, (value) {
    return _then(_self.copyWith(imageAnalysis: value));
  });
}
}


/// Adds pattern-matching-related methods to [ImageAnalysisResponseDto].
extension ImageAnalysisResponseDtoPatterns on ImageAnalysisResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageAnalysisResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageAnalysisResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageAnalysisResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ImageAnalysisResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageAnalysisResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ImageAnalysisResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  ImageAnalysisDataDto imageAnalysis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageAnalysisResponseDto() when $default != null:
return $default(_that.success,_that.imageAnalysis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  ImageAnalysisDataDto imageAnalysis)  $default,) {final _that = this;
switch (_that) {
case _ImageAnalysisResponseDto():
return $default(_that.success,_that.imageAnalysis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  ImageAnalysisDataDto imageAnalysis)?  $default,) {final _that = this;
switch (_that) {
case _ImageAnalysisResponseDto() when $default != null:
return $default(_that.success,_that.imageAnalysis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageAnalysisResponseDto implements ImageAnalysisResponseDto {
  const _ImageAnalysisResponseDto({required this.success, required this.imageAnalysis});
  factory _ImageAnalysisResponseDto.fromJson(Map<String, dynamic> json) => _$ImageAnalysisResponseDtoFromJson(json);

@override final  bool success;
@override final  ImageAnalysisDataDto imageAnalysis;

/// Create a copy of ImageAnalysisResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageAnalysisResponseDtoCopyWith<_ImageAnalysisResponseDto> get copyWith => __$ImageAnalysisResponseDtoCopyWithImpl<_ImageAnalysisResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageAnalysisResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageAnalysisResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.imageAnalysis, imageAnalysis) || other.imageAnalysis == imageAnalysis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,imageAnalysis);

@override
String toString() {
  return 'ImageAnalysisResponseDto(success: $success, imageAnalysis: $imageAnalysis)';
}


}

/// @nodoc
abstract mixin class _$ImageAnalysisResponseDtoCopyWith<$Res> implements $ImageAnalysisResponseDtoCopyWith<$Res> {
  factory _$ImageAnalysisResponseDtoCopyWith(_ImageAnalysisResponseDto value, $Res Function(_ImageAnalysisResponseDto) _then) = __$ImageAnalysisResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool success, ImageAnalysisDataDto imageAnalysis
});


@override $ImageAnalysisDataDtoCopyWith<$Res> get imageAnalysis;

}
/// @nodoc
class __$ImageAnalysisResponseDtoCopyWithImpl<$Res>
    implements _$ImageAnalysisResponseDtoCopyWith<$Res> {
  __$ImageAnalysisResponseDtoCopyWithImpl(this._self, this._then);

  final _ImageAnalysisResponseDto _self;
  final $Res Function(_ImageAnalysisResponseDto) _then;

/// Create a copy of ImageAnalysisResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? imageAnalysis = null,}) {
  return _then(_ImageAnalysisResponseDto(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,imageAnalysis: null == imageAnalysis ? _self.imageAnalysis : imageAnalysis // ignore: cast_nullable_to_non_nullable
as ImageAnalysisDataDto,
  ));
}

/// Create a copy of ImageAnalysisResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageAnalysisDataDtoCopyWith<$Res> get imageAnalysis {
  
  return $ImageAnalysisDataDtoCopyWith<$Res>(_self.imageAnalysis, (value) {
    return _then(_self.copyWith(imageAnalysis: value));
  });
}
}


/// @nodoc
mixin _$ImageAnalysisDataDto {

 String get detectedProduct; String get productTitle; int get confidence; String get color; String get brand; String get category; Map<String, dynamic> get features;
/// Create a copy of ImageAnalysisDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageAnalysisDataDtoCopyWith<ImageAnalysisDataDto> get copyWith => _$ImageAnalysisDataDtoCopyWithImpl<ImageAnalysisDataDto>(this as ImageAnalysisDataDto, _$identity);

  /// Serializes this ImageAnalysisDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageAnalysisDataDto&&(identical(other.detectedProduct, detectedProduct) || other.detectedProduct == detectedProduct)&&(identical(other.productTitle, productTitle) || other.productTitle == productTitle)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.color, color) || other.color == color)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.features, features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectedProduct,productTitle,confidence,color,brand,category,const DeepCollectionEquality().hash(features));

@override
String toString() {
  return 'ImageAnalysisDataDto(detectedProduct: $detectedProduct, productTitle: $productTitle, confidence: $confidence, color: $color, brand: $brand, category: $category, features: $features)';
}


}

/// @nodoc
abstract mixin class $ImageAnalysisDataDtoCopyWith<$Res>  {
  factory $ImageAnalysisDataDtoCopyWith(ImageAnalysisDataDto value, $Res Function(ImageAnalysisDataDto) _then) = _$ImageAnalysisDataDtoCopyWithImpl;
@useResult
$Res call({
 String detectedProduct, String productTitle, int confidence, String color, String brand, String category, Map<String, dynamic> features
});




}
/// @nodoc
class _$ImageAnalysisDataDtoCopyWithImpl<$Res>
    implements $ImageAnalysisDataDtoCopyWith<$Res> {
  _$ImageAnalysisDataDtoCopyWithImpl(this._self, this._then);

  final ImageAnalysisDataDto _self;
  final $Res Function(ImageAnalysisDataDto) _then;

/// Create a copy of ImageAnalysisDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? detectedProduct = null,Object? productTitle = null,Object? confidence = null,Object? color = null,Object? brand = null,Object? category = null,Object? features = null,}) {
  return _then(_self.copyWith(
detectedProduct: null == detectedProduct ? _self.detectedProduct : detectedProduct // ignore: cast_nullable_to_non_nullable
as String,productTitle: null == productTitle ? _self.productTitle : productTitle // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageAnalysisDataDto].
extension ImageAnalysisDataDtoPatterns on ImageAnalysisDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageAnalysisDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageAnalysisDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageAnalysisDataDto value)  $default,){
final _that = this;
switch (_that) {
case _ImageAnalysisDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageAnalysisDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _ImageAnalysisDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String detectedProduct,  String productTitle,  int confidence,  String color,  String brand,  String category,  Map<String, dynamic> features)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageAnalysisDataDto() when $default != null:
return $default(_that.detectedProduct,_that.productTitle,_that.confidence,_that.color,_that.brand,_that.category,_that.features);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String detectedProduct,  String productTitle,  int confidence,  String color,  String brand,  String category,  Map<String, dynamic> features)  $default,) {final _that = this;
switch (_that) {
case _ImageAnalysisDataDto():
return $default(_that.detectedProduct,_that.productTitle,_that.confidence,_that.color,_that.brand,_that.category,_that.features);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String detectedProduct,  String productTitle,  int confidence,  String color,  String brand,  String category,  Map<String, dynamic> features)?  $default,) {final _that = this;
switch (_that) {
case _ImageAnalysisDataDto() when $default != null:
return $default(_that.detectedProduct,_that.productTitle,_that.confidence,_that.color,_that.brand,_that.category,_that.features);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageAnalysisDataDto extends ImageAnalysisDataDto {
  const _ImageAnalysisDataDto({required this.detectedProduct, required this.productTitle, required this.confidence, required this.color, required this.brand, required this.category, required final  Map<String, dynamic> features}): _features = features,super._();
  factory _ImageAnalysisDataDto.fromJson(Map<String, dynamic> json) => _$ImageAnalysisDataDtoFromJson(json);

@override final  String detectedProduct;
@override final  String productTitle;
@override final  int confidence;
@override final  String color;
@override final  String brand;
@override final  String category;
 final  Map<String, dynamic> _features;
@override Map<String, dynamic> get features {
  if (_features is EqualUnmodifiableMapView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_features);
}


/// Create a copy of ImageAnalysisDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageAnalysisDataDtoCopyWith<_ImageAnalysisDataDto> get copyWith => __$ImageAnalysisDataDtoCopyWithImpl<_ImageAnalysisDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageAnalysisDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageAnalysisDataDto&&(identical(other.detectedProduct, detectedProduct) || other.detectedProduct == detectedProduct)&&(identical(other.productTitle, productTitle) || other.productTitle == productTitle)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.color, color) || other.color == color)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._features, _features));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectedProduct,productTitle,confidence,color,brand,category,const DeepCollectionEquality().hash(_features));

@override
String toString() {
  return 'ImageAnalysisDataDto(detectedProduct: $detectedProduct, productTitle: $productTitle, confidence: $confidence, color: $color, brand: $brand, category: $category, features: $features)';
}


}

/// @nodoc
abstract mixin class _$ImageAnalysisDataDtoCopyWith<$Res> implements $ImageAnalysisDataDtoCopyWith<$Res> {
  factory _$ImageAnalysisDataDtoCopyWith(_ImageAnalysisDataDto value, $Res Function(_ImageAnalysisDataDto) _then) = __$ImageAnalysisDataDtoCopyWithImpl;
@override @useResult
$Res call({
 String detectedProduct, String productTitle, int confidence, String color, String brand, String category, Map<String, dynamic> features
});




}
/// @nodoc
class __$ImageAnalysisDataDtoCopyWithImpl<$Res>
    implements _$ImageAnalysisDataDtoCopyWith<$Res> {
  __$ImageAnalysisDataDtoCopyWithImpl(this._self, this._then);

  final _ImageAnalysisDataDto _self;
  final $Res Function(_ImageAnalysisDataDto) _then;

/// Create a copy of ImageAnalysisDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detectedProduct = null,Object? productTitle = null,Object? confidence = null,Object? color = null,Object? brand = null,Object? category = null,Object? features = null,}) {
  return _then(_ImageAnalysisDataDto(
detectedProduct: null == detectedProduct ? _self.detectedProduct : detectedProduct // ignore: cast_nullable_to_non_nullable
as String,productTitle: null == productTitle ? _self.productTitle : productTitle // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
