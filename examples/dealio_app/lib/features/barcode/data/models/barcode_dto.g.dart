// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BarcodeProcessResponseDto _$BarcodeProcessResponseDtoFromJson(
  Map<String, dynamic> json,
) => _BarcodeProcessResponseDto(
  success: json['success'] as bool,
  barcode: BarcodeDataDto.fromJson(json['barcode'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BarcodeProcessResponseDtoToJson(
  _BarcodeProcessResponseDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'barcode': instance.barcode,
};

_BarcodeDataDto _$BarcodeDataDtoFromJson(Map<String, dynamic> json) =>
    _BarcodeDataDto(
      barcodeNumber: json['barcodeNumber'] as String,
      barcodeType: json['barcodeType'] as String,
      productInfo: json['productInfo'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$BarcodeDataDtoToJson(_BarcodeDataDto instance) =>
    <String, dynamic>{
      'barcodeNumber': instance.barcodeNumber,
      'barcodeType': instance.barcodeType,
      'productInfo': instance.productInfo,
    };

_ProductByBarcodeResponseDto _$ProductByBarcodeResponseDtoFromJson(
  Map<String, dynamic> json,
) => _ProductByBarcodeResponseDto(
  success: json['success'] as bool,
  source: json['source'] as String,
  product: json['product'] == null
      ? null
      : Product.fromJson(json['product'] as Map<String, dynamic>),
  barcode: json['barcode'] == null
      ? null
      : BarcodeDataDto.fromJson(json['barcode'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductByBarcodeResponseDtoToJson(
  _ProductByBarcodeResponseDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'source': instance.source,
  'product': instance.product,
  'barcode': instance.barcode,
};
