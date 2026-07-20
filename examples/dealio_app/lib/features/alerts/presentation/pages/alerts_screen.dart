import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:untitled5/core/common_widgets/agent_back_button.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/core/utils/plan_guard.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';
import 'package:untitled5/features/alerts/domain/entities/alert_entity.dart';
import 'package:untitled5/features/alerts/presentation/providers/alerts_provider.dart';
import 'package:untitled5/features/alerts/presentation/widgets/manual_link_alert_sheet.dart';
import 'package:untitled5/features/alerts/presentation/widgets/price_trend_chart.dart';
import 'package:untitled5/features/billing/presentation/providers/subscription_provider.dart';
import 'package:untitled5/features/billing/presentation/widgets/paywall_widget.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alertsProvider);
    final planGuard = ref.watch(planGuardProvider);
    final billing = ref.watch(billingStatusProvider).valueOrNull;
    final isKvont = billing?.subscription.plan.name == 'KVONT';
    final l10n = AppLocalizations.of(context);
    final pagePadding = AgentUiTokens.screenPadding(context);
    final gap = AgentUiTokens.sectionGap(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlueGlassBackground(
        child: SafeArea(
          child: ResponsivePageFrame(
            child: RefreshIndicator(
              onRefresh: () => ref.read(alertsProvider.notifier).fetchAlerts(),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        pagePadding,
                        8,
                        pagePadding,
                        0,
                      ),
                      child: _AlertsAgentHeader(
                        l10n: l10n,
                        onCreate: () => _openCreateFlow(
                          context,
                          ref,
                          kvontMode: isKvont && planGuard.canUseSuperAlerts,
                        ),
                        onHistory: () => context.push('/alerts/history'),
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
                      child: _buildSuperPanel(
                        context,
                        ref,
                        state: state,
                        isKvont: isKvont,
                        canUseSuperAlerts: planGuard.canUseSuperAlerts,
                        l10n: l10n,
                      ),
                    ),
                  ),
                  if (state.errorMessage != null)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: Text(
                          state.errorMessage!,
                          style: const TextStyle(
                            color: AppColors.danger,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  if (state.isLoading && state.alerts.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  else if (state.alerts.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyAlertsState(
                        onCreate: () => _openCreateFlow(
                          context,
                          ref,
                          kvontMode: isKvont && planGuard.canUseSuperAlerts,
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        pagePadding,
                        gap,
                        pagePadding,
                        context.responsiveBottomPadding,
                      ),
                      sliver: SliverList.builder(
                        itemCount: state.alerts.length,
                        itemBuilder: (context, index) {
                          final alert = state.alerts[index];
                          return RepaintBoundary(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _AlertCard(
                                alert: alert,
                                superMode:
                                    isKvont && planGuard.canUseSuperAlerts,
                                l10n: l10n,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openCreateFlow(
    BuildContext context,
    WidgetRef ref, {
    required bool kvontMode,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _CreateAlertFlowPicker(
          onSearch: () {
            Navigator.of(sheetContext).pop();
            context.push('/search');
          },
          onManualLink: () {
            Navigator.of(sheetContext).pop();
            _openManualLinkSheet(context, kvontMode: kvontMode);
          },
        );
      },
    );
  }

  Future<void> _openManualLinkSheet(
    BuildContext context, {
    required bool kvontMode,
  }) async {
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ManualLinkAlertSheet(kvontMode: kvontMode),
    );
  }

  Widget _buildSuperPanel(
    BuildContext context,
    WidgetRef ref, {
    required AlertsState state,
    required bool isKvont,
    required bool canUseSuperAlerts,
    required AppLocalizations l10n,
  }) {
    if (!canUseSuperAlerts || !isKvont) {
      return GlassContainer(
        borderRadius: 18,
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Iconsax.crown_1,
                color: AppColors.accent,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                l10n.alertsKvontUpgradeMessage,
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
            TextButton(
              onPressed: () => PaywallDialog.show(
                context,
                title: l10n.alertsKvontPaywallTitle,
                message: l10n.alertsKvontPaywallMessage,
              ),
              child: Text(l10n.commonUpgrade),
            ),
          ],
        ),
      );
    }

    return GlassContainer(
      borderRadius: 18,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.flash_1,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.alertsKvontActive,
                  style: TextStyle(
                    color: AppColors.onSurface(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              FilledButton.tonalIcon(
                onPressed: state.isActionInProgress
                    ? null
                    : () async {
                        final result = await ref
                            .read(alertsProvider.notifier)
                            .checkNow();
                        if (!context.mounted || result == null) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              l10n.alertsCheckNowResult(
                                '${result['checkedCount']}',
                                '${result['triggeredCount']}',
                                '${result['errors']}',
                              ),
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                icon: state.isActionInProgress
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Iconsax.refresh, size: 15),
                label: Text(l10n.alertsCheckNow),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.alertsKvontSubtitle,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertsAgentHeader extends StatelessWidget {
  final AppLocalizations l10n;
  final VoidCallback onCreate;
  final VoidCallback onHistory;

  const _AlertsAgentHeader({
    required this.l10n,
    required this.onCreate,
    required this.onHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AgentBackButton(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.alertsTitle,
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                  fontSize: AgentUiTokens.headerTitleSize(context),
                  letterSpacing: -0.45,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                l10n.alertsEmptySubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        _AlertsHeaderButton(
          icon: Iconsax.add_circle,
          tooltip: l10n.alertsCreateTooltip,
          onTap: onCreate,
        ),
        const SizedBox(width: 8),
        _AlertsHeaderButton(
          icon: Iconsax.activity,
          tooltip: l10n.alertsHistoryTooltip,
          onTap: onHistory,
        ),
      ],
    );
  }
}

class _AlertsHeaderButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _AlertsHeaderButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.adaptiveSurfaceColor(
              context,
              darkAlpha: 0.34,
              lightAlpha: 0.72,
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
              width: 0.7,
            ),
          ),
          child: Icon(icon, color: AppColors.onSurface(context), size: 17),
        ),
      ),
    );
  }
}

class _CreateAlertFlowPicker extends StatelessWidget {
  final VoidCallback onSearch;
  final VoidCallback onManualLink;

  const _CreateAlertFlowPicker({
    required this.onSearch,
    required this.onManualLink,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
        child: GlassContainer(
          borderRadius: AgentUiTokens.largeRadius(context),
          padding: EdgeInsets.fromLTRB(
            AgentUiTokens.cardPadding(context),
            12,
            AgentUiTokens.cardPadding(context),
            AgentUiTokens.cardPadding(context),
          ),
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.98,
            lightAlpha: 1,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 46,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.onMuted(context).withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                l10n.alertPickerTitle,
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.alertPickerSubtitle,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 14),
              _FlowOptionTile(
                icon: Iconsax.search_normal_1,
                title: l10n.alertPickerSearchTitle,
                subtitle: l10n.alertPickerSearchSubtitle,
                color: AppColors.primary,
                onTap: onSearch,
              ),
              const SizedBox(height: 10),
              _FlowOptionTile(
                icon: Iconsax.link_1,
                title: l10n.alertPickerManualTitle,
                subtitle: l10n.alertPickerManualSubtitle,
                color: AppColors.success,
                onTap: onManualLink,
              ),
              const SizedBox(height: 10),
              Text(
                l10n.alertPickerPlanLimits,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlowOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _FlowOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(
            AgentUiTokens.cardRadius(context),
          ),
          border: Border.all(color: color.withValues(alpha: 0.14), width: 0.8),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 18),
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
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.onMuted(context),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Iconsax.arrow_right_3, color: color, size: 18),
          ],
        ),
      ),
    );
  }
}

class _AlertCard extends ConsumerWidget {
  final AlertEntity alert;
  final bool superMode;
  final AppLocalizations l10n;

  const _AlertCard({
    required this.alert,
    required this.superMode,
    required this.l10n,
  });

  List<double> _trendPoints() {
    final points = alert.recentEvents
        .where((e) => e.triggerPrice != null && e.triggerPrice! > 0)
        .map((e) => e.triggerPrice!)
        .toList()
        .reversed
        .toList();

    if (points.length >= 2) return points;
    if (alert.targetPrice != null && alert.targetPrice! > 0) {
      final t = alert.targetPrice!;
      return [t * 1.05, t * 1.02, t];
    }
    return [220, 217, 214, 212];
  }

  List<String> _stores() {
    final set = <String>{};
    for (final e in alert.recentEvents) {
      final store = (e.store ?? '').trim();
      if (store.isNotEmpty) set.add(store);
    }
    return set.take(3).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastTriggered = alert.lastTriggeredAt != null
        ? DateFormat('MMM dd, HH:mm').format(alert.lastTriggeredAt!)
        : l10n.alertsNever;
    final trendPoints = _trendPoints();
    final stores = _stores();

    return GlassContainer(
      borderRadius: 18,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: alert.productImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          alert.productImage!,
                          fit: BoxFit.cover,
                          cacheWidth: 96,
                          filterQuality: FilterQuality.low,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Iconsax.shopping_bag,
                                color: AppColors.primary,
                              ),
                        ),
                      )
                    : const Icon(
                        Iconsax.shopping_bag,
                        color: AppColors.primary,
                      ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.productTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onSurface(context),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _pill(alert.alertType.label, AppColors.info),
                        const SizedBox(width: 6),
                        if (superMode) _pill('KVONT', AppColors.accent),
                      ],
                    ),
                  ],
                ),
              ),
              Switch(
                value: alert.isActive,
                activeThumbColor: AppColors.primary,
                onChanged: (_) =>
                    ref.read(alertsProvider.notifier).toggleAlert(alert),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                alert.targetPrice != null
                    ? l10n.alertsTargetValue(
                        alert.targetPrice!.toStringAsFixed(2),
                      )
                    : l10n.alertsTargetNA,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                l10n.alertsTriggers(alert.triggeredCount),
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.adaptiveCardColor(context, darkAlpha: 0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: PriceTrendChart(points: trendPoints, height: 92),
          ),
          const SizedBox(height: 8),
          if (stores.isNotEmpty)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: stores.map((s) => _pill(s, AppColors.primary)).toList(),
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.alertsLastTrigger(lastTriggered),
                  style: TextStyle(
                    color: AppColors.onMuted(context),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Iconsax.trash,
                  color: AppColors.danger,
                  size: 18,
                ),
                onPressed: () => _confirmDelete(context, ref),
              ),
            ],
          ),
          if (alert.recentEvents.isNotEmpty)
            ...alert.recentEvents
                .take(2)
                .map(
                  (event) => Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        const Icon(
                          Iconsax.flash_1,
                          size: 14,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            event.message,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.onSurface(context),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if ((event.storeLink ?? '').isNotEmpty)
                          TextButton(
                            onPressed: () => _launch(event.storeLink!),
                            child: Text(l10n.alertsDealButton),
                          ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.12), width: 0.6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.alertsDeleteTitle),
        content: Text(l10n.alertsDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(alertsProvider.notifier).deleteAlert(alert.id);
              Navigator.pop(context);
            },
            child: Text(
              l10n.commonDelete,
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launch(String link) async {
    await launchExternalWebUrl(link);
  }
}

class _EmptyAlertsState extends StatelessWidget {
  final VoidCallback onCreate;

  const _EmptyAlertsState({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AgentUiTokens.screenPadding(context),
        ),
        child: GlassContainer(
          borderRadius: AgentUiTokens.largeRadius(context),
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Iconsax.notification_bing,
                size: 32,
                color: AppColors.primary,
              ),
              const SizedBox(height: 10),
              Text(
                l10n.alertsEmptyTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: -0.25,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                l10n.alertsEmptySubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                  height: 1.38,
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: onCreate,
                icon: const Icon(Iconsax.add_circle, size: 17),
                label: Text(l10n.alertsCreateTooltip),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
