import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/features/barcode/domain/entities/barcode_result.dart';

part 'barcode_dto.freezed.dart';
part 'barcode_dto.g.dart';

@freezed
abstract class BarcodeProcessResponseDto with _$BarcodeProcessResponseDto {
  const factory BarcodeProcessResponseDto({
    required bool success,
    required BarcodeDataDto barcode,
  }) = _BarcodeProcessResponseDto;

  factory BarcodeProcessResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BarcodeProcessResponseDtoFromJson(json);
}

@freezed
abstract class BarcodeDataDto with _$BarcodeDataDto {
  const BarcodeDataDto._();

  const factory BarcodeDataDto({
    required String barcodeNumber,
    required String barcodeType,
    required Map<String, dynamic> productInfo,
  }) = _BarcodeDataDto;

  factory BarcodeDataDto.fromJson(Map<String, dynamic> json) =>
      _$BarcodeDataDtoFromJson(json);

  BarcodeInfoResult toEntity() {
    return BarcodeInfoResult(
      barcodeNumber: barcodeNumber,
      barcodeType: barcodeType,
      productInfo: productInfo,
    );
  }
}

@freezed
abstract class ProductByBarcodeResponseDto with _$ProductByBarcodeResponseDto {
  const ProductByBarcodeResponseDto._();

  const factory ProductByBarcodeResponseDto({
    required bool success,
    required String source,
    Product? product,
    BarcodeDataDto? barcode,
  }) = _ProductByBarcodeResponseDto;

  factory ProductByBarcodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductByBarcodeResponseDtoFromJson(json);

  BarcodeResult toEntity() {
    if (source == 'linked-product' && product != null) {
      return LinkedProductResult(product!);
    } else if (source == 'barcode-info' && barcode != null) {
      return barcode!.toEntity();
    }
    throw Exception('Invalid barcode response source or missing data');
  }
}
