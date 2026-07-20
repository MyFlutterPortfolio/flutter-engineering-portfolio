import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/agent_back_button.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/core/utils/plan_guard.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';
import 'package:untitled5/features/billing/presentation/widgets/paywall_widget.dart';
import 'package:untitled5/features/favorites/presentation/widgets/favorite_toggle_button.dart';
import 'package:untitled5/features/product/presentation/providers/product_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productDetailsProvider(productId));
    final planGuard = ref.watch(planGuardProvider);

    return Scaffold(
      body: BlueGlassBackground(
        child: productState.when(
          data: (product) {
            if (product == null) {
              return _buildNotFound(context);
            }

            final pagePadding = AgentUiTokens.screenPadding(context);

            return SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  ResponsivePageFrame(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        _buildSliverAppBar(context, product),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: pagePadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 14),
                                _buildBasicInfo(context, product),
                                const SizedBox(height: 18),
                                _buildPriceComparison(context, product),
                                const SizedBox(height: 18),
                                _buildAIVerdictSection(
                                  context,
                                  product,
                                  planGuard,
                                ),
                                const SizedBox(height: 18),
                                _buildSpecifications(context, product),
                                const SizedBox(height: 18),
                                if (planGuard.canSeeReviews)
                                  _buildReviewSection(context),
                                SizedBox(
                                  height: context.responsiveBottomPadding + 92,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildBottomAction(context, product),
                ],
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (err, _) => _buildErrorState(context, ref, err.toString()),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, Product product) {
    return SliverAppBar(
      expandedHeight: 244,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 52,
      leading: Padding(
        padding: const EdgeInsets.only(left: 14, top: 6),
        child: AgentBackButton(onTap: () => context.pop()),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: const EdgeInsets.fromLTRB(14, 8, 14, 0),
          decoration: BoxDecoration(
            color: AppColors.adaptiveCardColor(
              context,
              darkAlpha: 0.7,
              lightAlpha: 0.96,
            ),
            borderRadius: BorderRadius.circular(
              AgentUiTokens.largeRadius(context),
            ),
            border: Border.all(
              color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
              width: 0.55,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Hero(
                  tag: 'product_${product.id}',
                  child: Padding(
                    padding: const EdgeInsets.all(26),
                    child: product.imageUrl != null
                        ? Image.network(
                            product.imageUrl!,
                            fit: BoxFit.contain,
                            cacheWidth: 720,
                            filterQuality: FilterQuality.low,
                            errorBuilder: (_, _, _) => const Icon(
                              Iconsax.image,
                              size: 62,
                              color: AppColors.muted,
                            ),
                          )
                        : const Icon(
                            Iconsax.image,
                            size: 62,
                            color: AppColors.muted,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfo(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                product.brand.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              product.category,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          product.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: AppColors.onSurface(context),
            height: 1.12,
            letterSpacing: -0.45,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceComparison(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MARKET AVAILABILITY',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        ...product.dynamicPrices.map(
          (price) => _buildPriceCard(context, price),
        ),
      ],
    );
  }

  Widget _buildPriceCard(BuildContext context, DynamicPrice price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.7),
        borderRadius: BorderRadius.circular(AgentUiTokens.cardRadius(context)),
        border: Border.all(
          color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
          width: 0.55,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Iconsax.shop, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  price.store,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                Text(
                  price.availability ? 'In Stock' : 'Out of Stock',
                  style: TextStyle(
                    fontSize: 11,
                    color: price.availability
                        ? AppColors.primary
                        : AppColors.danger,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${price.currency} ${price.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  fontSize: 16,
                ),
              ),
              const Icon(
                Iconsax.arrow_right_3,
                size: 14,
                color: AppColors.muted,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIVerdictSection(
    BuildContext context,
    Product product,
    PlanGuard planGuard,
  ) {
    final ai = product.aiAnalysis;
    if (!planGuard.canUseAiAnalysis) {
      return _buildLockedBanner(context, 'Full AI Analysis Locked');
    }

    if (ai == null) {
      return Container(
        padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
        decoration: BoxDecoration(
          color: AppColors.adaptiveCardColor(context, darkAlpha: 0.7),
          borderRadius: BorderRadius.circular(
            AgentUiTokens.cardRadius(context),
          ),
        ),
        child: const Center(
          child: Column(
            children: [
              CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
              SizedBox(height: 16),
              Text(
                'Generating AI Insights...',
                style: TextStyle(color: AppColors.muted),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DEALIO AI VERDICT',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.1),
                AppColors.adaptiveCardColor(context, darkAlpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
              AgentUiTokens.cardRadius(context),
            ),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.08),
              width: 0.6,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildStatTile(
                    'Match',
                    '${ai.needsMatchScore?.toInt() ?? 0}%',
                    AppColors.primary,
                  ),
                  _buildStatDivider(),
                  _buildStatTile(
                    'Value',
                    ai.valueScore != null ? '${ai.valueScore}/5' : 'N/A',
                    AppColors.accent,
                  ),
                  _buildStatDivider(),
                  _buildStatTile('Trust', ai.trustLevel ?? 'N/A', Colors.blue),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                ai.recommendationForUser ??
                    ai.fitSummary ??
                    'No analysis available.',
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (ai.prosForUser.isNotEmpty) ...[
                const SizedBox(height: 14),
                const Text(
                  'Pros',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                ...ai.prosForUser
                    .take(3)
                    .map(
                      (p) => _buildBullet(
                        context,
                        p,
                        Iconsax.add_circle,
                        AppColors.primary,
                      ),
                    ),
              ],
              if (ai.consForUser.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text(
                  'Cons',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.danger,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                ...ai.consForUser
                    .take(3)
                    .map(
                      (c) => _buildBullet(
                        context,
                        c,
                        Iconsax.minus_cirlce,
                        AppColors.danger,
                      ),
                    ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatTile(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.muted.withValues(alpha: 0.2),
    );
  }

  Widget _buildBullet(
    BuildContext context,
    String text,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.onSurface(context),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecifications(BuildContext context, Product product) {
    if (product.specifications.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SPECIFICATIONS',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: product.specifications.entries.take(8).map((entry) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.adaptiveCardColor(context, darkAlpha: 0.64),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.value.toString(),
                    style: TextStyle(
                      color: AppColors.onSurface(context),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReviewSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'VERIFIED REVIEWS',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          decoration: BoxDecoration(
            color: AppColors.adaptiveCardColor(context, darkAlpha: 0.7),
            borderRadius: BorderRadius.circular(
              AgentUiTokens.cardRadius(context),
            ),
          ),
          child: const Center(
            child: Column(
              children: [
                Icon(Iconsax.message_notif, color: AppColors.muted, size: 32),
                SizedBox(height: 12),
                Text(
                  'No reviews yet in your region.',
                  style: TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context, Product product) {
    final bestPrice = product.dynamicPrices.isNotEmpty
        ? product.dynamicPrices.first
        : null;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          AgentUiTokens.screenPadding(context),
          12,
          AgentUiTokens.screenPadding(context),
          18,
        ),
        decoration: BoxDecoration(
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.88,
            lightAlpha: 0.95,
          ),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AgentUiTokens.largeRadius(context)),
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Starting at',
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                Text(
                  bestPrice != null
                      ? '${bestPrice.currency} ${bestPrice.price.toStringAsFixed(0)}'
                      : 'N/A',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            FavoriteToggleButton(
              product: product,
              size: 42,
              iconSize: 18,
              borderRadius: 14,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: bestPrice != null
                    ? () => _launchUrl(bestPrice.link)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.shopping_cart, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Buy Now',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedBanner(BuildContext context, String title) {
    const message =
        'Upgrade to PLUS or PRO to unlock neural insights, market sentiment, and verified deal analysis.';
    return Container(
      padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.72),
        borderRadius: BorderRadius.circular(AgentUiTokens.cardRadius(context)),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.08),
          width: 0.6,
        ),
      ),
      child: Column(
        children: [
          const Icon(Iconsax.lock, color: AppColors.accent, size: 32),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: AppColors.onSurface(context),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted, fontSize: 12),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () =>
                PaywallDialog.show(context, title: title, message: message),
            child: const Text(
              'View Plans',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AgentUiTokens.screenPadding(context)),
        child: Container(
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          decoration: BoxDecoration(
            color: AppColors.adaptiveCardColor(context, darkAlpha: 0.72),
            borderRadius: BorderRadius.circular(
              AgentUiTokens.cardRadius(context),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Iconsax.ghost, size: 34, color: AppColors.muted),
              const SizedBox(height: 10),
              Text(
                'Product not found',
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AgentUiTokens.screenPadding(context)),
        child: Container(
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          decoration: BoxDecoration(
            color: AppColors.adaptiveCardColor(context, darkAlpha: 0.72),
            borderRadius: BorderRadius.circular(
              AgentUiTokens.cardRadius(context),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Iconsax.danger, size: 34, color: AppColors.danger),
              const SizedBox(height: 10),
              Text(
                'Something went wrong',
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  fontSize: 12.5,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.refresh(productDetailsProvider(productId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    await launchExternalWebUrl(url);
  }
}
