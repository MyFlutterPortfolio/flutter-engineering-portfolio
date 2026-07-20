// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barcode_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BarcodeProcessResponseDto {

 bool get success; BarcodeDataDto get barcode;
/// Create a copy of BarcodeProcessResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarcodeProcessResponseDtoCopyWith<BarcodeProcessResponseDto> get copyWith => _$BarcodeProcessResponseDtoCopyWithImpl<BarcodeProcessResponseDto>(this as BarcodeProcessResponseDto, _$identity);

  /// Serializes this BarcodeProcessResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarcodeProcessResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.barcode, barcode) || other.barcode == barcode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,barcode);

@override
String toString() {
  return 'BarcodeProcessResponseDto(success: $success, barcode: $barcode)';
}


}

/// @nodoc
abstract mixin class $BarcodeProcessResponseDtoCopyWith<$Res>  {
  factory $BarcodeProcessResponseDtoCopyWith(BarcodeProcessResponseDto value, $Res Function(BarcodeProcessResponseDto) _then) = _$BarcodeProcessResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool success, BarcodeDataDto barcode
});


$BarcodeDataDtoCopyWith<$Res> get barcode;

}
/// @nodoc
class _$BarcodeProcessResponseDtoCopyWithImpl<$Res>
    implements $BarcodeProcessResponseDtoCopyWith<$Res> {
  _$BarcodeProcessResponseDtoCopyWithImpl(this._self, this._then);

  final BarcodeProcessResponseDto _self;
  final $Res Function(BarcodeProcessResponseDto) _then;

/// Create a copy of BarcodeProcessResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? barcode = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,barcode: null == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as BarcodeDataDto,
  ));
}
/// Create a copy of BarcodeProcessResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BarcodeDataDtoCopyWith<$Res> get barcode {
  
  return $BarcodeDataDtoCopyWith<$Res>(_self.barcode, (value) {
    return _then(_self.copyWith(barcode: value));
  });
}
}


/// Adds pattern-matching-related methods to [BarcodeProcessResponseDto].
extension BarcodeProcessResponseDtoPatterns on BarcodeProcessResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BarcodeProcessResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BarcodeProcessResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BarcodeProcessResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _BarcodeProcessResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BarcodeProcessResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _BarcodeProcessResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  BarcodeDataDto barcode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BarcodeProcessResponseDto() when $default != null:
return $default(_that.success,_that.barcode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  BarcodeDataDto barcode)  $default,) {final _that = this;
switch (_that) {
case _BarcodeProcessResponseDto():
return $default(_that.success,_that.barcode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  BarcodeDataDto barcode)?  $default,) {final _that = this;
switch (_that) {
case _BarcodeProcessResponseDto() when $default != null:
return $default(_that.success,_that.barcode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BarcodeProcessResponseDto implements BarcodeProcessResponseDto {
  const _BarcodeProcessResponseDto({required this.success, required this.barcode});
  factory _BarcodeProcessResponseDto.fromJson(Map<String, dynamic> json) => _$BarcodeProcessResponseDtoFromJson(json);

@override final  bool success;
@override final  BarcodeDataDto barcode;

/// Create a copy of BarcodeProcessResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BarcodeProcessResponseDtoCopyWith<_BarcodeProcessResponseDto> get copyWith => __$BarcodeProcessResponseDtoCopyWithImpl<_BarcodeProcessResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BarcodeProcessResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BarcodeProcessResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.barcode, barcode) || other.barcode == barcode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,barcode);

@override
String toString() {
  return 'BarcodeProcessResponseDto(success: $success, barcode: $barcode)';
}


}

/// @nodoc
abstract mixin class _$BarcodeProcessResponseDtoCopyWith<$Res> implements $BarcodeProcessResponseDtoCopyWith<$Res> {
  factory _$BarcodeProcessResponseDtoCopyWith(_BarcodeProcessResponseDto value, $Res Function(_BarcodeProcessResponseDto) _then) = __$BarcodeProcessResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool success, BarcodeDataDto barcode
});


@override $BarcodeDataDtoCopyWith<$Res> get barcode;

}
/// @nodoc
class __$BarcodeProcessResponseDtoCopyWithImpl<$Res>
    implements _$BarcodeProcessResponseDtoCopyWith<$Res> {
  __$BarcodeProcessResponseDtoCopyWithImpl(this._self, this._then);

  final _BarcodeProcessResponseDto _self;
  final $Res Function(_BarcodeProcessResponseDto) _then;

/// Create a copy of BarcodeProcessResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? barcode = null,}) {
  return _then(_BarcodeProcessResponseDto(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,barcode: null == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as BarcodeDataDto,
  ));
}

/// Create a copy of BarcodeProcessResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BarcodeDataDtoCopyWith<$Res> get barcode {
  
  return $BarcodeDataDtoCopyWith<$Res>(_self.barcode, (value) {
    return _then(_self.copyWith(barcode: value));
  });
}
}


/// @nodoc
mixin _$BarcodeDataDto {

 String get barcodeNumber; String get barcodeType; Map<String, dynamic> get productInfo;
/// Create a copy of BarcodeDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarcodeDataDtoCopyWith<BarcodeDataDto> get copyWith => _$BarcodeDataDtoCopyWithImpl<BarcodeDataDto>(this as BarcodeDataDto, _$identity);

  /// Serializes this BarcodeDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarcodeDataDto&&(identical(other.barcodeNumber, barcodeNumber) || other.barcodeNumber == barcodeNumber)&&(identical(other.barcodeType, barcodeType) || other.barcodeType == barcodeType)&&const DeepCollectionEquality().equals(other.productInfo, productInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,barcodeNumber,barcodeType,const DeepCollectionEquality().hash(productInfo));

@override
String toString() {
  return 'BarcodeDataDto(barcodeNumber: $barcodeNumber, barcodeType: $barcodeType, productInfo: $productInfo)';
}


}

/// @nodoc
abstract mixin class $BarcodeDataDtoCopyWith<$Res>  {
  factory $BarcodeDataDtoCopyWith(BarcodeDataDto value, $Res Function(BarcodeDataDto) _then) = _$BarcodeDataDtoCopyWithImpl;
@useResult
$Res call({
 String barcodeNumber, String barcodeType, Map<String, dynamic> productInfo
});




}
/// @nodoc
class _$BarcodeDataDtoCopyWithImpl<$Res>
    implements $BarcodeDataDtoCopyWith<$Res> {
  _$BarcodeDataDtoCopyWithImpl(this._self, this._then);

  final BarcodeDataDto _self;
  final $Res Function(BarcodeDataDto) _then;

/// Create a copy of BarcodeDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? barcodeNumber = null,Object? barcodeType = null,Object? productInfo = null,}) {
  return _then(_self.copyWith(
barcodeNumber: null == barcodeNumber ? _self.barcodeNumber : barcodeNumber // ignore: cast_nullable_to_non_nullable
as String,barcodeType: null == barcodeType ? _self.barcodeType : barcodeType // ignore: cast_nullable_to_non_nullable
as String,productInfo: null == productInfo ? _self.productInfo : productInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [BarcodeDataDto].
extension BarcodeDataDtoPatterns on BarcodeDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BarcodeDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BarcodeDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BarcodeDataDto value)  $default,){
final _that = this;
switch (_that) {
case _BarcodeDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BarcodeDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _BarcodeDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String barcodeNumber,  String barcodeType,  Map<String, dynamic> productInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BarcodeDataDto() when $default != null:
return $default(_that.barcodeNumber,_that.barcodeType,_that.productInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String barcodeNumber,  String barcodeType,  Map<String, dynamic> productInfo)  $default,) {final _that = this;
switch (_that) {
case _BarcodeDataDto():
return $default(_that.barcodeNumber,_that.barcodeType,_that.productInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String barcodeNumber,  String barcodeType,  Map<String, dynamic> productInfo)?  $default,) {final _that = this;
switch (_that) {
case _BarcodeDataDto() when $default != null:
return $default(_that.barcodeNumber,_that.barcodeType,_that.productInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BarcodeDataDto extends BarcodeDataDto {
  const _BarcodeDataDto({required this.barcodeNumber, required this.barcodeType, required final  Map<String, dynamic> productInfo}): _productInfo = productInfo,super._();
  factory _BarcodeDataDto.fromJson(Map<String, dynamic> json) => _$BarcodeDataDtoFromJson(json);

@override final  String barcodeNumber;
@override final  String barcodeType;
 final  Map<String, dynamic> _productInfo;
@override Map<String, dynamic> get productInfo {
  if (_productInfo is EqualUnmodifiableMapView) return _productInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_productInfo);
}


/// Create a copy of BarcodeDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BarcodeDataDtoCopyWith<_BarcodeDataDto> get copyWith => __$BarcodeDataDtoCopyWithImpl<_BarcodeDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BarcodeDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BarcodeDataDto&&(identical(other.barcodeNumber, barcodeNumber) || other.barcodeNumber == barcodeNumber)&&(identical(other.barcodeType, barcodeType) || other.barcodeType == barcodeType)&&const DeepCollectionEquality().equals(other._productInfo, _productInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,barcodeNumber,barcodeType,const DeepCollectionEquality().hash(_productInfo));

@override
String toString() {
  return 'BarcodeDataDto(barcodeNumber: $barcodeNumber, barcodeType: $barcodeType, productInfo: $productInfo)';
}


}

/// @nodoc
abstract mixin class _$BarcodeDataDtoCopyWith<$Res> implements $BarcodeDataDtoCopyWith<$Res> {
  factory _$BarcodeDataDtoCopyWith(_BarcodeDataDto value, $Res Function(_BarcodeDataDto) _then) = __$BarcodeDataDtoCopyWithImpl;
@override @useResult
$Res call({
 String barcodeNumber, String barcodeType, Map<String, dynamic> productInfo
});




}
/// @nodoc
class __$BarcodeDataDtoCopyWithImpl<$Res>
    implements _$BarcodeDataDtoCopyWith<$Res> {
  __$BarcodeDataDtoCopyWithImpl(this._self, this._then);

  final _BarcodeDataDto _self;
  final $Res Function(_BarcodeDataDto) _then;

/// Create a copy of BarcodeDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? barcodeNumber = null,Object? barcodeType = null,Object? productInfo = null,}) {
  return _then(_BarcodeDataDto(
barcodeNumber: null == barcodeNumber ? _self.barcodeNumber : barcodeNumber // ignore: cast_nullable_to_non_nullable
as String,barcodeType: null == barcodeType ? _self.barcodeType : barcodeType // ignore: cast_nullable_to_non_nullable
as String,productInfo: null == productInfo ? _self._productInfo : productInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$ProductByBarcodeResponseDto {

 bool get success; String get source; Product? get product; BarcodeDataDto? get barcode;
/// Create a copy of ProductByBarcodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductByBarcodeResponseDtoCopyWith<ProductByBarcodeResponseDto> get copyWith => _$ProductByBarcodeResponseDtoCopyWithImpl<ProductByBarcodeResponseDto>(this as ProductByBarcodeResponseDto, _$identity);

  /// Serializes this ProductByBarcodeResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductByBarcodeResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.source, source) || other.source == source)&&(identical(other.product, product) || other.product == product)&&(identical(other.barcode, barcode) || other.barcode == barcode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,source,product,barcode);

@override
String toString() {
  return 'ProductByBarcodeResponseDto(success: $success, source: $source, product: $product, barcode: $barcode)';
}


}

/// @nodoc
abstract mixin class $ProductByBarcodeResponseDtoCopyWith<$Res>  {
  factory $ProductByBarcodeResponseDtoCopyWith(ProductByBarcodeResponseDto value, $Res Function(ProductByBarcodeResponseDto) _then) = _$ProductByBarcodeResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool success, String source, Product? product, BarcodeDataDto? barcode
});


$ProductCopyWith<$Res>? get product;$BarcodeDataDtoCopyWith<$Res>? get barcode;

}
/// @nodoc
class _$ProductByBarcodeResponseDtoCopyWithImpl<$Res>
    implements $ProductByBarcodeResponseDtoCopyWith<$Res> {
  _$ProductByBarcodeResponseDtoCopyWithImpl(this._self, this._then);

  final ProductByBarcodeResponseDto _self;
  final $Res Function(ProductByBarcodeResponseDto) _then;

/// Create a copy of ProductByBarcodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? source = null,Object? product = freezed,Object? barcode = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as BarcodeDataDto?,
  ));
}
/// Create a copy of ProductByBarcodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $ProductCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of ProductByBarcodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BarcodeDataDtoCopyWith<$Res>? get barcode {
    if (_self.barcode == null) {
    return null;
  }

  return $BarcodeDataDtoCopyWith<$Res>(_self.barcode!, (value) {
    return _then(_self.copyWith(barcode: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductByBarcodeResponseDto].
extension ProductByBarcodeResponseDtoPatterns on ProductByBarcodeResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductByBarcodeResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductByBarcodeResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductByBarcodeResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductByBarcodeResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductByBarcodeResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductByBarcodeResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String source,  Product? product,  BarcodeDataDto? barcode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductByBarcodeResponseDto() when $default != null:
return $default(_that.success,_that.source,_that.product,_that.barcode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String source,  Product? product,  BarcodeDataDto? barcode)  $default,) {final _that = this;
switch (_that) {
case _ProductByBarcodeResponseDto():
return $default(_that.success,_that.source,_that.product,_that.barcode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String source,  Product? product,  BarcodeDataDto? barcode)?  $default,) {final _that = this;
switch (_that) {
case _ProductByBarcodeResponseDto() when $default != null:
return $default(_that.success,_that.source,_that.product,_that.barcode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductByBarcodeResponseDto extends ProductByBarcodeResponseDto {
  const _ProductByBarcodeResponseDto({required this.success, required this.source, this.product, this.barcode}): super._();
  factory _ProductByBarcodeResponseDto.fromJson(Map<String, dynamic> json) => _$ProductByBarcodeResponseDtoFromJson(json);

@override final  bool success;
@override final  String source;
@override final  Product? product;
@override final  BarcodeDataDto? barcode;

/// Create a copy of ProductByBarcodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductByBarcodeResponseDtoCopyWith<_ProductByBarcodeResponseDto> get copyWith => __$ProductByBarcodeResponseDtoCopyWithImpl<_ProductByBarcodeResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductByBarcodeResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductByBarcodeResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.source, source) || other.source == source)&&(identical(other.product, product) || other.product == product)&&(identical(other.barcode, barcode) || other.barcode == barcode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,source,product,barcode);

@override
String toString() {
  return 'ProductByBarcodeResponseDto(success: $success, source: $source, product: $product, barcode: $barcode)';
}


}

/// @nodoc
abstract mixin class _$ProductByBarcodeResponseDtoCopyWith<$Res> implements $ProductByBarcodeResponseDtoCopyWith<$Res> {
  factory _$ProductByBarcodeResponseDtoCopyWith(_ProductByBarcodeResponseDto value, $Res Function(_ProductByBarcodeResponseDto) _then) = __$ProductByBarcodeResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool success, String source, Product? product, BarcodeDataDto? barcode
});


@override $ProductCopyWith<$Res>? get product;@override $BarcodeDataDtoCopyWith<$Res>? get barcode;

}
/// @nodoc
class __$ProductByBarcodeResponseDtoCopyWithImpl<$Res>
    implements _$ProductByBarcodeResponseDtoCopyWith<$Res> {
  __$ProductByBarcodeResponseDtoCopyWithImpl(this._self, this._then);

  final _ProductByBarcodeResponseDto _self;
  final $Res Function(_ProductByBarcodeResponseDto) _then;

/// Create a copy of ProductByBarcodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? source = null,Object? product = freezed,Object? barcode = freezed,}) {
  return _then(_ProductByBarcodeResponseDto(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as BarcodeDataDto?,
  ));
}

/// Create a copy of ProductByBarcodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $ProductCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of ProductByBarcodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BarcodeDataDtoCopyWith<$Res>? get barcode {
    if (_self.barcode == null) {
    return null;
  }

  return $BarcodeDataDtoCopyWith<$Res>(_self.barcode!, (value) {
    return _then(_self.copyWith(barcode: value));
  });
}
}

// dart format on
