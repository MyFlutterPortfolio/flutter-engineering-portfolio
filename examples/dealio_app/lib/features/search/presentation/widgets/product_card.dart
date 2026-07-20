import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';
import 'package:untitled5/features/favorites/presentation/widgets/favorite_toggle_button.dart';
import 'package:untitled5/features/search/presentation/providers/search_state.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final SearchStatus status;
  final VoidCallback? onTap;
  final VoidCallback? onCreateAlert;

  const ProductCard({
    super.key,
    required this.product,
    required this.status,
    this.onTap,
    this.onCreateAlert,
  });

  Future<void> _launchUrl(String url) async {
    await launchExternalWebUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.onSurface(context);
    final mutedColor = AppColors.onMuted(context);
    final ai = product.aiAnalysis;
    final hasAi = ai != null;
    final bestPrice = product.dynamicPrices.isNotEmpty
        ? product.dynamicPrices.first
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.adaptiveCardColor(context, darkAlpha: 0.74),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.018),
            width: 0.45,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.075),
              blurRadius: 14,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(context),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              product.brand.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primary,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (ai?.confidence != null)
                            _buildConfidenceBadge(ai!.confidence!),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (bestPrice != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BEST PRICE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: mutedColor,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            bestPrice.price.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            bestPrice.currency,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'at ${bestPrice.store}',
                        style: TextStyle(
                          fontSize: 12,
                          color: mutedColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                else
                  Expanded(
                    child: Text(
                      'Price sourcing in progress...',
                      style: TextStyle(
                        color: mutedColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                      ),
                    ),
                  ),
                if (hasAi && ai.needsMatchScore != null)
                  _buildMatchScore(ai.needsMatchScore!),
              ],
            ),
            const SizedBox(height: 20),
            if (hasAi) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.adaptiveSurfaceColor(
                    context,
                    darkAlpha: 0.92,
                    lightAlpha: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.025),
                    width: 0.45,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Iconsax.magic_star,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'AI VERDICT',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ai.recommendationForUser ??
                          ai.fitSummary ??
                          'No analysis available',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: textColor,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.isDark(context)
                          ? AppColors.background
                          : Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Full AI Analysis',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (bestPrice != null && bestPrice.link.isNotEmpty) ...[
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () => _launchUrl(bestPrice.link),
                    icon: const Icon(
                      Iconsax.shopping_cart,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
                if (onCreateAlert != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onCreateAlert,
                    icon: const Icon(
                      Iconsax.notification_bing,
                      color: AppColors.accent,
                      size: 20,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.accent.withValues(alpha: 0.12),
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    tooltip: 'Create price alert',
                  ),
                ],
                const SizedBox(width: 8),
                FavoriteToggleButton(
                  product: product,
                  size: 48,
                  iconSize: 20,
                  borderRadius: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: product.imageUrl != null
            ? Image.network(
                product.imageUrl!,
                fit: BoxFit.contain,
                cacheWidth: 180,
                filterQuality: FilterQuality.low,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Iconsax.image, color: AppColors.onMuted(context)),
              )
            : Icon(Iconsax.image, color: AppColors.onMuted(context)),
      ),
    );
  }

  Widget _buildConfidenceBadge(double confidence) {
    return Row(
      children: [
        const Icon(Iconsax.verify, size: 12, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          '${confidence.toInt()}%',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildMatchScore(double score) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.24),
          width: 0.8,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${score.toInt()}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
            const Text(
              'FIT',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
