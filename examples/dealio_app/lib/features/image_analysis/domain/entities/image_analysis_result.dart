class ImageAnalysisResult {
  final String detectedProduct;
  final String productTitle;
  final int confidence;
  final String color;
  final String brand;
  final String category;
  final Map<String, dynamic> features;

  ImageAnalysisResult({
    required this.detectedProduct,
    required this.productTitle,
    required this.confidence,
    required this.color,
    required this.brand,
    required this.category,
    required this.features,
  });
}
