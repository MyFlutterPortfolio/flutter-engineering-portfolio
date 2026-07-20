import 'package:dio/dio.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/network/api_endpoints.dart';
import 'package:untitled5/core/network/failures.dart';
import 'package:untitled5/features/image_analysis/data/models/image_analysis_dto.dart';
import 'package:untitled5/features/image_analysis/domain/entities/image_analysis_result.dart';
import 'package:untitled5/features/image_analysis/domain/repositories/image_analysis_repository.dart';

class ImageAnalysisRepositoryImpl implements ImageAnalysisRepository {
  final ApiClient _apiClient;

  ImageAnalysisRepositoryImpl(this._apiClient);

  @override
  Future<ImageAnalysisResult> analyzeImage({
    String? imageUrl,
    String? imageBase64,
  }) async {
    try {
      final payload = <String, dynamic>{};
      if (imageUrl != null && imageUrl.trim().isNotEmpty) {
        payload['imageUrl'] = imageUrl.trim();
      }
      if (imageBase64 != null && imageBase64.trim().isNotEmpty) {
        payload['imageBase64'] = imageBase64.trim();
      }

      final response = await _apiClient.dio.post(
        ApiEndpoints.analyzeImage,
        data: payload,
      );

      if (response.statusCode == 503) {
        throw AppException('Image AI temporarily unavailable');
      }

      final dto = ImageAnalysisResponseDto.fromJson(response.data);
      return dto.imageAnalysis.toEntity();
    } on DioException catch (e) {
      if (e.response?.statusCode == 503) {
        throw AppException('Image AI temporarily unavailable');
      }
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }
}
