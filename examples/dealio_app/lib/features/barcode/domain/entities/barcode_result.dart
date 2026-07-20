import 'package:untitled5/core/models/product_model.dart';

abstract class BarcodeResult {}

class LinkedProductResult extends BarcodeResult {
  final Product product;
  LinkedProductResult(this.product);
}

class BarcodeInfoResult extends BarcodeResult {
  final String barcodeNumber;
  final String barcodeType;
  final Map<String, dynamic> productInfo;

  BarcodeInfoResult({
    required this.barcodeNumber,
    required this.barcodeType,
    required this.productInfo,
  });
}
