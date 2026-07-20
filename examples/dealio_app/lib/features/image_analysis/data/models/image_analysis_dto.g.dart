// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_analysis_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageAnalysisResponseDto _$ImageAnalysisResponseDtoFromJson(
  Map<String, dynamic> json,
) => _ImageAnalysisResponseDto(
  success: json['success'] as bool,
  imageAnalysis: ImageAnalysisDataDto.fromJson(
    json['imageAnalysis'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ImageAnalysisResponseDtoToJson(
  _ImageAnalysisResponseDto instance,
) => <String, dynamic>{
  'success': instance.success,
  'imageAnalysis': instance.imageAnalysis,
};

_ImageAnalysisDataDto _$ImageAnalysisDataDtoFromJson(
  Map<String, dynamic> json,
) => _ImageAnalysisDataDto(
  detectedProduct: json['detectedProduct'] as String,
  productTitle: json['productTitle'] as String,
  confidence: (json['confidence'] as num).toInt(),
  color: json['color'] as String,
  brand: json['brand'] as String,
  category: json['category'] as String,
  features: json['features'] as Map<String, dynamic>,
);

Map<String, dynamic> _$ImageAnalysisDataDtoToJson(
  _ImageAnalysisDataDto instance,
) => <String, dynamic>{
  'detectedProduct': instance.detectedProduct,
  'productTitle': instance.productTitle,
  'confidence': instance.confidence,
  'color': instance.color,
  'brand': instance.brand,
  'category': instance.category,
  'features': instance.features,
};
