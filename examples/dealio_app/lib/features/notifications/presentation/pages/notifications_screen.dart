import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/agent_back_button.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/alerts/domain/entities/alert_entity.dart';
import 'package:untitled5/features/alerts/presentation/providers/alerts_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> _dismissedIds = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(alertEventsProvider);
    final pagePadding = AgentUiTokens.screenPadding(context);
    return Scaffold(
      body: BlueGlassBackground(
        child: SafeArea(
          child: ResponsivePageFrame(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(pagePadding, 8, pagePadding, 0),
                  child: _NotificationsHeader(
                    onClearAll: () => _showClearConfirmation(context),
                    onSettings: () => _safePush(context, '/profile/settings'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(pagePadding, 10, 0, 0),
                  child: _CategoryTabs(tabController: _tabController),
                ),
                Expanded(child: _buildNotificationFeed(eventsAsync)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showClearConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.adaptiveSurfaceColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l10n.notificationsClearTitle),
        content: Text(l10n.notificationsClearMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              final events = ref.read(alertEventsProvider).valueOrNull ?? [];
              setState(() {
                _dismissedIds.addAll(events.map((event) => event.id));
              });
              Navigator.pop(context);
            },
            child: Text(
              l10n.commonClear,
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ],
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

  Widget _buildNotificationFeed(
    AsyncValue<List<AlertEventEntity>> eventsAsync,
  ) {
    return eventsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (error, stackTrace) => _EmptyNotifications(
        title: AppLocalizations.of(context).notificationsUnavailableTitle,
        subtitle: AppLocalizations.of(context).notificationsUnavailableSubtitle,
      ),
      data: (events) {
        final notifications = events
            .where((event) => !_dismissedIds.contains(event.id))
            .map(_notificationFromAlertEvent)
            .toList();

        if (notifications.isEmpty) {
          return const _EmptyNotifications();
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            ref.invalidate(alertEventsProvider);
            await ref.read(alertEventsProvider.future);
          },
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(
              AgentUiTokens.screenPadding(context),
              AgentUiTokens.sectionGap(context),
              AgentUiTokens.screenPadding(context),
              context.responsiveBottomPadding,
            ),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return _NotificationCard(
                notification: notification,
                onDismiss: () {
                  setState(() => _dismissedIds.add(notification.id));
                },
                onView: () {
                  if (notification.productId.isNotEmpty) {
                    context.push(
                      '/product/${Uri.encodeComponent(notification.productId.trim())}',
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }

  ClarioNotification _notificationFromAlertEvent(AlertEventEntity event) {
    final l10n = AppLocalizations.of(context);
    final price = event.triggerPrice != null
        ? ' ${event.currency ?? 'USD'} ${event.triggerPrice!.toStringAsFixed(2)}'
        : '';
    final store = event.store?.trim().isNotEmpty == true
        ? l10n.notificationsAtStore(event.store!)
        : '';
    return ClarioNotification(
      id: event.id,
      productId: event.productId,
      type: _notificationType(event.eventType),
      title: _notificationTitle(event.eventType),
      description: event.message.trim().isNotEmpty
          ? event.message
          : l10n.notificationsAlertMatched(price, store),
      timestamp: _relativeTime(event.createdAt),
    );
  }

  NotificationType _notificationType(String eventType) {
    final value = eventType.toUpperCase();
    if (value.contains('STOCK')) return NotificationType.storeAlert;
    return NotificationType.priceDrop;
  }

  String _notificationTitle(String eventType) {
    final value = eventType.toUpperCase();
    final l10n = AppLocalizations.of(context);
    if (value.contains('STOCK')) return l10n.notificationsBackInStock;
    if (value.contains('DEAL')) return l10n.notificationsDealFound;
    return l10n.notificationsPriceAlert;
  }

  String _relativeTime(DateTime date) {
    final l10n = AppLocalizations.of(context);
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return l10n.notificationsJustNow;
    if (diff.inMinutes < 60) {
      return l10n.notificationsMinutesAgo(diff.inMinutes);
    }
    if (diff.inHours < 24) {
      return l10n.notificationsHoursAgo(diff.inHours);
    }
    if (diff.inDays < 7) return l10n.notificationsDaysAgo(diff.inDays);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class _NotificationsHeader extends StatelessWidget {
  final VoidCallback onClearAll;
  final VoidCallback onSettings;

  const _NotificationsHeader({
    required this.onClearAll,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        const AgentBackButton(),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            l10n.notificationsTitle,
            style: TextStyle(
              color: AppColors.onSurface(context),
              fontSize: AgentUiTokens.headerTitleSize(context),
              fontWeight: FontWeight.w900,
              letterSpacing: -0.45,
            ),
          ),
        ),
        TextButton(
          onPressed: onClearAll,
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            foregroundColor: AppColors.onMuted(context),
          ),
          child: Text(
            l10n.commonClear,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
          ),
        ),
        _NotificationHeaderButton(icon: Iconsax.setting_2, onTap: onSettings),
      ],
    );
  }
}

class _NotificationHeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NotificationHeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: GlassContainer(
        width: AgentUiTokens.iconButton(context),
        height: AgentUiTokens.iconButton(context),
        borderRadius: 999,
        padding: EdgeInsets.zero,
        color: AppColors.adaptiveSurfaceColor(
          context,
          darkAlpha: 0.34,
          lightAlpha: 0.72,
        ),
        child: Icon(icon, color: AppColors.onSurface(context), size: 17),
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  final TabController tabController;
  const _CategoryTabs({required this.tabController});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TabBar(
      controller: tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorColor: AppColors.primary,
      dividerColor: Colors.transparent,
      labelColor: AppColors.onSurface(context),
      unselectedLabelColor: AppColors.onMuted(context),
      labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
      tabs: [
        Tab(text: l10n.notificationsTabAll),
        Tab(text: l10n.notificationsTabPriceAlerts),
        Tab(text: l10n.notificationsTabAiInsights),
        Tab(text: l10n.notificationsTabSustainability),
        Tab(text: l10n.notificationsTabStoreUpdates),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final ClarioNotification notification;
  final VoidCallback onDismiss;
  final VoidCallback onView;

  const _NotificationCard({
    required this.notification,
    required this.onDismiss,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: Key(notification.id),
        onDismissed: (_) => onDismiss(),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 18),
          decoration: BoxDecoration(
            color: Colors.redAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(
              AgentUiTokens.cardRadius(context),
            ),
          ),
          child: const Icon(Iconsax.trash, color: Colors.redAccent),
        ),
        child: GlassContainer(
          borderRadius: AgentUiTokens.cardRadius(context),
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _NotificationIcon(type: notification.type),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: TextStyle(
                            color: AppColors.onSurface(context),
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          notification.timestamp,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.onMuted(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Text(
                notification.description,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  height: 1.4,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: l10n.notificationsViewProduct,
                      onTap: onView,
                      color: AppColors.cobalt,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ActionButton(
                      label: l10n.notificationsReanalyze,
                      onTap: () {},
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  final NotificationType type;
  const _NotificationIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (type) {
      case NotificationType.priceDrop:
        icon = Iconsax.status_up; // fallback for trending_down
        color = AppColors.success;
        break;
      case NotificationType.aiInsight:
        icon = Iconsax.magicpen;
        color = AppColors.purple;
        break;
      case NotificationType.sustainability:
        icon = Icons.eco_outlined;
        color = Colors.greenAccent;
        break;
      case NotificationType.storeAlert:
        icon = Iconsax.shop;
        color = AppColors.cobalt;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 17),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.08), width: 0.6),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _EmptyNotifications({this.title, this.subtitle});

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
              Icon(
                Iconsax.notification_bing,
                size: 32,
                color: AppColors.primary.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 10),
              Text(
                title ?? l10n.notificationsEmptyTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.25,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                subtitle ?? l10n.notificationsEmptySubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  height: 1.38,
                ),
              ),
            ],
          ),
        ),
      ).animate().fade(),
    );
  }
}

enum NotificationType { priceDrop, aiInsight, sustainability, storeAlert }

class ClarioNotification {
  final String id;
  final String productId;
  final NotificationType type;
  final String title;
  final String description;
  final String timestamp;

  ClarioNotification({
    required this.id,
    this.productId = '',
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
  });
}
