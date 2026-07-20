import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/agent_back_button.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/common_widgets/language_picker_sheet.dart';
import 'package:untitled5/core/localization/app_language.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/core/providers/language_provider.dart';
import 'package:untitled5/core/providers/theme_provider.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/auth/presentation/providers/auth_provider.dart';
import 'package:untitled5/features/billing/presentation/providers/subscription_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final appLanguage = ref.watch(appLanguageProvider);
    final billingState = ref.watch(billingStatusProvider);
    final isDark = themeMode == ThemeMode.dark;
    final dividerColor = Theme.of(context).dividerColor;
    final l10n = AppLocalizations.of(context);
    final pagePadding = AgentUiTokens.screenPadding(context);
    final gap = AgentUiTokens.sectionGap(context);

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
                    child: _Header(
                      isDark: isDark,
                      onBack: () {
                        if (Navigator.of(context).canPop()) {
                          context.pop();
                          return;
                        }
                        context.go('/home');
                      },
                      onToggleTheme: () =>
                          ref.read(themeProvider.notifier).toggleTheme(),
                      l10n: l10n,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pagePadding,
                      gap,
                      pagePadding,
                      0,
                    ),
                    child: _subscriptionCard(context, billingState, l10n),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pagePadding,
                      gap,
                      pagePadding,
                      0,
                    ),
                    child: GlassContainer(
                      borderRadius: AgentUiTokens.cardRadius(context),
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          _Tile(
                            icon: isDark ? Iconsax.moon : Iconsax.sun_1,
                            title: l10n.settingsThemeTitle,
                            subtitle: isDark
                                ? l10n.settingsDarkEnabled
                                : l10n.settingsLightEnabled,
                            trailing: Switch.adaptive(
                              value: isDark,
                              onChanged: (_) => ref
                                  .read(themeProvider.notifier)
                                  .toggleTheme(),
                              activeThumbColor: AppColors.primary,
                            ),
                          ),
                          Divider(height: 1, color: dividerColor),
                          _Tile(
                            icon: Iconsax.global,
                            title: l10n.languageTitle,
                            subtitle:
                                '${appLanguage.nativeName} • ${l10n.languageSubtitle}',
                            onTap: () => showLanguagePickerSheet(context),
                          ),
                          Divider(height: 1, color: dividerColor),
                          _Tile(
                            icon: Iconsax.notification,
                            title: l10n.settingsNotificationsTitle,
                            subtitle: l10n.settingsNotificationsSubtitle,
                          ),
                          Divider(height: 1, color: dividerColor),
                          _Tile(
                            icon: Iconsax.security_safe,
                            title: l10n.settingsPrivacyTitle,
                            subtitle: l10n.settingsPrivacySubtitle,
                            onTap: () {},
                          ),
                          Divider(height: 1, color: dividerColor),
                          _Tile(
                            icon: Iconsax.info_circle,
                            title: l10n.aboutTitle,
                            subtitle: l10n.aboutSubtitle,
                            onTap: () => context.push('/profile/about'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pagePadding,
                      gap,
                      pagePadding,
                      context.responsiveBottomPadding,
                    ),
                    child: GlassContainer(
                      borderRadius: AgentUiTokens.cardRadius(context),
                      padding: EdgeInsets.zero,
                      child: _Tile(
                        icon: Iconsax.logout,
                        title: l10n.commonLogout,
                        subtitle: l10n.settingsLogoutSubtitle,
                        danger: true,
                        onTap: () async {
                          await ref.read(authProvider.notifier).logout();
                          if (!context.mounted) return;
                          context.go('/login');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _localizedPlanName(AppLocalizations l10n, SubscriptionPlan plan) {
    return switch (plan) {
      SubscriptionPlan.FREE => l10n.planFree,
      SubscriptionPlan.PLUS => l10n.planPlus,
      SubscriptionPlan.PRO => l10n.planPro,
      SubscriptionPlan.KVONT => l10n.planKvont,
    };
  }

  Widget _subscriptionCard(
    BuildContext context,
    AsyncValue<BillingStatusResponse> billingState,
    AppLocalizations l10n,
  ) {
    final textColor = AppColors.onSurface(context);
    final mutedColor = AppColors.onMuted(context);

    return billingState.when(
      loading: () => const GlassContainer(
        borderRadius: 18,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => GlassContainer(
        borderRadius: AgentUiTokens.cardRadius(context),
        padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.settingsSubscriptionUnavailable,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              '$error',
              style: TextStyle(color: mutedColor, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      data: (data) {
        final plan = data.subscription.plan;
        final searchQuota = data.quota.search;
        final quotaText = l10n.settingsSearchesLeft(
          searchQuota.remaining,
          searchQuota.limit,
        );

        final Color planColor = switch (plan) {
          SubscriptionPlan.FREE => AppColors.muted,
          SubscriptionPlan.PLUS => AppColors.info,
          SubscriptionPlan.PRO => AppColors.primary,
          SubscriptionPlan.KVONT => AppColors.accent,
        };

        final planName = _localizedPlanName(l10n, plan);

        return GlassContainer(
          borderRadius: AgentUiTokens.cardRadius(context),
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: planColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(Iconsax.crown_1, color: planColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settingsPlanLabel(planName),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      quotaText,
                      style: TextStyle(
                        color: mutedColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () => context.push('/subscription'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(88, 36),
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(l10n.commonManage),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final bool isDark;
  final VoidCallback onBack;
  final VoidCallback onToggleTheme;
  final AppLocalizations l10n;

  const _Header({
    required this.isDark,
    required this.onBack,
    required this.onToggleTheme,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.onSurface(context);

    return Row(
      children: [
        AgentBackButton(onTap: onBack),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            l10n.commonSettings,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w900,
              fontSize: AgentUiTokens.headerTitleSize(context),
            ),
          ),
        ),
        IconButton(
          onPressed: onToggleTheme,
          icon: Icon(
            isDark ? Iconsax.sun_1 : Iconsax.moon,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool danger;

  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.onSurface(context);
    final mutedColor = AppColors.onMuted(context);
    final color = danger ? AppColors.danger : AppColors.primary;

    return ListTile(
      onTap: onTap,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      leading: Container(
        width: AgentUiTokens.iconBox(context),
        height: AgentUiTokens.iconBox(context),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 17),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: danger ? AppColors.danger : textColor,
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: mutedColor,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
      trailing:
          trailing ?? Icon(Iconsax.arrow_right_3, color: mutedColor, size: 16),
    );
  }
}
