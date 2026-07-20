import 'package:dio/dio.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/network/api_endpoints.dart';
import 'package:untitled5/core/network/failures.dart';
import 'package:untitled5/features/barcode/data/models/barcode_dto.dart';
import 'package:untitled5/features/barcode/domain/entities/barcode_result.dart';
import 'package:untitled5/features/barcode/domain/repositories/barcode_repository.dart';

class BarcodeRepositoryImpl implements BarcodeRepository {
  final ApiClient _apiClient;

  BarcodeRepositoryImpl(this._apiClient);

  @override
  Future<BarcodeInfoResult> processBarcode({
    required String code,
    required String type,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.processBarcode,
        data: {'barcodeNumber': code, 'barcodeType': type},
      );
      final dto = BarcodeProcessResponseDto.fromJson(response.data);
      return dto.barcode.toEntity();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw AppException('Invalid barcode format');
      }
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  @override
  Future<BarcodeResult> getProductByBarcode(String barcode) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.productByBarcode(barcode),
      );
      final dto = ProductByBarcodeResponseDto.fromJson(response.data);
      return dto.toEntity();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw AppException('Product not found');
      }
      throw AppException.fromDio(e);
    } catch (e) {
      throw AppException.unknown(e);
    }
  }
}
