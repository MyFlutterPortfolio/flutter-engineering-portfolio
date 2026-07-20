import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/favorites/presentation/widgets/favorite_toggle_button.dart';
import 'package:untitled5/features/product/presentation/providers/product_provider.dart';

class ProductCompositionScreen extends ConsumerWidget {
  final String productId;
  const ProductCompositionScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final productAsync = ref.watch(productDetailsProvider(productId));

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: _GlowCircle(
              color: AppColors.cobalt.withValues(alpha: isDark ? 0.1 : 0.05),
            ),
          ),
          SafeArea(
            child: productAsync.when(
              data: (product) {
                if (product == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.box, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text('Product not found'),
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text('Go Back'),
                        ),
                      ],
                    ),
                  );
                }
                return _buildContent(context, product);
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.cobalt),
              ),
              error: (e, st) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load details\n$e',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            ref.refresh(productDetailsProvider(productId)),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, Product product) {
    final theme = Theme.of(context);
    return ResponsivePageFrame(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: theme.iconTheme.color,
              ),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Product Composition',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ProductSummaryCard(product: product),
                const SizedBox(height: 32),
                if (product.specifications.isNotEmpty) ...[
                  const _SectionHeader(title: 'Technical Specifications'),
                  const SizedBox(height: 16),
                  _CompositionTable(specifications: product.specifications),
                  const SizedBox(height: 32),
                ],
                if (product.dynamicPrices.isNotEmpty) ...[
                  const _SectionHeader(title: 'Store Availability'),
                  const SizedBox(height: 16),
                  _StoreAvailabilityList(prices: product.dynamicPrices),
                  const SizedBox(height: 32),
                ],
                if (product.aiAnalysis != null) ...[
                  const _SectionHeader(title: 'AI Insights & Analysis'),
                  const SizedBox(height: 16),
                  _AiInsightsCard(ai: product.aiAnalysis!),
                  const SizedBox(height: 40),
                ],
                _ActionButtons(product: product),
                SizedBox(height: context.responsiveBottomPadding),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary.withValues(alpha: 0.7),
      ),
    ).animate().fade().slideX(begin: -0.1);
  }
}

class _ProductSummaryCard extends StatelessWidget {
  final Product product;
  const _ProductSummaryCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: product.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.imageUrl!,
                      fit: BoxFit.cover,
                      cacheWidth: 240,
                      filterQuality: FilterQuality.low,
                      errorBuilder: (c, e, s) =>
                          const Icon(Iconsax.image, color: Colors.grey),
                    ),
                  )
                : Icon(Iconsax.image, color: theme.disabledColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${product.brand} | ${product.category}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ],
            ),
          ),
          if (product.aiAnalysis?.authenticityReport == 'Verified')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.teal.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Original',
                style: TextStyle(
                  color: AppColors.teal,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),
        ],
      ),
    );
  }
}

class _CompositionTable extends StatelessWidget {
  final Map<String, dynamic> specifications;
  const _CompositionTable({required this.specifications});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      padding: EdgeInsets.zero,
      child: Table(
        columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
        children: [
          _buildHeaderRow(theme),
          ...specifications.entries.map(
            (e) => _buildRow(theme, e.key, e.value.toString()),
          ),
        ],
      ),
    );
  }

  TableRow _buildHeaderRow(ThemeData theme) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white10)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Feature',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.hintColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Details',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.hintColor,
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildRow(ThemeData theme, String key, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            key,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.cobalt,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _StoreAvailabilityList extends StatelessWidget {
  final List<DynamicPrice> prices;
  const _StoreAvailabilityList({required this.prices});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: prices
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _StoreCard(
                name: p.store,
                price: '${p.currency} ${p.price.toStringAsFixed(2)}',
                note: p.availability ? 'In Stock' : 'Out of Stock',
                url: p.link,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _StoreCard extends StatelessWidget {
  final String name;
  final String price;
  final String? note;
  final String? url;
  const _StoreCard({
    required this.name,
    required this.price,
    this.note,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (note != null)
                  Text(
                    note!,
                    style: TextStyle(
                      color: note == 'In Stock' ? AppColors.teal : Colors.red,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            price,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          if (url != null && url!.isNotEmpty)
            const Icon(Icons.link, size: 16, color: AppColors.cobalt),
        ],
      ),
    );
  }
}

class _AiInsightsCard extends StatelessWidget {
  final AIAnalysis ai;
  const _AiInsightsCard({required this.ai});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (ai.needsMatchScore != null) ...[
            Row(
              children: [
                _MatchScoreBadge(score: ai.needsMatchScore!),
                const Spacer(),
                if (ai.confidence != null)
                  _ConfidenceChip(confidence: ai.confidence!),
              ],
            ),
            const SizedBox(height: 16),
          ],
          if (ai.fitSummary != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                ai.fitSummary!,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),
          if (ai.recommendationForUser != null)
            _InsightItem(
              text: ai.recommendationForUser!,
              icon: Iconsax.direct_right,
              isHighlight: true,
            ),

          if (ai.prosForUser.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'Pros:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            ...ai.prosForUser.map(
              (p) => _InsightItem(
                text: p,
                icon: Iconsax.tick_circle,
                color: AppColors.teal,
              ),
            ),
          ],

          if (ai.consForUser.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'Cons:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            ...ai.consForUser.map(
              (c) => _InsightItem(
                text: c,
                icon: Iconsax.close_circle,
                color: Colors.red,
              ),
            ),
          ],

          if (ai.cautionFlags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ai.cautionFlags
                  .map((f) => _CautionBadge(text: f))
                  .toList(),
            ),
          ],

          if (ai.actionPlan != null) ...[
            const SizedBox(height: 16),
            const Text(
              'Action Plan:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              ai.actionPlan!,
              style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
            ),
          ],
        ],
      ),
    );
  }
}

class _MatchScoreBadge extends StatelessWidget {
  final double score;
  const _MatchScoreBadge({required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cobalt,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Iconsax.magicpen, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            '${score.toInt()}% Match',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfidenceChip extends StatelessWidget {
  final double confidence;
  const _ConfidenceChip({required this.confidence});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.verified_user, size: 12, color: Colors.blue[400]),
        const SizedBox(width: 4),
        Text(
          'Confidence: ${confidence.toInt()}%',
          style: TextStyle(
            fontSize: 10,
            color: Colors.blue[400],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _CautionBadge extends StatelessWidget {
  final String text;
  const _CautionBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.14),
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Iconsax.warning_2, size: 10, color: Colors.orange),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final bool isHighlight;

  const _InsightItem({
    required this.text,
    this.icon = Iconsax.magicpen,
    this.color = AppColors.cobalt,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                height: 1.4,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight
                    ? theme.colorScheme.onSurface
                    : theme.textTheme.bodySmall?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final Product product;
  const _ActionButtons({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MainButton(
          label: 'Ask AI More',
          icon: Iconsax.message_question,
          onTap: () => context.push(
            Uri(
              path: '/ai-chat',
              queryParameters: {'productId': product.id.trim()},
            ).toString(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SecondaryButton(
                label: 'Re-analyze',
                icon: Iconsax.refresh,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Center(
                child: FavoriteToggleButton(
                  product: product,
                  size: 50,
                  iconSize: 21,
                  borderRadius: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MainButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _MainButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.cobalt,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  const _SecondaryButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.6),
          width: 0.8,
        ),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: theme.iconTheme.color),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  const _GlowCircle({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
      ),
    );
  }
}
