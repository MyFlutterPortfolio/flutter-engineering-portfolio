import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled5/features/image_analysis/domain/entities/image_analysis_result.dart';

part 'image_analysis_dto.freezed.dart';
part 'image_analysis_dto.g.dart';

@freezed
abstract class ImageAnalysisResponseDto with _$ImageAnalysisResponseDto {
  const factory ImageAnalysisResponseDto({
    required bool success,
    required ImageAnalysisDataDto imageAnalysis,
  }) = _ImageAnalysisResponseDto;

  factory ImageAnalysisResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ImageAnalysisResponseDtoFromJson(json);
}

@freezed
abstract class ImageAnalysisDataDto with _$ImageAnalysisDataDto {
  const ImageAnalysisDataDto._();

  const factory ImageAnalysisDataDto({
    required String detectedProduct,
    required String productTitle,
    required int confidence,
    required String color,
    required String brand,
    required String category,
    required Map<String, dynamic> features,
  }) = _ImageAnalysisDataDto;

  factory ImageAnalysisDataDto.fromJson(Map<String, dynamic> json) =>
      _$ImageAnalysisDataDtoFromJson(json);

  ImageAnalysisResult toEntity() {
    return ImageAnalysisResult(
      detectedProduct: detectedProduct,
      productTitle: productTitle,
      confidence: confidence,
      color: color,
      brand: brand,
      category: category,
      features: features,
    );
  }
}
