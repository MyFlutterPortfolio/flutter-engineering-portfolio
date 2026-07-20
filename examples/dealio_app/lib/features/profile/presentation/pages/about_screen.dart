import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/agent_back_button.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pagePadding = AgentUiTokens.screenPadding(context);

    return Scaffold(
      body: BlueGlassBackground(
        child: SafeArea(
          child: ResponsivePageFrame(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pagePadding,
                      8,
                      pagePadding,
                      0,
                    ),
                    child: Row(
                      children: [
                        const AgentBackButton(),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.aboutTitle,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppColors.onSurface(context),
                                  fontWeight: FontWeight.w900,
                                  fontSize: AgentUiTokens.headerTitleSize(
                                    context,
                                  ),
                                  letterSpacing: -0.45,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    pagePadding,
                    AgentUiTokens.sectionGap(context),
                    pagePadding,
                    context.responsiveBottomPadding,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _AboutHero(l10n: l10n),
                      const SizedBox(height: 16),
                      const _AboutSection(
                        title: 'Our Mission',
                        content:
                            'Dealio is your next-generation AI shopping companion. Every purchase should be backed by verified market data, not marketing noise.',
                      ),
                      const SizedBox(height: 14),
                      const _SectionTitle(title: 'Key Features'),
                      const SizedBox(height: 10),
                      const _FeatureTile(
                        icon: Iconsax.magicpen,
                        title: 'AI Smart Analysis',
                        description:
                            'Transforms product data, reviews, and user needs into practical buying advice.',
                      ),
                      const _FeatureTile(
                        icon: Iconsax.shop,
                        title: 'Store Comparison',
                        description:
                            'Compares available offers across supported stores and highlights stronger deals.',
                      ),
                      const _FeatureTile(
                        icon: Iconsax.notification_status,
                        title: 'Price Alerts',
                        description:
                            'Tracks prices and helps you act when a product reaches the right moment.',
                      ),
                      const SizedBox(height: 16),
                      const _SectionTitle(title: 'Privacy & Transparency'),
                      const SizedBox(height: 10),
                      const _AboutSection(
                        title: 'Data Security',
                        content:
                            'Dealio is designed around secure account data, private shopping context, and clear user control.',
                      ),
                      const SizedBox(height: 12),
                      const _AboutSection(
                        title: 'AI Reliability',
                        content:
                            'AI recommendations are advisory. Always verify final price, availability, and seller details before purchase.',
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          l10n.aboutSubtitle,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.onMuted(context),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutHero extends StatelessWidget {
  final AppLocalizations l10n;

  const _AboutHero({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: AgentUiTokens.largeRadius(context),
      padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
      child: Column(
        children: [
          Image.asset(
            'assets/logo/app.png',
            width: 54,
            height: 54,
          ).animate().scale(
            duration: 420.ms,
            curve: Curves.easeOutCubic,
            begin: const Offset(0.94, 0.94),
          ),
          const SizedBox(height: 10),
          const Text(
            'DEALIO',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            l10n.aboutSubtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.onSurface(context),
        fontWeight: FontWeight.w900,
        fontSize: 15,
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String title;
  final String content;

  const _AboutSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: AgentUiTokens.cardRadius(context),
      padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.onMuted(context),
              height: 1.42,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        borderRadius: AgentUiTokens.cardRadius(context),
        padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AgentUiTokens.iconBox(context),
              height: AgentUiTokens.iconBox(context),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 17),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.onSurface(context),
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.onMuted(context),
                      height: 1.38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
