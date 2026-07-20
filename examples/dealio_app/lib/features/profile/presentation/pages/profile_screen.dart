import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:untitled5/core/common_widgets/agent_back_button.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/auth/presentation/providers/auth_provider.dart';
import 'package:untitled5/features/billing/presentation/providers/subscription_provider.dart';
import 'package:untitled5/features/profile/domain/entities/profile_entity.dart';
import 'package:untitled5/features/profile/presentation/providers/profile_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final billingState = ref.watch(billingStatusProvider);
    final billingData = billingState.asData?.value;
    final profileState = ref.watch(profileProvider);
    final profileData = profileState.profile;
    final viewData = profileData != null
        ? _ProfileViewData.fromProfile(
            profileData,
            fallbackBilling: billingData,
          )
        : billingData != null
        ? _ProfileViewData.fromBilling(
            billingData,
            displayName: l10n.profileName,
          )
        : _ProfileViewData.fallback(displayName: l10n.profileName);

    final textColor = AppColors.onSurface(context);
    final mutedColor = AppColors.onMuted(context);
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
                    child: _TopBar(
                      title: l10n.navProfile,
                      onNotifications: () =>
                          _safePush(context, '/notifications'),
                      onSettings: () => _safePush(context, '/profile/settings'),
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
                    child: _IdentityCard(
                      l10n: l10n,
                      viewData: viewData,
                      mutedColor: mutedColor,
                      isUpdating: profileState.isUpdating,
                      onEdit: profileData == null || profileState.isUpdating
                          ? null
                          : () => _openProfileEditor(context, ref, profileData),
                    ),
                  ),
                ),
                if (profileState.errorMessage != null &&
                    profileState.errorMessage!.trim().isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        pagePadding,
                        8,
                        pagePadding,
                        0,
                      ),
                      child: Text(
                        profileState.errorMessage!,
                        style: const TextStyle(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
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
                      0,
                    ),
                    child: _QuickActions(
                      l10n: l10n,
                      onAlerts: () => _safePush(context, '/alerts'),
                      onFavorites: () => _safePush(context, '/favorites'),
                      onSettings: () => _safePush(context, '/profile/settings'),
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
                    child: _RewardsCard(
                      l10n: l10n,
                      viewData: viewData,
                      textColor: textColor,
                      mutedColor: mutedColor,
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
                    child: _SettingsSection(
                      l10n: l10n,
                      textColor: textColor,
                      mutedColor: mutedColor,
                      onTap: () => _safePush(context, '/profile/settings'),
                      onAbout: () => _safePush(context, '/profile/about'),
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
                    child: _LogoutCard(
                      l10n: l10n,
                      onLogout: () => _logout(context, ref),
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

  Future<void> _openProfileEditor(
    BuildContext context,
    WidgetRef ref,
    ProfileEntity profile,
  ) async {
    final payload = await showDialog<_ProfileEditPayload>(
      context: context,
      builder: (_) => _EditProfileDialog(profile: profile),
    );

    if (payload == null || !context.mounted) {
      return;
    }

    await ref
        .read(profileProvider.notifier)
        .updateProfile(
          firstName: payload.firstName,
          lastName: payload.lastName,
          avatar: payload.avatarUrl,
        );

    if (!context.mounted) {
      return;
    }

    final updatedState = ref.read(profileProvider);
    final error = updatedState.errorMessage?.trim();
    if (error != null && error.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _safePush(BuildContext context, String location) {
    final current = GoRouterState.of(context).uri.path;
    if (current == location) {
      return;
    }
    context.push(location);
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.commonLogout),
          content: Text(l10n.settingsLogoutSubtitle),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.commonLogout),
            ),
          ],
        );
      },
    );

    if (confirm != true || !context.mounted) {
      return;
    }

    await ref.read(authProvider.notifier).logout();
    if (context.mounted) {
      context.go('/login');
    }
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.onNotifications,
    required this.onSettings,
  });

  final String title;
  final VoidCallback onNotifications;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AgentBackButton(),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.onSurface(context),
              fontWeight: FontWeight.w900,
              fontSize: AgentUiTokens.headerTitleSize(context),
              letterSpacing: -0.4,
            ),
          ),
        ),
        _IconActionButton(icon: Iconsax.notification, onTap: onNotifications),
        const SizedBox(width: 8),
        _IconActionButton(icon: Iconsax.setting_2, onTap: onSettings),
      ],
    );
  }
}

class _IconActionButton extends StatelessWidget {
  const _IconActionButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: GlassContainer(
        width: AgentUiTokens.iconButton(context),
        height: AgentUiTokens.iconButton(context),
        borderRadius: 12,
        padding: EdgeInsets.zero,
        child: Icon(icon, color: AppColors.onSurface(context), size: 17),
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({
    required this.l10n,
    required this.viewData,
    required this.mutedColor,
    required this.isUpdating,
    required this.onEdit,
  });

  final AppLocalizations l10n;
  final _ProfileViewData viewData;
  final Color mutedColor;
  final bool isUpdating;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: AgentUiTokens.cardRadius(context),
      padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.adaptiveSurfaceColor(context),
              child: viewData.avatarUrl == null
                  ? const Icon(Iconsax.user, size: 23, color: AppColors.primary)
                  : ClipOval(
                      child: Image.network(
                        viewData.avatarUrl!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        cacheWidth: 128,
                        filterQuality: FilterQuality.low,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Iconsax.user,
                              size: 23,
                              color: AppColors.primary,
                            ),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewData.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.onSurface(context),
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        l10n.profileGoldStatus,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.settingsSearchesLeft(
                          viewData.remainingSearches,
                          viewData.searchLimit,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: mutedColor,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PlanBadge(plan: viewData.plan, label: viewData.planLabel(l10n)),
              const SizedBox(height: 8),
              InkWell(
                onTap: isUpdating ? null : onEdit,
                borderRadius: BorderRadius.circular(12),
                child: GlassContainer(
                  width: AgentUiTokens.iconButton(context),
                  height: AgentUiTokens.iconButton(context),
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  child: isUpdating
                      ? const Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        )
                      : Icon(
                          Iconsax.edit,
                          color: AppColors.onSurface(context),
                          size: 16,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanBadge extends StatelessWidget {
  const _PlanBadge({required this.plan, required this.label});

  final SubscriptionPlan plan;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = _ProfileViewData.planColor(plan);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.12), width: 0.7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.crown_1, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.l10n,
    required this.onAlerts,
    required this.onFavorites,
    required this.onSettings,
  });

  final AppLocalizations l10n;
  final VoidCallback onAlerts;
  final VoidCallback onFavorites;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionChip(
            icon: Iconsax.notification,
            label: l10n.alertsTitle,
            onTap: onAlerts,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _QuickActionChip(
            icon: Iconsax.heart,
            label: l10n.favoritesTitle,
            onTap: onFavorites,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _QuickActionChip(
            icon: Iconsax.setting_2,
            label: l10n.commonSettings,
            onTap: onSettings,
          ),
        ),
      ],
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 14,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 17, color: AppColors.primary),
            const SizedBox(height: 5),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.onSurface(context),
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardsCard extends StatelessWidget {
  const _RewardsCard({
    required this.l10n,
    required this.viewData,
    required this.textColor,
    required this.mutedColor,
  });

  final AppLocalizations l10n;
  final _ProfileViewData viewData;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    final progress = viewData.progress;
    final currency = NumberFormat.simpleCurrency(
      name: viewData.cashbackCurrency,
      decimalDigits: 2,
    );

    return GlassContainer(
      borderRadius: AgentUiTokens.cardRadius(context),
      padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.profileCashbackBalance,
                      style: TextStyle(
                        color: mutedColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      currency.format(viewData.cashbackBalance),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Iconsax.wallet_3,
                  color: AppColors.primary,
                  size: 21,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: progress,
              backgroundColor: Colors.black.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.profilePointsProgress(
                    viewData.pointsTotal.toString(),
                    viewData.pointsCurrent.toString(),
                  ),
                  style: TextStyle(
                    color: mutedColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.5,
                  ),
                ),
              ),
              Text(
                l10n.profileNextReward(
                  NumberFormat.simpleCurrency(
                    name: viewData.cashbackCurrency,
                    decimalDigits: 0,
                  ).format(viewData.nextReward),
                ),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.l10n,
    required this.textColor,
    required this.mutedColor,
    required this.onTap,
    required this.onAbout,
  });

  final AppLocalizations l10n;
  final Color textColor;
  final Color mutedColor;
  final VoidCallback onTap;
  final VoidCallback onAbout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Text(
            l10n.profileSettingsPreferences,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
        ),
        GlassContainer(
          borderRadius: AgentUiTokens.cardRadius(context),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _SettingsTile(
                icon: Iconsax.notification,
                title: l10n.profileNotifications,
                subtitle: l10n.profileNotificationsSubtitle,
                textColor: textColor,
                mutedColor: mutedColor,
                onTap: onTap,
              ),
              _AdaptiveDivider(color: mutedColor),
              _SettingsTile(
                icon: Iconsax.card,
                title: l10n.profilePaymentMethods,
                subtitle: l10n.profilePaymentMethodsSubtitle,
                textColor: textColor,
                mutedColor: mutedColor,
                onTap: onTap,
              ),
              _AdaptiveDivider(color: mutedColor),
              _SettingsTile(
                icon: Iconsax.security_safe,
                title: l10n.profileSecurity,
                subtitle: l10n.profileSecuritySubtitle,
                textColor: textColor,
                mutedColor: mutedColor,
                onTap: onTap,
              ),
              _AdaptiveDivider(color: mutedColor),
              _SettingsTile(
                icon: Iconsax.info_circle,
                title: l10n.aboutTitle,
                subtitle: l10n.aboutSubtitle,
                textColor: textColor,
                mutedColor: mutedColor,
                onTap: onAbout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.textColor,
    required this.mutedColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color textColor;
  final Color mutedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      leading: Container(
        width: AgentUiTokens.iconBox(context),
        height: AgentUiTokens.iconBox(context),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 17),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
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
      trailing: Icon(
        Iconsax.arrow_right_3,
        color: mutedColor.withValues(alpha: 0.7),
        size: 16,
      ),
    );
  }
}

class _AdaptiveDivider extends StatelessWidget {
  const _AdaptiveDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: color.withValues(alpha: 0.2),
    );
  }
}

class _LogoutCard extends StatelessWidget {
  const _LogoutCard({required this.l10n, required this.onLogout});

  final AppLocalizations l10n;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onLogout,
      borderRadius: BorderRadius.circular(18),
      child: GlassContainer(
        borderRadius: AgentUiTokens.cardRadius(context),
        padding: EdgeInsets.symmetric(
          horizontal: AgentUiTokens.cardPadding(context),
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              width: AgentUiTokens.iconBox(context),
              height: AgentUiTokens.iconBox(context),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Iconsax.logout,
                color: AppColors.danger,
                size: 17,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                l10n.profileLogout,
                style: const TextStyle(
                  color: AppColors.danger,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              color: AppColors.danger.withValues(alpha: 0.8),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileEditPayload {
  const _ProfileEditPayload({
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
  });

  final String firstName;
  final String lastName;
  final String avatarUrl;
}

class _EditProfileDialog extends StatefulWidget {
  const _EditProfileDialog({required this.profile});

  final ProfileEntity profile;

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _avatarController;
  late final String _initialName;
  late final String _initialAvatar;

  @override
  void initState() {
    super.initState();
    final first = (widget.profile.user.firstName ?? '').trim();
    final last = (widget.profile.user.lastName ?? '').trim();
    _initialName = '$first $last'.trim();
    _initialAvatar = (widget.profile.user.avatar ?? '').trim();
    _fullNameController = TextEditingController(text: _initialName);
    _avatarController = TextEditingController(text: _initialAvatar);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.length > 160) {
      return 'Name is too long.';
    }
    if (trimmed.isEmpty) {
      return null;
    }

    final parts = trimmed.split(RegExp(r'\s+'));
    final first = parts.first;
    final last = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    if (first.length > 80 || last.length > 80) {
      return 'Name parts must be 80 characters or less.';
    }
    return null;
  }

  String? _validateAvatar(String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) {
      return null;
    }
    if (trimmed.length > 2048) {
      return 'Avatar URL is too long.';
    }

    final uri = Uri.tryParse(trimmed);
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.trim().isEmpty) {
      return 'Avatar URL must be a valid http/https link.';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final fullName = _fullNameController.text.trim();
    final avatar = _avatarController.text.trim();

    if (fullName == _initialName && avatar == _initialAvatar) {
      Navigator.of(context).pop();
      return;
    }

    String firstName = '';
    String lastName = '';
    if (fullName.isNotEmpty) {
      final parts = fullName.split(RegExp(r'\s+'));
      firstName = parts.first;
      lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    }

    Navigator.of(context).pop(
      _ProfileEditPayload(
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text('${l10n.commonEdit} ${l10n.navProfile}'),
      content: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _fullNameController,
                textInputAction: TextInputAction.next,
                maxLength: 160,
                decoration: InputDecoration(
                  labelText: l10n.authFullNameLabel,
                  hintText: l10n.profileName,
                ),
                validator: _validateName,
              ),
              TextFormField(
                controller: _avatarController,
                textInputAction: TextInputAction.done,
                maxLength: 2048,
                decoration: const InputDecoration(
                  labelText: 'Avatar URL',
                  hintText: 'https://example.com/avatar.png',
                ),
                validator: _validateAvatar,
                onFieldSubmitted: (_) => _submit(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(onPressed: _submit, child: Text(l10n.commonEdit)),
      ],
    );
  }
}

class _ProfileViewData {
  const _ProfileViewData({
    required this.plan,
    required this.searchLimit,
    required this.remainingSearches,
    required this.cashbackBalance,
    required this.cashbackCurrency,
    required this.pointsCurrent,
    required this.pointsTotal,
    required this.nextReward,
    required this.displayName,
    required this.avatarUrl,
  });

  final SubscriptionPlan plan;
  final int searchLimit;
  final int remainingSearches;
  final double cashbackBalance;
  final String cashbackCurrency;
  final int pointsCurrent;
  final int pointsTotal;
  final double nextReward;
  final String displayName;
  final String? avatarUrl;

  double get progress {
    if (pointsTotal <= 0) {
      return 0;
    }
    return (pointsCurrent / pointsTotal).clamp(0.0, 1.0);
  }

  static _ProfileViewData fallback({required String displayName}) {
    return _ProfileViewData(
      plan: SubscriptionPlan.FREE,
      searchLimit: 10,
      remainingSearches: 10,
      cashbackBalance: 48.50,
      cashbackCurrency: 'USD',
      pointsCurrent: 120,
      pointsTotal: 1000,
      nextReward: 15,
      displayName: displayName,
      avatarUrl: null,
    );
  }

  static _ProfileViewData fromBilling(
    BillingStatusResponse data, {
    required String displayName,
  }) {
    final plan = data.subscription.plan;
    final limit = data.quota.search.limit;
    final remaining = data.quota.search.remaining;
    final used = (limit - remaining).clamp(0, limit == 0 ? 0 : limit);

    final planBalance = switch (plan) {
      SubscriptionPlan.FREE => 48.50,
      SubscriptionPlan.PLUS => 128.50,
      SubscriptionPlan.PRO => 256.50,
      SubscriptionPlan.KVONT => 428.50,
    };

    final pointsTotal = 1000;
    final pointsCurrent = limit <= 0
        ? 120
        : ((used / limit) * pointsTotal).round().clamp(0, pointsTotal);
    final rewardGap = (pointsTotal - pointsCurrent).clamp(0, pointsTotal);
    final nextReward = (rewardGap / 50).clamp(5, 120).toDouble();

    return _ProfileViewData(
      plan: plan,
      searchLimit: limit,
      remainingSearches: remaining,
      cashbackBalance: planBalance,
      cashbackCurrency: 'USD',
      pointsCurrent: pointsCurrent,
      pointsTotal: pointsTotal,
      nextReward: nextReward,
      displayName: displayName,
      avatarUrl: null,
    );
  }

  static _ProfileViewData fromProfile(
    ProfileEntity profile, {
    BillingStatusResponse? fallbackBilling,
  }) {
    final fallbackPlan =
        fallbackBilling?.subscription.plan ?? SubscriptionPlan.FREE;
    final plan = _mapPlan(profile.subscription.plan, fallbackPlan);

    final fallbackLimit = fallbackBilling?.quota.search.limit ?? 10;
    final fallbackRemaining =
        fallbackBilling?.quota.search.remaining ?? fallbackLimit;

    final quotaLimit = profile.searchQuota.limit ?? fallbackLimit;
    final quotaRemaining = profile.searchQuota.remaining ?? fallbackRemaining;
    final pointsTotal = profile.cashback.pointsTotal <= 0
        ? 1000
        : profile.cashback.pointsTotal;

    final avatar = profile.user.avatar?.trim();

    return _ProfileViewData(
      plan: plan,
      searchLimit: quotaLimit,
      remainingSearches: quotaRemaining,
      cashbackBalance: profile.cashback.balance,
      cashbackCurrency: profile.cashback.currency,
      pointsCurrent: profile.cashback.pointsCurrent.clamp(0, pointsTotal),
      pointsTotal: pointsTotal,
      nextReward: profile.cashback.nextRewardAmount,
      displayName: profile.user.displayName,
      avatarUrl: avatar == null || avatar.isEmpty ? null : avatar,
    );
  }

  static SubscriptionPlan _mapPlan(String rawPlan, SubscriptionPlan fallback) {
    switch (rawPlan.trim().toUpperCase()) {
      case 'PLUS':
        return SubscriptionPlan.PLUS;
      case 'PRO':
        return SubscriptionPlan.PRO;
      case 'KVONT':
        return SubscriptionPlan.KVONT;
      case 'FREE':
        return SubscriptionPlan.FREE;
      default:
        return fallback;
    }
  }

  String planLabel(AppLocalizations l10n) {
    return switch (plan) {
      SubscriptionPlan.FREE => l10n.planFree,
      SubscriptionPlan.PLUS => l10n.planPlus,
      SubscriptionPlan.PRO => l10n.planPro,
      SubscriptionPlan.KVONT => l10n.planKvont,
    };
  }

  static Color planColor(SubscriptionPlan plan) {
    return switch (plan) {
      SubscriptionPlan.FREE => AppColors.muted,
      SubscriptionPlan.PLUS => AppColors.info,
      SubscriptionPlan.PRO => AppColors.primary,
      SubscriptionPlan.KVONT => AppColors.accent,
    };
  }
}
