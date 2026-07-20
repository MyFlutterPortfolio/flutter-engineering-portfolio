import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/barcode/domain/entities/barcode_result.dart';
import 'package:untitled5/features/search/presentation/providers/search_state.dart';
import 'package:untitled5/features/search/presentation/widgets/product_card.dart';

class BarcodeResultView extends StatelessWidget {
  final BarcodeResult result;
  final VoidCallback onScanAgain;
  final ValueChanged<String>? onUseForSearch;

  const BarcodeResultView({
    super.key,
    required this.result,
    required this.onScanAgain,
    this.onUseForSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (result is LinkedProductResult) {
      final product = (result as LinkedProductResult).product;
      final detectedQuery = _extractLinkedProductQuery(product);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.teal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Iconsax.verify, color: AppColors.teal),
                SizedBox(width: 12),
                Text(
                  'Product matched in our database!',
                  style: TextStyle(
                    color: AppColors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ProductCard(product: product, status: SearchStatus.stage3Ready),
          const SizedBox(height: 24),
          if (onUseForSearch != null && detectedQuery.isNotEmpty)
            _UseForSearchButton(
              query: detectedQuery,
              onPressed: () => onUseForSearch!(detectedQuery),
            ),
          if (onUseForSearch != null && detectedQuery.isNotEmpty)
            const SizedBox(height: 12),
          _ScanAgainButton(onPressed: onScanAgain),
        ],
      );
    }

    if (result is BarcodeInfoResult) {
      final info = result as BarcodeInfoResult;
      final detectedQuery = _extractBarcodeInfoQuery(info);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.barcode,
                        size: 32,
                        color: AppColors.cobalt,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            info.barcodeNumber,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            info.barcodeType,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  Text(
                    'External Metadata',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...info.productInfo.entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entry.key}: ',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${entry.value}',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (onUseForSearch != null && detectedQuery.isNotEmpty)
            _UseForSearchButton(
              query: detectedQuery,
              onPressed: () => onUseForSearch!(detectedQuery),
            ),
          if (onUseForSearch != null && detectedQuery.isNotEmpty)
            const SizedBox(height: 12),
          _ScanAgainButton(onPressed: onScanAgain),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  String _extractLinkedProductQuery(Product product) {
    final title = product.title.trim();
    if (title.isNotEmpty) return title;
    final parts = <String>[
      product.brand.trim(),
      product.modelName.trim(),
      product.category.trim(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' ').trim();
  }

  String _extractBarcodeInfoQuery(BarcodeInfoResult info) {
    final productInfo = info.productInfo;
    final external = productInfo['external'];
    if (external is Map<String, dynamic>) {
      final externalTitle = _safeString(
        external['title'] ?? external['name'] ?? external['product_title'],
      );
      if (externalTitle.isNotEmpty) return externalTitle;
    }

    final direct = _safeString(
      productInfo['detectedProduct'] ??
          productInfo['productTitle'] ??
          productInfo['title'] ??
          productInfo['name'] ??
          productInfo['model'],
    );
    if (direct.isNotEmpty) return direct;

    return info.barcodeNumber;
  }

  String _safeString(dynamic value) {
    return value?.toString().trim() ?? '';
  }
}

class _ScanAgainButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ScanAgainButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.cobalt,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.scan_barcode),
          SizedBox(width: 12),
          Text(
            'Scan Another Product',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _UseForSearchButton extends StatelessWidget {
  final String query;
  final VoidCallback onPressed;

  const _UseForSearchButton({required this.query, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(color: AppColors.cobalt),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Use This Product In Search',
            style: TextStyle(
              color: AppColors.cobalt,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            query,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
