import 'package:untitled5/features/image_analysis/domain/entities/image_analysis_result.dart';

abstract class ImageAnalysisRepository {
  Future<ImageAnalysisResult> analyzeImage({
    String? imageUrl,
    String? imageBase64,
  });
}
