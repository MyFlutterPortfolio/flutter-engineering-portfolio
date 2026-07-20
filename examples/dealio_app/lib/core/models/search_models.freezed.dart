// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Country {

 String get code; String get name; String get gl; String get hl; String get location;
/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountryCopyWith<Country> get copyWith => _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Country&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.gl, gl) || other.gl == gl)&&(identical(other.hl, hl) || other.hl == hl)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,gl,hl,location);

@override
String toString() {
  return 'Country(code: $code, name: $name, gl: $gl, hl: $hl, location: $location)';
}


}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res>  {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) = _$CountryCopyWithImpl;
@useResult
$Res call({
 String code, String name, String gl, String hl, String location
});




}
/// @nodoc
class _$CountryCopyWithImpl<$Res>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? gl = null,Object? hl = null,Object? location = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gl: null == gl ? _self.gl : gl // ignore: cast_nullable_to_non_nullable
as String,hl: null == hl ? _self.hl : hl // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Country].
extension CountryPatterns on Country {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Country value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Country() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Country value)  $default,){
final _that = this;
switch (_that) {
case _Country():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Country value)?  $default,){
final _that = this;
switch (_that) {
case _Country() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String gl,  String hl,  String location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.code,_that.name,_that.gl,_that.hl,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String gl,  String hl,  String location)  $default,) {final _that = this;
switch (_that) {
case _Country():
return $default(_that.code,_that.name,_that.gl,_that.hl,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String gl,  String hl,  String location)?  $default,) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.code,_that.name,_that.gl,_that.hl,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Country implements Country {
  const _Country({required this.code, required this.name, required this.gl, required this.hl, required this.location});
  factory _Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

@override final  String code;
@override final  String name;
@override final  String gl;
@override final  String hl;
@override final  String location;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCopyWith<_Country> get copyWith => __$CountryCopyWithImpl<_Country>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Country&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.gl, gl) || other.gl == gl)&&(identical(other.hl, hl) || other.hl == hl)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,gl,hl,location);

@override
String toString() {
  return 'Country(code: $code, name: $name, gl: $gl, hl: $hl, location: $location)';
}


}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) = __$CountryCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String gl, String hl, String location
});




}
/// @nodoc
class __$CountryCopyWithImpl<$Res>
    implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? gl = null,Object? hl = null,Object? location = null,}) {
  return _then(_Country(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gl: null == gl ? _self.gl : gl // ignore: cast_nullable_to_non_nullable
as String,hl: null == hl ? _self.hl : hl // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Store {

 String get name; List<String> get domains; String get countryCode;
/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreCopyWith<Store> get copyWith => _$StoreCopyWithImpl<Store>(this as Store, _$identity);

  /// Serializes this Store to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Store&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.domains, domains)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(domains),countryCode);

@override
String toString() {
  return 'Store(name: $name, domains: $domains, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class $StoreCopyWith<$Res>  {
  factory $StoreCopyWith(Store value, $Res Function(Store) _then) = _$StoreCopyWithImpl;
@useResult
$Res call({
 String name, List<String> domains, String countryCode
});




}
/// @nodoc
class _$StoreCopyWithImpl<$Res>
    implements $StoreCopyWith<$Res> {
  _$StoreCopyWithImpl(this._self, this._then);

  final Store _self;
  final $Res Function(Store) _then;

/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? domains = null,Object? countryCode = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,domains: null == domains ? _self.domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Store].
extension StorePatterns on Store {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Store value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Store() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Store value)  $default,){
final _that = this;
switch (_that) {
case _Store():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Store value)?  $default,){
final _that = this;
switch (_that) {
case _Store() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<String> domains,  String countryCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Store() when $default != null:
return $default(_that.name,_that.domains,_that.countryCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<String> domains,  String countryCode)  $default,) {final _that = this;
switch (_that) {
case _Store():
return $default(_that.name,_that.domains,_that.countryCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<String> domains,  String countryCode)?  $default,) {final _that = this;
switch (_that) {
case _Store() when $default != null:
return $default(_that.name,_that.domains,_that.countryCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Store implements Store {
  const _Store({required this.name, required final  List<String> domains, required this.countryCode}): _domains = domains;
  factory _Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

@override final  String name;
 final  List<String> _domains;
@override List<String> get domains {
  if (_domains is EqualUnmodifiableListView) return _domains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_domains);
}

@override final  String countryCode;

/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreCopyWith<_Store> get copyWith => __$StoreCopyWithImpl<_Store>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Store&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._domains, _domains)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_domains),countryCode);

@override
String toString() {
  return 'Store(name: $name, domains: $domains, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class _$StoreCopyWith<$Res> implements $StoreCopyWith<$Res> {
  factory _$StoreCopyWith(_Store value, $Res Function(_Store) _then) = __$StoreCopyWithImpl;
@override @useResult
$Res call({
 String name, List<String> domains, String countryCode
});




}
/// @nodoc
class __$StoreCopyWithImpl<$Res>
    implements _$StoreCopyWith<$Res> {
  __$StoreCopyWithImpl(this._self, this._then);

  final _Store _self;
  final $Res Function(_Store) _then;

/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? domains = null,Object? countryCode = null,}) {
  return _then(_Store(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,domains: null == domains ? _self._domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StoreOffer {

 String get store; double get price; String get currency; String get link; bool get availability; int get stock; String? get productTitle; String? get productId;
/// Create a copy of StoreOffer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreOfferCopyWith<StoreOffer> get copyWith => _$StoreOfferCopyWithImpl<StoreOffer>(this as StoreOffer, _$identity);

  /// Serializes this StoreOffer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreOffer&&(identical(other.store, store) || other.store == store)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.link, link) || other.link == link)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.productTitle, productTitle) || other.productTitle == productTitle)&&(identical(other.productId, productId) || other.productId == productId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,store,price,currency,link,availability,stock,productTitle,productId);

@override
String toString() {
  return 'StoreOffer(store: $store, price: $price, currency: $currency, link: $link, availability: $availability, stock: $stock, productTitle: $productTitle, productId: $productId)';
}


}

/// @nodoc
abstract mixin class $StoreOfferCopyWith<$Res>  {
  factory $StoreOfferCopyWith(StoreOffer value, $Res Function(StoreOffer) _then) = _$StoreOfferCopyWithImpl;
@useResult
$Res call({
 String store, double price, String currency, String link, bool availability, int stock, String? productTitle, String? productId
});




}
/// @nodoc
class _$StoreOfferCopyWithImpl<$Res>
    implements $StoreOfferCopyWith<$Res> {
  _$StoreOfferCopyWithImpl(this._self, this._then);

  final StoreOffer _self;
  final $Res Function(StoreOffer) _then;

/// Create a copy of StoreOffer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? store = null,Object? price = null,Object? currency = null,Object? link = null,Object? availability = null,Object? stock = null,Object? productTitle = freezed,Object? productId = freezed,}) {
  return _then(_self.copyWith(
store: null == store ? _self.store : store // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as bool,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,productTitle: freezed == productTitle ? _self.productTitle : productTitle // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreOffer].
extension StoreOfferPatterns on StoreOffer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreOffer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreOffer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreOffer value)  $default,){
final _that = this;
switch (_that) {
case _StoreOffer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreOffer value)?  $default,){
final _that = this;
switch (_that) {
case _StoreOffer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String store,  double price,  String currency,  String link,  bool availability,  int stock,  String? productTitle,  String? productId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreOffer() when $default != null:
return $default(_that.store,_that.price,_that.currency,_that.link,_that.availability,_that.stock,_that.productTitle,_that.productId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String store,  double price,  String currency,  String link,  bool availability,  int stock,  String? productTitle,  String? productId)  $default,) {final _that = this;
switch (_that) {
case _StoreOffer():
return $default(_that.store,_that.price,_that.currency,_that.link,_that.availability,_that.stock,_that.productTitle,_that.productId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String store,  double price,  String currency,  String link,  bool availability,  int stock,  String? productTitle,  String? productId)?  $default,) {final _that = this;
switch (_that) {
case _StoreOffer() when $default != null:
return $default(_that.store,_that.price,_that.currency,_that.link,_that.availability,_that.stock,_that.productTitle,_that.productId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoreOffer implements StoreOffer {
  const _StoreOffer({required this.store, required this.price, required this.currency, required this.link, required this.availability, required this.stock, this.productTitle, this.productId});
  factory _StoreOffer.fromJson(Map<String, dynamic> json) => _$StoreOfferFromJson(json);

@override final  String store;
@override final  double price;
@override final  String currency;
@override final  String link;
@override final  bool availability;
@override final  int stock;
@override final  String? productTitle;
@override final  String? productId;

/// Create a copy of StoreOffer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreOfferCopyWith<_StoreOffer> get copyWith => __$StoreOfferCopyWithImpl<_StoreOffer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreOfferToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreOffer&&(identical(other.store, store) || other.store == store)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.link, link) || other.link == link)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.productTitle, productTitle) || other.productTitle == productTitle)&&(identical(other.productId, productId) || other.productId == productId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,store,price,currency,link,availability,stock,productTitle,productId);

@override
String toString() {
  return 'StoreOffer(store: $store, price: $price, currency: $currency, link: $link, availability: $availability, stock: $stock, productTitle: $productTitle, productId: $productId)';
}


}

/// @nodoc
abstract mixin class _$StoreOfferCopyWith<$Res> implements $StoreOfferCopyWith<$Res> {
  factory _$StoreOfferCopyWith(_StoreOffer value, $Res Function(_StoreOffer) _then) = __$StoreOfferCopyWithImpl;
@override @useResult
$Res call({
 String store, double price, String currency, String link, bool availability, int stock, String? productTitle, String? productId
});




}
/// @nodoc
class __$StoreOfferCopyWithImpl<$Res>
    implements _$StoreOfferCopyWith<$Res> {
  __$StoreOfferCopyWithImpl(this._self, this._then);

  final _StoreOffer _self;
  final $Res Function(_StoreOffer) _then;

/// Create a copy of StoreOffer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? store = null,Object? price = null,Object? currency = null,Object? link = null,Object? availability = null,Object? stock = null,Object? productTitle = freezed,Object? productId = freezed,}) {
  return _then(_StoreOffer(
store: null == store ? _self.store : store // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as bool,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,productTitle: freezed == productTitle ? _self.productTitle : productTitle // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SearchRequest {

 String get query; String get country; String get storeScope; double? get budget; String? get notes; String get language; String? get location; List<String>? get selectedStores;
/// Create a copy of SearchRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchRequestCopyWith<SearchRequest> get copyWith => _$SearchRequestCopyWithImpl<SearchRequest>(this as SearchRequest, _$identity);

  /// Serializes this SearchRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchRequest&&(identical(other.query, query) || other.query == query)&&(identical(other.country, country) || other.country == country)&&(identical(other.storeScope, storeScope) || other.storeScope == storeScope)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.language, language) || other.language == language)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.selectedStores, selectedStores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,country,storeScope,budget,notes,language,location,const DeepCollectionEquality().hash(selectedStores));

@override
String toString() {
  return 'SearchRequest(query: $query, country: $country, storeScope: $storeScope, budget: $budget, notes: $notes, language: $language, location: $location, selectedStores: $selectedStores)';
}


}

/// @nodoc
abstract mixin class $SearchRequestCopyWith<$Res>  {
  factory $SearchRequestCopyWith(SearchRequest value, $Res Function(SearchRequest) _then) = _$SearchRequestCopyWithImpl;
@useResult
$Res call({
 String query, String country, String storeScope, double? budget, String? notes, String language, String? location, List<String>? selectedStores
});




}
/// @nodoc
class _$SearchRequestCopyWithImpl<$Res>
    implements $SearchRequestCopyWith<$Res> {
  _$SearchRequestCopyWithImpl(this._self, this._then);

  final SearchRequest _self;
  final $Res Function(SearchRequest) _then;

/// Create a copy of SearchRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? country = null,Object? storeScope = null,Object? budget = freezed,Object? notes = freezed,Object? language = null,Object? location = freezed,Object? selectedStores = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,storeScope: null == storeScope ? _self.storeScope : storeScope // ignore: cast_nullable_to_non_nullable
as String,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,selectedStores: freezed == selectedStores ? _self.selectedStores : selectedStores // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchRequest].
extension SearchRequestPatterns on SearchRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchRequest value)  $default,){
final _that = this;
switch (_that) {
case _SearchRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SearchRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  String country,  String storeScope,  double? budget,  String? notes,  String language,  String? location,  List<String>? selectedStores)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchRequest() when $default != null:
return $default(_that.query,_that.country,_that.storeScope,_that.budget,_that.notes,_that.language,_that.location,_that.selectedStores);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  String country,  String storeScope,  double? budget,  String? notes,  String language,  String? location,  List<String>? selectedStores)  $default,) {final _that = this;
switch (_that) {
case _SearchRequest():
return $default(_that.query,_that.country,_that.storeScope,_that.budget,_that.notes,_that.language,_that.location,_that.selectedStores);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  String country,  String storeScope,  double? budget,  String? notes,  String language,  String? location,  List<String>? selectedStores)?  $default,) {final _that = this;
switch (_that) {
case _SearchRequest() when $default != null:
return $default(_that.query,_that.country,_that.storeScope,_that.budget,_that.notes,_that.language,_that.location,_that.selectedStores);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchRequest implements SearchRequest {
  const _SearchRequest({required this.query, required this.country, this.storeScope = 'global', this.budget, this.notes, this.language = 'en', this.location, final  List<String>? selectedStores}): _selectedStores = selectedStores;
  factory _SearchRequest.fromJson(Map<String, dynamic> json) => _$SearchRequestFromJson(json);

@override final  String query;
@override final  String country;
@override@JsonKey() final  String storeScope;
@override final  double? budget;
@override final  String? notes;
@override@JsonKey() final  String language;
@override final  String? location;
 final  List<String>? _selectedStores;
@override List<String>? get selectedStores {
  final value = _selectedStores;
  if (value == null) return null;
  if (_selectedStores is EqualUnmodifiableListView) return _selectedStores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SearchRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchRequestCopyWith<_SearchRequest> get copyWith => __$SearchRequestCopyWithImpl<_SearchRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchRequest&&(identical(other.query, query) || other.query == query)&&(identical(other.country, country) || other.country == country)&&(identical(other.storeScope, storeScope) || other.storeScope == storeScope)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.language, language) || other.language == language)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._selectedStores, _selectedStores));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,country,storeScope,budget,notes,language,location,const DeepCollectionEquality().hash(_selectedStores));

@override
String toString() {
  return 'SearchRequest(query: $query, country: $country, storeScope: $storeScope, budget: $budget, notes: $notes, language: $language, location: $location, selectedStores: $selectedStores)';
}


}

/// @nodoc
abstract mixin class _$SearchRequestCopyWith<$Res> implements $SearchRequestCopyWith<$Res> {
  factory _$SearchRequestCopyWith(_SearchRequest value, $Res Function(_SearchRequest) _then) = __$SearchRequestCopyWithImpl;
@override @useResult
$Res call({
 String query, String country, String storeScope, double? budget, String? notes, String language, String? location, List<String>? selectedStores
});




}
/// @nodoc
class __$SearchRequestCopyWithImpl<$Res>
    implements _$SearchRequestCopyWith<$Res> {
  __$SearchRequestCopyWithImpl(this._self, this._then);

  final _SearchRequest _self;
  final $Res Function(_SearchRequest) _then;

/// Create a copy of SearchRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? country = null,Object? storeScope = null,Object? budget = freezed,Object? notes = freezed,Object? language = null,Object? location = freezed,Object? selectedStores = freezed,}) {
  return _then(_SearchRequest(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,storeScope: null == storeScope ? _self.storeScope : storeScope // ignore: cast_nullable_to_non_nullable
as String,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,selectedStores: freezed == selectedStores ? _self._selectedStores : selectedStores // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$SearchResponse {

 String get query; int get count; List<Product> get results; String get country; String get storeScope; List<String> get selectedStores; List<String> get selectedStoreLinks; List<StoreOffer> get storeOffers; bool get aiAnalysisDeferred; String? get requestId; int? get stage; bool? get isPartial; int? get nextPollMs; String? get statusEndpoint; String? get stage1Source; String? get aiSummaryRequestId; String? get timestamp; SubscriptionPlan? get plan; String? get searchProvider; QuotaInfo? get quota;
/// Create a copy of SearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResponseCopyWith<SearchResponse> get copyWith => _$SearchResponseCopyWithImpl<SearchResponse>(this as SearchResponse, _$identity);

  /// Serializes this SearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResponse&&(identical(other.query, query) || other.query == query)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.country, country) || other.country == country)&&(identical(other.storeScope, storeScope) || other.storeScope == storeScope)&&const DeepCollectionEquality().equals(other.selectedStores, selectedStores)&&const DeepCollectionEquality().equals(other.selectedStoreLinks, selectedStoreLinks)&&const DeepCollectionEquality().equals(other.storeOffers, storeOffers)&&(identical(other.aiAnalysisDeferred, aiAnalysisDeferred) || other.aiAnalysisDeferred == aiAnalysisDeferred)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.isPartial, isPartial) || other.isPartial == isPartial)&&(identical(other.nextPollMs, nextPollMs) || other.nextPollMs == nextPollMs)&&(identical(other.statusEndpoint, statusEndpoint) || other.statusEndpoint == statusEndpoint)&&(identical(other.stage1Source, stage1Source) || other.stage1Source == stage1Source)&&(identical(other.aiSummaryRequestId, aiSummaryRequestId) || other.aiSummaryRequestId == aiSummaryRequestId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.searchProvider, searchProvider) || other.searchProvider == searchProvider)&&(identical(other.quota, quota) || other.quota == quota));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,query,count,const DeepCollectionEquality().hash(results),country,storeScope,const DeepCollectionEquality().hash(selectedStores),const DeepCollectionEquality().hash(selectedStoreLinks),const DeepCollectionEquality().hash(storeOffers),aiAnalysisDeferred,requestId,stage,isPartial,nextPollMs,statusEndpoint,stage1Source,aiSummaryRequestId,timestamp,plan,searchProvider,quota]);

@override
String toString() {
  return 'SearchResponse(query: $query, count: $count, results: $results, country: $country, storeScope: $storeScope, selectedStores: $selectedStores, selectedStoreLinks: $selectedStoreLinks, storeOffers: $storeOffers, aiAnalysisDeferred: $aiAnalysisDeferred, requestId: $requestId, stage: $stage, isPartial: $isPartial, nextPollMs: $nextPollMs, statusEndpoint: $statusEndpoint, stage1Source: $stage1Source, aiSummaryRequestId: $aiSummaryRequestId, timestamp: $timestamp, plan: $plan, searchProvider: $searchProvider, quota: $quota)';
}


}

/// @nodoc
abstract mixin class $SearchResponseCopyWith<$Res>  {
  factory $SearchResponseCopyWith(SearchResponse value, $Res Function(SearchResponse) _then) = _$SearchResponseCopyWithImpl;
@useResult
$Res call({
 String query, int count, List<Product> results, String country, String storeScope, List<String> selectedStores, List<String> selectedStoreLinks, List<StoreOffer> storeOffers, bool aiAnalysisDeferred, String? requestId, int? stage, bool? isPartial, int? nextPollMs, String? statusEndpoint, String? stage1Source, String? aiSummaryRequestId, String? timestamp, SubscriptionPlan? plan, String? searchProvider, QuotaInfo? quota
});


$QuotaInfoCopyWith<$Res>? get quota;

}
/// @nodoc
class _$SearchResponseCopyWithImpl<$Res>
    implements $SearchResponseCopyWith<$Res> {
  _$SearchResponseCopyWithImpl(this._self, this._then);

  final SearchResponse _self;
  final $Res Function(SearchResponse) _then;

/// Create a copy of SearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? count = null,Object? results = null,Object? country = null,Object? storeScope = null,Object? selectedStores = null,Object? selectedStoreLinks = null,Object? storeOffers = null,Object? aiAnalysisDeferred = null,Object? requestId = freezed,Object? stage = freezed,Object? isPartial = freezed,Object? nextPollMs = freezed,Object? statusEndpoint = freezed,Object? stage1Source = freezed,Object? aiSummaryRequestId = freezed,Object? timestamp = freezed,Object? plan = freezed,Object? searchProvider = freezed,Object? quota = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<Product>,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,storeScope: null == storeScope ? _self.storeScope : storeScope // ignore: cast_nullable_to_non_nullable
as String,selectedStores: null == selectedStores ? _self.selectedStores : selectedStores // ignore: cast_nullable_to_non_nullable
as List<String>,selectedStoreLinks: null == selectedStoreLinks ? _self.selectedStoreLinks : selectedStoreLinks // ignore: cast_nullable_to_non_nullable
as List<String>,storeOffers: null == storeOffers ? _self.storeOffers : storeOffers // ignore: cast_nullable_to_non_nullable
as List<StoreOffer>,aiAnalysisDeferred: null == aiAnalysisDeferred ? _self.aiAnalysisDeferred : aiAnalysisDeferred // ignore: cast_nullable_to_non_nullable
as bool,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,stage: freezed == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as int?,isPartial: freezed == isPartial ? _self.isPartial : isPartial // ignore: cast_nullable_to_non_nullable
as bool?,nextPollMs: freezed == nextPollMs ? _self.nextPollMs : nextPollMs // ignore: cast_nullable_to_non_nullable
as int?,statusEndpoint: freezed == statusEndpoint ? _self.statusEndpoint : statusEndpoint // ignore: cast_nullable_to_non_nullable
as String?,stage1Source: freezed == stage1Source ? _self.stage1Source : stage1Source // ignore: cast_nullable_to_non_nullable
as String?,aiSummaryRequestId: freezed == aiSummaryRequestId ? _self.aiSummaryRequestId : aiSummaryRequestId // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan?,searchProvider: freezed == searchProvider ? _self.searchProvider : searchProvider // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as QuotaInfo?,
  ));
}
/// Create a copy of SearchResponse
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


/// Adds pattern-matching-related methods to [SearchResponse].
extension SearchResponsePatterns on SearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _SearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  int count,  List<Product> results,  String country,  String storeScope,  List<String> selectedStores,  List<String> selectedStoreLinks,  List<StoreOffer> storeOffers,  bool aiAnalysisDeferred,  String? requestId,  int? stage,  bool? isPartial,  int? nextPollMs,  String? statusEndpoint,  String? stage1Source,  String? aiSummaryRequestId,  String? timestamp,  SubscriptionPlan? plan,  String? searchProvider,  QuotaInfo? quota)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResponse() when $default != null:
return $default(_that.query,_that.count,_that.results,_that.country,_that.storeScope,_that.selectedStores,_that.selectedStoreLinks,_that.storeOffers,_that.aiAnalysisDeferred,_that.requestId,_that.stage,_that.isPartial,_that.nextPollMs,_that.statusEndpoint,_that.stage1Source,_that.aiSummaryRequestId,_that.timestamp,_that.plan,_that.searchProvider,_that.quota);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  int count,  List<Product> results,  String country,  String storeScope,  List<String> selectedStores,  List<String> selectedStoreLinks,  List<StoreOffer> storeOffers,  bool aiAnalysisDeferred,  String? requestId,  int? stage,  bool? isPartial,  int? nextPollMs,  String? statusEndpoint,  String? stage1Source,  String? aiSummaryRequestId,  String? timestamp,  SubscriptionPlan? plan,  String? searchProvider,  QuotaInfo? quota)  $default,) {final _that = this;
switch (_that) {
case _SearchResponse():
return $default(_that.query,_that.count,_that.results,_that.country,_that.storeScope,_that.selectedStores,_that.selectedStoreLinks,_that.storeOffers,_that.aiAnalysisDeferred,_that.requestId,_that.stage,_that.isPartial,_that.nextPollMs,_that.statusEndpoint,_that.stage1Source,_that.aiSummaryRequestId,_that.timestamp,_that.plan,_that.searchProvider,_that.quota);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  int count,  List<Product> results,  String country,  String storeScope,  List<String> selectedStores,  List<String> selectedStoreLinks,  List<StoreOffer> storeOffers,  bool aiAnalysisDeferred,  String? requestId,  int? stage,  bool? isPartial,  int? nextPollMs,  String? statusEndpoint,  String? stage1Source,  String? aiSummaryRequestId,  String? timestamp,  SubscriptionPlan? plan,  String? searchProvider,  QuotaInfo? quota)?  $default,) {final _that = this;
switch (_that) {
case _SearchResponse() when $default != null:
return $default(_that.query,_that.count,_that.results,_that.country,_that.storeScope,_that.selectedStores,_that.selectedStoreLinks,_that.storeOffers,_that.aiAnalysisDeferred,_that.requestId,_that.stage,_that.isPartial,_that.nextPollMs,_that.statusEndpoint,_that.stage1Source,_that.aiSummaryRequestId,_that.timestamp,_that.plan,_that.searchProvider,_that.quota);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchResponse implements SearchResponse {
  const _SearchResponse({required this.query, this.count = 0, final  List<Product> results = const [], required this.country, this.storeScope = 'global', final  List<String> selectedStores = const [], final  List<String> selectedStoreLinks = const [], final  List<StoreOffer> storeOffers = const [], this.aiAnalysisDeferred = false, this.requestId, this.stage, this.isPartial, this.nextPollMs, this.statusEndpoint, this.stage1Source, this.aiSummaryRequestId, this.timestamp, this.plan, this.searchProvider, this.quota}): _results = results,_selectedStores = selectedStores,_selectedStoreLinks = selectedStoreLinks,_storeOffers = storeOffers;
  factory _SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);

@override final  String query;
@override@JsonKey() final  int count;
 final  List<Product> _results;
@override@JsonKey() List<Product> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  String country;
@override@JsonKey() final  String storeScope;
 final  List<String> _selectedStores;
@override@JsonKey() List<String> get selectedStores {
  if (_selectedStores is EqualUnmodifiableListView) return _selectedStores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedStores);
}

 final  List<String> _selectedStoreLinks;
@override@JsonKey() List<String> get selectedStoreLinks {
  if (_selectedStoreLinks is EqualUnmodifiableListView) return _selectedStoreLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedStoreLinks);
}

 final  List<StoreOffer> _storeOffers;
@override@JsonKey() List<StoreOffer> get storeOffers {
  if (_storeOffers is EqualUnmodifiableListView) return _storeOffers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_storeOffers);
}

@override@JsonKey() final  bool aiAnalysisDeferred;
@override final  String? requestId;
@override final  int? stage;
@override final  bool? isPartial;
@override final  int? nextPollMs;
@override final  String? statusEndpoint;
@override final  String? stage1Source;
@override final  String? aiSummaryRequestId;
@override final  String? timestamp;
@override final  SubscriptionPlan? plan;
@override final  String? searchProvider;
@override final  QuotaInfo? quota;

/// Create a copy of SearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResponseCopyWith<_SearchResponse> get copyWith => __$SearchResponseCopyWithImpl<_SearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResponse&&(identical(other.query, query) || other.query == query)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.country, country) || other.country == country)&&(identical(other.storeScope, storeScope) || other.storeScope == storeScope)&&const DeepCollectionEquality().equals(other._selectedStores, _selectedStores)&&const DeepCollectionEquality().equals(other._selectedStoreLinks, _selectedStoreLinks)&&const DeepCollectionEquality().equals(other._storeOffers, _storeOffers)&&(identical(other.aiAnalysisDeferred, aiAnalysisDeferred) || other.aiAnalysisDeferred == aiAnalysisDeferred)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.isPartial, isPartial) || other.isPartial == isPartial)&&(identical(other.nextPollMs, nextPollMs) || other.nextPollMs == nextPollMs)&&(identical(other.statusEndpoint, statusEndpoint) || other.statusEndpoint == statusEndpoint)&&(identical(other.stage1Source, stage1Source) || other.stage1Source == stage1Source)&&(identical(other.aiSummaryRequestId, aiSummaryRequestId) || other.aiSummaryRequestId == aiSummaryRequestId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.searchProvider, searchProvider) || other.searchProvider == searchProvider)&&(identical(other.quota, quota) || other.quota == quota));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,query,count,const DeepCollectionEquality().hash(_results),country,storeScope,const DeepCollectionEquality().hash(_selectedStores),const DeepCollectionEquality().hash(_selectedStoreLinks),const DeepCollectionEquality().hash(_storeOffers),aiAnalysisDeferred,requestId,stage,isPartial,nextPollMs,statusEndpoint,stage1Source,aiSummaryRequestId,timestamp,plan,searchProvider,quota]);

@override
String toString() {
  return 'SearchResponse(query: $query, count: $count, results: $results, country: $country, storeScope: $storeScope, selectedStores: $selectedStores, selectedStoreLinks: $selectedStoreLinks, storeOffers: $storeOffers, aiAnalysisDeferred: $aiAnalysisDeferred, requestId: $requestId, stage: $stage, isPartial: $isPartial, nextPollMs: $nextPollMs, statusEndpoint: $statusEndpoint, stage1Source: $stage1Source, aiSummaryRequestId: $aiSummaryRequestId, timestamp: $timestamp, plan: $plan, searchProvider: $searchProvider, quota: $quota)';
}


}

/// @nodoc
abstract mixin class _$SearchResponseCopyWith<$Res> implements $SearchResponseCopyWith<$Res> {
  factory _$SearchResponseCopyWith(_SearchResponse value, $Res Function(_SearchResponse) _then) = __$SearchResponseCopyWithImpl;
@override @useResult
$Res call({
 String query, int count, List<Product> results, String country, String storeScope, List<String> selectedStores, List<String> selectedStoreLinks, List<StoreOffer> storeOffers, bool aiAnalysisDeferred, String? requestId, int? stage, bool? isPartial, int? nextPollMs, String? statusEndpoint, String? stage1Source, String? aiSummaryRequestId, String? timestamp, SubscriptionPlan? plan, String? searchProvider, QuotaInfo? quota
});


@override $QuotaInfoCopyWith<$Res>? get quota;

}
/// @nodoc
class __$SearchResponseCopyWithImpl<$Res>
    implements _$SearchResponseCopyWith<$Res> {
  __$SearchResponseCopyWithImpl(this._self, this._then);

  final _SearchResponse _self;
  final $Res Function(_SearchResponse) _then;

/// Create a copy of SearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? count = null,Object? results = null,Object? country = null,Object? storeScope = null,Object? selectedStores = null,Object? selectedStoreLinks = null,Object? storeOffers = null,Object? aiAnalysisDeferred = null,Object? requestId = freezed,Object? stage = freezed,Object? isPartial = freezed,Object? nextPollMs = freezed,Object? statusEndpoint = freezed,Object? stage1Source = freezed,Object? aiSummaryRequestId = freezed,Object? timestamp = freezed,Object? plan = freezed,Object? searchProvider = freezed,Object? quota = freezed,}) {
  return _then(_SearchResponse(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Product>,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,storeScope: null == storeScope ? _self.storeScope : storeScope // ignore: cast_nullable_to_non_nullable
as String,selectedStores: null == selectedStores ? _self._selectedStores : selectedStores // ignore: cast_nullable_to_non_nullable
as List<String>,selectedStoreLinks: null == selectedStoreLinks ? _self._selectedStoreLinks : selectedStoreLinks // ignore: cast_nullable_to_non_nullable
as List<String>,storeOffers: null == storeOffers ? _self._storeOffers : storeOffers // ignore: cast_nullable_to_non_nullable
as List<StoreOffer>,aiAnalysisDeferred: null == aiAnalysisDeferred ? _self.aiAnalysisDeferred : aiAnalysisDeferred // ignore: cast_nullable_to_non_nullable
as bool,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,stage: freezed == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as int?,isPartial: freezed == isPartial ? _self.isPartial : isPartial // ignore: cast_nullable_to_non_nullable
as bool?,nextPollMs: freezed == nextPollMs ? _self.nextPollMs : nextPollMs // ignore: cast_nullable_to_non_nullable
as int?,statusEndpoint: freezed == statusEndpoint ? _self.statusEndpoint : statusEndpoint // ignore: cast_nullable_to_non_nullable
as String?,stage1Source: freezed == stage1Source ? _self.stage1Source : stage1Source // ignore: cast_nullable_to_non_nullable
as String?,aiSummaryRequestId: freezed == aiSummaryRequestId ? _self.aiSummaryRequestId : aiSummaryRequestId // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan?,searchProvider: freezed == searchProvider ? _self.searchProvider : searchProvider // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as QuotaInfo?,
  ));
}

/// Create a copy of SearchResponse
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


/// @nodoc
mixin _$SearchSessionStatusResponse {

 String get status;// pending|ready|failed
 StageData? get stage1; StageData? get stage2; StageData? get stage3;
/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSessionStatusResponseCopyWith<SearchSessionStatusResponse> get copyWith => _$SearchSessionStatusResponseCopyWithImpl<SearchSessionStatusResponse>(this as SearchSessionStatusResponse, _$identity);

  /// Serializes this SearchSessionStatusResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSessionStatusResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.stage1, stage1) || other.stage1 == stage1)&&(identical(other.stage2, stage2) || other.stage2 == stage2)&&(identical(other.stage3, stage3) || other.stage3 == stage3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,stage1,stage2,stage3);

@override
String toString() {
  return 'SearchSessionStatusResponse(status: $status, stage1: $stage1, stage2: $stage2, stage3: $stage3)';
}


}

/// @nodoc
abstract mixin class $SearchSessionStatusResponseCopyWith<$Res>  {
  factory $SearchSessionStatusResponseCopyWith(SearchSessionStatusResponse value, $Res Function(SearchSessionStatusResponse) _then) = _$SearchSessionStatusResponseCopyWithImpl;
@useResult
$Res call({
 String status, StageData? stage1, StageData? stage2, StageData? stage3
});


$StageDataCopyWith<$Res>? get stage1;$StageDataCopyWith<$Res>? get stage2;$StageDataCopyWith<$Res>? get stage3;

}
/// @nodoc
class _$SearchSessionStatusResponseCopyWithImpl<$Res>
    implements $SearchSessionStatusResponseCopyWith<$Res> {
  _$SearchSessionStatusResponseCopyWithImpl(this._self, this._then);

  final SearchSessionStatusResponse _self;
  final $Res Function(SearchSessionStatusResponse) _then;

/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? stage1 = freezed,Object? stage2 = freezed,Object? stage3 = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,stage1: freezed == stage1 ? _self.stage1 : stage1 // ignore: cast_nullable_to_non_nullable
as StageData?,stage2: freezed == stage2 ? _self.stage2 : stage2 // ignore: cast_nullable_to_non_nullable
as StageData?,stage3: freezed == stage3 ? _self.stage3 : stage3 // ignore: cast_nullable_to_non_nullable
as StageData?,
  ));
}
/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StageDataCopyWith<$Res>? get stage1 {
    if (_self.stage1 == null) {
    return null;
  }

  return $StageDataCopyWith<$Res>(_self.stage1!, (value) {
    return _then(_self.copyWith(stage1: value));
  });
}/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StageDataCopyWith<$Res>? get stage2 {
    if (_self.stage2 == null) {
    return null;
  }

  return $StageDataCopyWith<$Res>(_self.stage2!, (value) {
    return _then(_self.copyWith(stage2: value));
  });
}/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StageDataCopyWith<$Res>? get stage3 {
    if (_self.stage3 == null) {
    return null;
  }

  return $StageDataCopyWith<$Res>(_self.stage3!, (value) {
    return _then(_self.copyWith(stage3: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchSessionStatusResponse].
extension SearchSessionStatusResponsePatterns on SearchSessionStatusResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchSessionStatusResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchSessionStatusResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchSessionStatusResponse value)  $default,){
final _that = this;
switch (_that) {
case _SearchSessionStatusResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchSessionStatusResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SearchSessionStatusResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  StageData? stage1,  StageData? stage2,  StageData? stage3)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchSessionStatusResponse() when $default != null:
return $default(_that.status,_that.stage1,_that.stage2,_that.stage3);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  StageData? stage1,  StageData? stage2,  StageData? stage3)  $default,) {final _that = this;
switch (_that) {
case _SearchSessionStatusResponse():
return $default(_that.status,_that.stage1,_that.stage2,_that.stage3);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  StageData? stage1,  StageData? stage2,  StageData? stage3)?  $default,) {final _that = this;
switch (_that) {
case _SearchSessionStatusResponse() when $default != null:
return $default(_that.status,_that.stage1,_that.stage2,_that.stage3);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchSessionStatusResponse implements SearchSessionStatusResponse {
  const _SearchSessionStatusResponse({required this.status, this.stage1, this.stage2, this.stage3});
  factory _SearchSessionStatusResponse.fromJson(Map<String, dynamic> json) => _$SearchSessionStatusResponseFromJson(json);

@override final  String status;
// pending|ready|failed
@override final  StageData? stage1;
@override final  StageData? stage2;
@override final  StageData? stage3;

/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchSessionStatusResponseCopyWith<_SearchSessionStatusResponse> get copyWith => __$SearchSessionStatusResponseCopyWithImpl<_SearchSessionStatusResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchSessionStatusResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchSessionStatusResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.stage1, stage1) || other.stage1 == stage1)&&(identical(other.stage2, stage2) || other.stage2 == stage2)&&(identical(other.stage3, stage3) || other.stage3 == stage3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,stage1,stage2,stage3);

@override
String toString() {
  return 'SearchSessionStatusResponse(status: $status, stage1: $stage1, stage2: $stage2, stage3: $stage3)';
}


}

/// @nodoc
abstract mixin class _$SearchSessionStatusResponseCopyWith<$Res> implements $SearchSessionStatusResponseCopyWith<$Res> {
  factory _$SearchSessionStatusResponseCopyWith(_SearchSessionStatusResponse value, $Res Function(_SearchSessionStatusResponse) _then) = __$SearchSessionStatusResponseCopyWithImpl;
@override @useResult
$Res call({
 String status, StageData? stage1, StageData? stage2, StageData? stage3
});


@override $StageDataCopyWith<$Res>? get stage1;@override $StageDataCopyWith<$Res>? get stage2;@override $StageDataCopyWith<$Res>? get stage3;

}
/// @nodoc
class __$SearchSessionStatusResponseCopyWithImpl<$Res>
    implements _$SearchSessionStatusResponseCopyWith<$Res> {
  __$SearchSessionStatusResponseCopyWithImpl(this._self, this._then);

  final _SearchSessionStatusResponse _self;
  final $Res Function(_SearchSessionStatusResponse) _then;

/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? stage1 = freezed,Object? stage2 = freezed,Object? stage3 = freezed,}) {
  return _then(_SearchSessionStatusResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,stage1: freezed == stage1 ? _self.stage1 : stage1 // ignore: cast_nullable_to_non_nullable
as StageData?,stage2: freezed == stage2 ? _self.stage2 : stage2 // ignore: cast_nullable_to_non_nullable
as StageData?,stage3: freezed == stage3 ? _self.stage3 : stage3 // ignore: cast_nullable_to_non_nullable
as StageData?,
  ));
}

/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StageDataCopyWith<$Res>? get stage1 {
    if (_self.stage1 == null) {
    return null;
  }

  return $StageDataCopyWith<$Res>(_self.stage1!, (value) {
    return _then(_self.copyWith(stage1: value));
  });
}/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StageDataCopyWith<$Res>? get stage2 {
    if (_self.stage2 == null) {
    return null;
  }

  return $StageDataCopyWith<$Res>(_self.stage2!, (value) {
    return _then(_self.copyWith(stage2: value));
  });
}/// Create a copy of SearchSessionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StageDataCopyWith<$Res>? get stage3 {
    if (_self.stage3 == null) {
    return null;
  }

  return $StageDataCopyWith<$Res>(_self.stage3!, (value) {
    return _then(_self.copyWith(stage3: value));
  });
}
}


/// @nodoc
mixin _$StageData {

 String get status; Map<String, dynamic>? get data; String? get error;
/// Create a copy of StageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StageDataCopyWith<StageData> get copyWith => _$StageDataCopyWithImpl<StageData>(this as StageData, _$identity);

  /// Serializes this StageData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StageData&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(data),error);

@override
String toString() {
  return 'StageData(status: $status, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class $StageDataCopyWith<$Res>  {
  factory $StageDataCopyWith(StageData value, $Res Function(StageData) _then) = _$StageDataCopyWithImpl;
@useResult
$Res call({
 String status, Map<String, dynamic>? data, String? error
});




}
/// @nodoc
class _$StageDataCopyWithImpl<$Res>
    implements $StageDataCopyWith<$Res> {
  _$StageDataCopyWithImpl(this._self, this._then);

  final StageData _self;
  final $Res Function(StageData) _then;

/// Create a copy of StageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StageData].
extension StageDataPatterns on StageData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StageData value)  $default,){
final _that = this;
switch (_that) {
case _StageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StageData value)?  $default,){
final _that = this;
switch (_that) {
case _StageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  Map<String, dynamic>? data,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StageData() when $default != null:
return $default(_that.status,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  Map<String, dynamic>? data,  String? error)  $default,) {final _that = this;
switch (_that) {
case _StageData():
return $default(_that.status,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  Map<String, dynamic>? data,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _StageData() when $default != null:
return $default(_that.status,_that.data,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StageData implements StageData {
  const _StageData({required this.status, final  Map<String, dynamic>? data, this.error}): _data = data;
  factory _StageData.fromJson(Map<String, dynamic> json) => _$StageDataFromJson(json);

@override final  String status;
 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? error;

/// Create a copy of StageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StageDataCopyWith<_StageData> get copyWith => __$StageDataCopyWithImpl<_StageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StageDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StageData&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_data),error);

@override
String toString() {
  return 'StageData(status: $status, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class _$StageDataCopyWith<$Res> implements $StageDataCopyWith<$Res> {
  factory _$StageDataCopyWith(_StageData value, $Res Function(_StageData) _then) = __$StageDataCopyWithImpl;
@override @useResult
$Res call({
 String status, Map<String, dynamic>? data, String? error
});




}
/// @nodoc
class __$StageDataCopyWithImpl<$Res>
    implements _$StageDataCopyWith<$Res> {
  __$StageDataCopyWithImpl(this._self, this._then);

  final _StageData _self;
  final $Res Function(_StageData) _then;

/// Create a copy of StageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_StageData(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AIStatusResponse {

 String get status;// pending, ready, failed
 String get requestId; String? get createdAt; String? get updatedAt; String? get error; List<AIResultUpdate> get results;
/// Create a copy of AIStatusResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AIStatusResponseCopyWith<AIStatusResponse> get copyWith => _$AIStatusResponseCopyWithImpl<AIStatusResponse>(this as AIStatusResponse, _$identity);

  /// Serializes this AIStatusResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AIStatusResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,requestId,createdAt,updatedAt,error,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'AIStatusResponse(status: $status, requestId: $requestId, createdAt: $createdAt, updatedAt: $updatedAt, error: $error, results: $results)';
}


}

/// @nodoc
abstract mixin class $AIStatusResponseCopyWith<$Res>  {
  factory $AIStatusResponseCopyWith(AIStatusResponse value, $Res Function(AIStatusResponse) _then) = _$AIStatusResponseCopyWithImpl;
@useResult
$Res call({
 String status, String requestId, String? createdAt, String? updatedAt, String? error, List<AIResultUpdate> results
});




}
/// @nodoc
class _$AIStatusResponseCopyWithImpl<$Res>
    implements $AIStatusResponseCopyWith<$Res> {
  _$AIStatusResponseCopyWithImpl(this._self, this._then);

  final AIStatusResponse _self;
  final $Res Function(AIStatusResponse) _then;

/// Create a copy of AIStatusResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? requestId = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? error = freezed,Object? results = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<AIResultUpdate>,
  ));
}

}


/// Adds pattern-matching-related methods to [AIStatusResponse].
extension AIStatusResponsePatterns on AIStatusResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AIStatusResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AIStatusResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AIStatusResponse value)  $default,){
final _that = this;
switch (_that) {
case _AIStatusResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AIStatusResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AIStatusResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String requestId,  String? createdAt,  String? updatedAt,  String? error,  List<AIResultUpdate> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AIStatusResponse() when $default != null:
return $default(_that.status,_that.requestId,_that.createdAt,_that.updatedAt,_that.error,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String requestId,  String? createdAt,  String? updatedAt,  String? error,  List<AIResultUpdate> results)  $default,) {final _that = this;
switch (_that) {
case _AIStatusResponse():
return $default(_that.status,_that.requestId,_that.createdAt,_that.updatedAt,_that.error,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String requestId,  String? createdAt,  String? updatedAt,  String? error,  List<AIResultUpdate> results)?  $default,) {final _that = this;
switch (_that) {
case _AIStatusResponse() when $default != null:
return $default(_that.status,_that.requestId,_that.createdAt,_that.updatedAt,_that.error,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AIStatusResponse implements AIStatusResponse {
  const _AIStatusResponse({required this.status, required this.requestId, this.createdAt, this.updatedAt, this.error, final  List<AIResultUpdate> results = const []}): _results = results;
  factory _AIStatusResponse.fromJson(Map<String, dynamic> json) => _$AIStatusResponseFromJson(json);

@override final  String status;
// pending, ready, failed
@override final  String requestId;
@override final  String? createdAt;
@override final  String? updatedAt;
@override final  String? error;
 final  List<AIResultUpdate> _results;
@override@JsonKey() List<AIResultUpdate> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of AIStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AIStatusResponseCopyWith<_AIStatusResponse> get copyWith => __$AIStatusResponseCopyWithImpl<_AIStatusResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AIStatusResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AIStatusResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,requestId,createdAt,updatedAt,error,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'AIStatusResponse(status: $status, requestId: $requestId, createdAt: $createdAt, updatedAt: $updatedAt, error: $error, results: $results)';
}


}

/// @nodoc
abstract mixin class _$AIStatusResponseCopyWith<$Res> implements $AIStatusResponseCopyWith<$Res> {
  factory _$AIStatusResponseCopyWith(_AIStatusResponse value, $Res Function(_AIStatusResponse) _then) = __$AIStatusResponseCopyWithImpl;
@override @useResult
$Res call({
 String status, String requestId, String? createdAt, String? updatedAt, String? error, List<AIResultUpdate> results
});




}
/// @nodoc
class __$AIStatusResponseCopyWithImpl<$Res>
    implements _$AIStatusResponseCopyWith<$Res> {
  __$AIStatusResponseCopyWithImpl(this._self, this._then);

  final _AIStatusResponse _self;
  final $Res Function(_AIStatusResponse) _then;

/// Create a copy of AIStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? requestId = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? error = freezed,Object? results = null,}) {
  return _then(_AIStatusResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<AIResultUpdate>,
  ));
}


}


/// @nodoc
mixin _$AIResultUpdate {

 String get productId; String? get productTitle; AIAnalysis get aiAnalysis;
/// Create a copy of AIResultUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AIResultUpdateCopyWith<AIResultUpdate> get copyWith => _$AIResultUpdateCopyWithImpl<AIResultUpdate>(this as AIResultUpdate, _$identity);

  /// Serializes this AIResultUpdate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AIResultUpdate&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productTitle, productTitle) || other.productTitle == productTitle)&&(identical(other.aiAnalysis, aiAnalysis) || other.aiAnalysis == aiAnalysis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,productTitle,aiAnalysis);

@override
String toString() {
  return 'AIResultUpdate(productId: $productId, productTitle: $productTitle, aiAnalysis: $aiAnalysis)';
}


}

/// @nodoc
abstract mixin class $AIResultUpdateCopyWith<$Res>  {
  factory $AIResultUpdateCopyWith(AIResultUpdate value, $Res Function(AIResultUpdate) _then) = _$AIResultUpdateCopyWithImpl;
@useResult
$Res call({
 String productId, String? productTitle, AIAnalysis aiAnalysis
});


$AIAnalysisCopyWith<$Res> get aiAnalysis;

}
/// @nodoc
class _$AIResultUpdateCopyWithImpl<$Res>
    implements $AIResultUpdateCopyWith<$Res> {
  _$AIResultUpdateCopyWithImpl(this._self, this._then);

  final AIResultUpdate _self;
  final $Res Function(AIResultUpdate) _then;

/// Create a copy of AIResultUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? productTitle = freezed,Object? aiAnalysis = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productTitle: freezed == productTitle ? _self.productTitle : productTitle // ignore: cast_nullable_to_non_nullable
as String?,aiAnalysis: null == aiAnalysis ? _self.aiAnalysis : aiAnalysis // ignore: cast_nullable_to_non_nullable
as AIAnalysis,
  ));
}
/// Create a copy of AIResultUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AIAnalysisCopyWith<$Res> get aiAnalysis {
  
  return $AIAnalysisCopyWith<$Res>(_self.aiAnalysis, (value) {
    return _then(_self.copyWith(aiAnalysis: value));
  });
}
}


/// Adds pattern-matching-related methods to [AIResultUpdate].
extension AIResultUpdatePatterns on AIResultUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AIResultUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AIResultUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AIResultUpdate value)  $default,){
final _that = this;
switch (_that) {
case _AIResultUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AIResultUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _AIResultUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  String? productTitle,  AIAnalysis aiAnalysis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AIResultUpdate() when $default != null:
return $default(_that.productId,_that.productTitle,_that.aiAnalysis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  String? productTitle,  AIAnalysis aiAnalysis)  $default,) {final _that = this;
switch (_that) {
case _AIResultUpdate():
return $default(_that.productId,_that.productTitle,_that.aiAnalysis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  String? productTitle,  AIAnalysis aiAnalysis)?  $default,) {final _that = this;
switch (_that) {
case _AIResultUpdate() when $default != null:
return $default(_that.productId,_that.productTitle,_that.aiAnalysis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AIResultUpdate implements AIResultUpdate {
  const _AIResultUpdate({required this.productId, this.productTitle, required this.aiAnalysis});
  factory _AIResultUpdate.fromJson(Map<String, dynamic> json) => _$AIResultUpdateFromJson(json);

@override final  String productId;
@override final  String? productTitle;
@override final  AIAnalysis aiAnalysis;

/// Create a copy of AIResultUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AIResultUpdateCopyWith<_AIResultUpdate> get copyWith => __$AIResultUpdateCopyWithImpl<_AIResultUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AIResultUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AIResultUpdate&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productTitle, productTitle) || other.productTitle == productTitle)&&(identical(other.aiAnalysis, aiAnalysis) || other.aiAnalysis == aiAnalysis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,productTitle,aiAnalysis);

@override
String toString() {
  return 'AIResultUpdate(productId: $productId, productTitle: $productTitle, aiAnalysis: $aiAnalysis)';
}


}

/// @nodoc
abstract mixin class _$AIResultUpdateCopyWith<$Res> implements $AIResultUpdateCopyWith<$Res> {
  factory _$AIResultUpdateCopyWith(_AIResultUpdate value, $Res Function(_AIResultUpdate) _then) = __$AIResultUpdateCopyWithImpl;
@override @useResult
$Res call({
 String productId, String? productTitle, AIAnalysis aiAnalysis
});


@override $AIAnalysisCopyWith<$Res> get aiAnalysis;

}
/// @nodoc
class __$AIResultUpdateCopyWithImpl<$Res>
    implements _$AIResultUpdateCopyWith<$Res> {
  __$AIResultUpdateCopyWithImpl(this._self, this._then);

  final _AIResultUpdate _self;
  final $Res Function(_AIResultUpdate) _then;

/// Create a copy of AIResultUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? productTitle = freezed,Object? aiAnalysis = null,}) {
  return _then(_AIResultUpdate(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productTitle: freezed == productTitle ? _self.productTitle : productTitle // ignore: cast_nullable_to_non_nullable
as String?,aiAnalysis: null == aiAnalysis ? _self.aiAnalysis : aiAnalysis // ignore: cast_nullable_to_non_nullable
as AIAnalysis,
  ));
}

/// Create a copy of AIResultUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AIAnalysisCopyWith<$Res> get aiAnalysis {
  
  return $AIAnalysisCopyWith<$Res>(_self.aiAnalysis, (value) {
    return _then(_self.copyWith(aiAnalysis: value));
  });
}
}


/// @nodoc
mixin _$BarcodeRequest {

 String get rawValue; String get format; String? get type; String? get displayValue;
/// Create a copy of BarcodeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarcodeRequestCopyWith<BarcodeRequest> get copyWith => _$BarcodeRequestCopyWithImpl<BarcodeRequest>(this as BarcodeRequest, _$identity);

  /// Serializes this BarcodeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarcodeRequest&&(identical(other.rawValue, rawValue) || other.rawValue == rawValue)&&(identical(other.format, format) || other.format == format)&&(identical(other.type, type) || other.type == type)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rawValue,format,type,displayValue);

@override
String toString() {
  return 'BarcodeRequest(rawValue: $rawValue, format: $format, type: $type, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class $BarcodeRequestCopyWith<$Res>  {
  factory $BarcodeRequestCopyWith(BarcodeRequest value, $Res Function(BarcodeRequest) _then) = _$BarcodeRequestCopyWithImpl;
@useResult
$Res call({
 String rawValue, String format, String? type, String? displayValue
});




}
/// @nodoc
class _$BarcodeRequestCopyWithImpl<$Res>
    implements $BarcodeRequestCopyWith<$Res> {
  _$BarcodeRequestCopyWithImpl(this._self, this._then);

  final BarcodeRequest _self;
  final $Res Function(BarcodeRequest) _then;

/// Create a copy of BarcodeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rawValue = null,Object? format = null,Object? type = freezed,Object? displayValue = freezed,}) {
  return _then(_self.copyWith(
rawValue: null == rawValue ? _self.rawValue : rawValue // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,displayValue: freezed == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BarcodeRequest].
extension BarcodeRequestPatterns on BarcodeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BarcodeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BarcodeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BarcodeRequest value)  $default,){
final _that = this;
switch (_that) {
case _BarcodeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BarcodeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _BarcodeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rawValue,  String format,  String? type,  String? displayValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BarcodeRequest() when $default != null:
return $default(_that.rawValue,_that.format,_that.type,_that.displayValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rawValue,  String format,  String? type,  String? displayValue)  $default,) {final _that = this;
switch (_that) {
case _BarcodeRequest():
return $default(_that.rawValue,_that.format,_that.type,_that.displayValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rawValue,  String format,  String? type,  String? displayValue)?  $default,) {final _that = this;
switch (_that) {
case _BarcodeRequest() when $default != null:
return $default(_that.rawValue,_that.format,_that.type,_that.displayValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BarcodeRequest implements BarcodeRequest {
  const _BarcodeRequest({required this.rawValue, required this.format, this.type, this.displayValue});
  factory _BarcodeRequest.fromJson(Map<String, dynamic> json) => _$BarcodeRequestFromJson(json);

@override final  String rawValue;
@override final  String format;
@override final  String? type;
@override final  String? displayValue;

/// Create a copy of BarcodeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BarcodeRequestCopyWith<_BarcodeRequest> get copyWith => __$BarcodeRequestCopyWithImpl<_BarcodeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BarcodeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BarcodeRequest&&(identical(other.rawValue, rawValue) || other.rawValue == rawValue)&&(identical(other.format, format) || other.format == format)&&(identical(other.type, type) || other.type == type)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rawValue,format,type,displayValue);

@override
String toString() {
  return 'BarcodeRequest(rawValue: $rawValue, format: $format, type: $type, displayValue: $displayValue)';
}


}

/// @nodoc
abstract mixin class _$BarcodeRequestCopyWith<$Res> implements $BarcodeRequestCopyWith<$Res> {
  factory _$BarcodeRequestCopyWith(_BarcodeRequest value, $Res Function(_BarcodeRequest) _then) = __$BarcodeRequestCopyWithImpl;
@override @useResult
$Res call({
 String rawValue, String format, String? type, String? displayValue
});




}
/// @nodoc
class __$BarcodeRequestCopyWithImpl<$Res>
    implements _$BarcodeRequestCopyWith<$Res> {
  __$BarcodeRequestCopyWithImpl(this._self, this._then);

  final _BarcodeRequest _self;
  final $Res Function(_BarcodeRequest) _then;

/// Create a copy of BarcodeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rawValue = null,Object? format = null,Object? type = freezed,Object? displayValue = freezed,}) {
  return _then(_BarcodeRequest(
rawValue: null == rawValue ? _self.rawValue : rawValue // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,displayValue: freezed == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ImageRecognitionRequest {

 String? get imageBase64; String? get imageUrl;// ignore: non_constant_identifier_names
 String? get image_data;
/// Create a copy of ImageRecognitionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageRecognitionRequestCopyWith<ImageRecognitionRequest> get copyWith => _$ImageRecognitionRequestCopyWithImpl<ImageRecognitionRequest>(this as ImageRecognitionRequest, _$identity);

  /// Serializes this ImageRecognitionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageRecognitionRequest&&(identical(other.imageBase64, imageBase64) || other.imageBase64 == imageBase64)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.image_data, image_data) || other.image_data == image_data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageBase64,imageUrl,image_data);

@override
String toString() {
  return 'ImageRecognitionRequest(imageBase64: $imageBase64, imageUrl: $imageUrl, image_data: $image_data)';
}


}

/// @nodoc
abstract mixin class $ImageRecognitionRequestCopyWith<$Res>  {
  factory $ImageRecognitionRequestCopyWith(ImageRecognitionRequest value, $Res Function(ImageRecognitionRequest) _then) = _$ImageRecognitionRequestCopyWithImpl;
@useResult
$Res call({
 String? imageBase64, String? imageUrl, String? image_data
});




}
/// @nodoc
class _$ImageRecognitionRequestCopyWithImpl<$Res>
    implements $ImageRecognitionRequestCopyWith<$Res> {
  _$ImageRecognitionRequestCopyWithImpl(this._self, this._then);

  final ImageRecognitionRequest _self;
  final $Res Function(ImageRecognitionRequest) _then;

/// Create a copy of ImageRecognitionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageBase64 = freezed,Object? imageUrl = freezed,Object? image_data = freezed,}) {
  return _then(_self.copyWith(
imageBase64: freezed == imageBase64 ? _self.imageBase64 : imageBase64 // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,image_data: freezed == image_data ? _self.image_data : image_data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageRecognitionRequest].
extension ImageRecognitionRequestPatterns on ImageRecognitionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageRecognitionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageRecognitionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageRecognitionRequest value)  $default,){
final _that = this;
switch (_that) {
case _ImageRecognitionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageRecognitionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ImageRecognitionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? imageBase64,  String? imageUrl,  String? image_data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageRecognitionRequest() when $default != null:
return $default(_that.imageBase64,_that.imageUrl,_that.image_data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? imageBase64,  String? imageUrl,  String? image_data)  $default,) {final _that = this;
switch (_that) {
case _ImageRecognitionRequest():
return $default(_that.imageBase64,_that.imageUrl,_that.image_data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? imageBase64,  String? imageUrl,  String? image_data)?  $default,) {final _that = this;
switch (_that) {
case _ImageRecognitionRequest() when $default != null:
return $default(_that.imageBase64,_that.imageUrl,_that.image_data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageRecognitionRequest implements ImageRecognitionRequest {
  const _ImageRecognitionRequest({this.imageBase64, this.imageUrl, this.image_data});
  factory _ImageRecognitionRequest.fromJson(Map<String, dynamic> json) => _$ImageRecognitionRequestFromJson(json);

@override final  String? imageBase64;
@override final  String? imageUrl;
// ignore: non_constant_identifier_names
@override final  String? image_data;

/// Create a copy of ImageRecognitionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageRecognitionRequestCopyWith<_ImageRecognitionRequest> get copyWith => __$ImageRecognitionRequestCopyWithImpl<_ImageRecognitionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageRecognitionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageRecognitionRequest&&(identical(other.imageBase64, imageBase64) || other.imageBase64 == imageBase64)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.image_data, image_data) || other.image_data == image_data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageBase64,imageUrl,image_data);

@override
String toString() {
  return 'ImageRecognitionRequest(imageBase64: $imageBase64, imageUrl: $imageUrl, image_data: $image_data)';
}


}

/// @nodoc
abstract mixin class _$ImageRecognitionRequestCopyWith<$Res> implements $ImageRecognitionRequestCopyWith<$Res> {
  factory _$ImageRecognitionRequestCopyWith(_ImageRecognitionRequest value, $Res Function(_ImageRecognitionRequest) _then) = __$ImageRecognitionRequestCopyWithImpl;
@override @useResult
$Res call({
 String? imageBase64, String? imageUrl, String? image_data
});




}
/// @nodoc
class __$ImageRecognitionRequestCopyWithImpl<$Res>
    implements _$ImageRecognitionRequestCopyWith<$Res> {
  __$ImageRecognitionRequestCopyWithImpl(this._self, this._then);

  final _ImageRecognitionRequest _self;
  final $Res Function(_ImageRecognitionRequest) _then;

/// Create a copy of ImageRecognitionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageBase64 = freezed,Object? imageUrl = freezed,Object? image_data = freezed,}) {
  return _then(_ImageRecognitionRequest(
imageBase64: freezed == imageBase64 ? _self.imageBase64 : imageBase64 // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,image_data: freezed == image_data ? _self.image_data : image_data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
