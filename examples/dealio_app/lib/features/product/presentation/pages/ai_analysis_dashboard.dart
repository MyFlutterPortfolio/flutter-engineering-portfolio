import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/product/presentation/providers/product_provider.dart';

class AIAnalysisDashboard extends ConsumerWidget {
  final String productId;
  const AIAnalysisDashboard({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // First fetch the product details
    final productAsync = ref.watch(productDetailsProvider(productId));

    return Scaffold(
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: _GlowCircle(
              color: AppColors.cobalt.withValues(alpha: isDark ? 0.1 : 0.05),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: _GlowCircle(
              color: AppColors.purple.withValues(alpha: isDark ? 0.1 : 0.05),
            ),
          ),
          productAsync.when(
            data: (product) {
              if (product == null) {
                return const Center(child: Text('Product not found'));
              }
              final sentimentAsync = ref.watch(
                sentimentAnalysisProvider(product),
              );
              final recommendationAsync = ref.watch(
                aiRecommendationProvider(product),
              );

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
                        'AI Analysis: ${product.modelName}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      centerTitle: true,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(24.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          _SectionHeader(title: 'Review Sentiment Analysis'),
                          const SizedBox(height: 16),
                          sentimentAsync.when(
                            data: (data) => _SentimentCard(data: data),
                            loading: () => const _LoadingPlaceholder(
                              label: 'Analyzing reviews...',
                            ),
                            error: (e, st) => _ErrorCard(
                              onRetry: () => ref.invalidate(
                                sentimentAnalysisProvider(product),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          _SectionHeader(title: 'AI Personal Recommendation'),
                          const SizedBox(height: 16),
                          recommendationAsync.when(
                            data: (data) => _NeedsMatchCard(
                              productId: productId,
                              data: data,
                            ),
                            loading: () => const _LoadingPlaceholder(
                              label: 'Matching with your needs...',
                            ),
                            error: (e, st) => _ErrorCard(
                              onRetry: () => ref.invalidate(
                                aiRecommendationProvider(product),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          _SectionHeader(title: 'AI Final Verdict'),
                          const SizedBox(height: 16),
                          recommendationAsync.when(
                            data: (data) => _ConclusionCard(data: data),
                            loading: () => const _LoadingPlaceholder(
                              label: 'Generating verdict...',
                            ),
                            error: (e, st) => const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 32),
                          _AskAIMoreCard(productId: productId),
                          SizedBox(height: context.responsiveBottomPadding),
                        ]),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(
              child: _ErrorCard(
                onRetry: () => ref.refresh(productDetailsProvider(productId)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  final String label;
  const _LoadingPlaceholder({required this.label});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.cobalt,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorCard({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(Iconsax.danger, color: Colors.redAccent, size: 30),
          const SizedBox(height: 12),
          const Text(
            'Analysis Data Unavailable',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(color: AppColors.cobalt),
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

class _NeedsMatchCard extends StatelessWidget {
  final String productId;
  final Map<String, dynamic> data;
  const _NeedsMatchCard({required this.productId, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final score = data['matchScore'] ?? data['score'] ?? 'N/A';
    final reason =
        data['recommendation'] ??
        data['reason'] ??
        'Based on your profile, Dealio is calculating the best fit.';

    return GestureDetector(
      onTap: () => context.push(
        '/needs-match-detail/${Uri.encodeComponent(productId.trim())}',
      ),
      child: GlassContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Match Score: $score%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.teal,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              reason,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    ).animate().fade();
  }
}

class _SentimentCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const _SentimentCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sentiment = data['sentiment'] ?? 'Neutral';
    final summary = data['summary'] ?? 'Customer feedback analysis...';
    final pros = List<String>.from(data['pros'] ?? []);
    final cons = List<String>.from(data['cons'] ?? []);

    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Iconsax.message_favorite,
                color: AppColors.teal,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Sentiment: $sentiment',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            summary,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
          if (pros.isNotEmpty || cons.isNotEmpty) ...[
            const Divider(height: 24, color: Colors.white10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (pros.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PROS',
                          style: TextStyle(
                            color: AppColors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...pros.map((p) => _BulletPoint(p)),
                      ],
                    ),
                  ),
                if (cons.isNotEmpty) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CONS',
                          style: TextStyle(
                            color: Colors.redAccent.withValues(alpha: 0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...cons.map((c) => _BulletPoint(c)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    ).animate().fade();
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: theme.textTheme.bodySmall),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConclusionCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const _ConclusionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final verdict =
        data['verdict'] ??
        data['conclusion'] ??
        'Based on the analysis, Dealio suggests considering all factors before purchase.';

    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verdict',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.teal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            verdict,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    ).animate().fade();
  }
}

class _AskAIMoreCard extends StatelessWidget {
  final String productId;
  const _AskAIMoreCard({required this.productId});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.push(
              Uri(
                path: '/ai-chat',
                queryParameters: {'productId': productId.trim()},
              ).toString(),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.cobalt),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              children: const [
                Icon(Iconsax.magicpen, size: 20, color: AppColors.cobalt),
                SizedBox(width: 12),
                Text(
                  'Ask Dealio Anything',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.cobalt,
                  ),
                ),
              ],
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
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
      ),
    );
  }
}
