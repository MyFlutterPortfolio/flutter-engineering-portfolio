import 'package:untitled5/features/barcode/domain/entities/barcode_result.dart';

abstract class BarcodeRepository {
  Future<BarcodeInfoResult> processBarcode({
    required String code,
    required String type,
  });

  Future<BarcodeResult> getProductByBarcode(String barcode);
}
