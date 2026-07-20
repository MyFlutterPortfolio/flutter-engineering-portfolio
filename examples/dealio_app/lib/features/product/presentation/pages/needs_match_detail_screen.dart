import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/product/presentation/providers/product_provider.dart';

class NeedsMatchDetailScreen extends ConsumerWidget {
  final String productId;
  const NeedsMatchDetailScreen({super.key, required this.productId});

  IconData _getIcon(String iconType) {
    switch (iconType) {
      case 'cpu':
        return Iconsax.cpu;
      case 'battery':
        return Iconsax.battery_charging;
      case 'camera':
        return Iconsax.camera;
      default:
        return Iconsax.info_circle;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productDetailsProvider(productId));
    final theme = Theme.of(context);

    return Scaffold(
      body: productState.when(
        data: (product) {
          // Check for Clario backend needsMatchScore first, fallback to needsMatch object
          final ai = product?.aiAnalysis;
          final match = product?.needsMatch;

          if (product == null ||
              (ai?.needsMatchScore == null && match == null)) {
            return const Center(child: Text('Analysis data not available.'));
          }

          final double percentage =
              ai?.needsMatchScore ?? match?.matchPercentage ?? 0;
          final String compatibilityText =
              ai?.finalShoppingVerdict ??
              match?.compatibilityText ??
              'Compatible';
          final String summary = ai?.fitSummary ?? match?.summary ?? '';

          return Stack(
            children: [
              Positioned(
                top: -100,
                right: -100,
                child: _GlowCircle(
                  color: AppColors.cobalt.withValues(alpha: 0.1),
                ),
              ),
              SafeArea(
                child: ResponsivePageFrame(
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
                          onPressed: () => Navigator.pop(context),
                        ),
                        title: Text(
                          'Needs Match Analysis',
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
                            _ScoreOverviewCard(
                              percentage: percentage,
                              compatibilityText: compatibilityText,
                              summary: summary,
                            ),
                            const SizedBox(height: 32),
                            if (ai != null && ai.prosForUser.isNotEmpty) ...[
                              _SectionHeader(title: 'Key Reasons'),
                              const SizedBox(height: 16),
                              ...ai.prosForUser.map(
                                (p) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _MatchReasonCard(
                                    icon: Iconsax.tick_circle,
                                    title: 'Pro',
                                    content: p,
                                  ),
                                ),
                              ),
                            ] else if (match != null) ...[
                              _SectionHeader(title: 'Why it matches you'),
                              const SizedBox(height: 16),
                              ...match.reasons.map(
                                (reason) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _MatchReasonCard(
                                    icon: _getIcon(reason.iconType),
                                    title: reason.title,
                                    content: reason.content,
                                  ),
                                ),
                              ),
                            ],

                            if (ai?.recommendationForUser != null ||
                                match?.userPreferenceNote != null) ...[
                              const SizedBox(height: 32),
                              _SectionHeader(title: 'Expert Recommendation'),
                              const SizedBox(height: 16),
                              GlassContainer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (match?.userPreferenceNote != null)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 16.0,
                                        ),
                                        child: Text(
                                          '"${match!.userPreferenceNote}"',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontStyle: FontStyle.italic,
                                                color: theme.hintColor,
                                              ),
                                        ),
                                      ),
                                    const Text(
                                      'Dealio AI Verdict:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.teal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      ai?.recommendationForUser ??
                                          match?.aiNoteResponse ??
                                          '',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.cobalt,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 54),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Got it',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: context.responsiveBottomPadding),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _ScoreOverviewCard extends StatelessWidget {
  final double percentage;
  final String compatibilityText;
  final String summary;

  const _ScoreOverviewCard({
    required this.percentage,
    required this.compatibilityText,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child:
                    CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 12,
                      backgroundColor: AppColors.cobalt.withValues(alpha: 0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.teal,
                      ),
                    ).animate().custom(
                      duration: 1.5.seconds,
                      builder: (context, val, child) =>
                          CircularProgressIndicator(
                            value: val * (percentage / 100),
                            strokeWidth: 12,
                            backgroundColor: AppColors.cobalt.withValues(
                              alpha: 0.1,
                            ),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.teal,
                            ),
                          ),
                    ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${percentage.toInt()}%',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Match',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.teal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            compatibilityText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
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
        color: theme.hintColor,
      ),
    );
  }
}

class _MatchReasonCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _MatchReasonCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cobalt.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.cobalt, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: theme.textTheme.bodySmall?.copyWith(
                    height: 1.5,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade().slideX(begin: 0.1, end: 0);
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
