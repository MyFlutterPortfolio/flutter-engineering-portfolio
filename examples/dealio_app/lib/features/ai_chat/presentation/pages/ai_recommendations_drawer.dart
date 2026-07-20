part of 'ai_recommendations_screen.dart';

class _AgentDrawer extends StatelessWidget {
  final AppLocalizations l10n;
  final List<AIChatThread> threads;
  final String? activeThreadId;
  final AppLanguage currentLanguage;
  final VoidCallback onNewChat;
  final ValueChanged<AIChatThread> onOpenThread;
  final ValueChanged<AIChatThread> onRenameThread;
  final ValueChanged<AIChatThread> onDeleteThread;
  final VoidCallback onLanguage;
  final VoidCallback onSearch;
  final VoidCallback onFavorites;
  final VoidCallback onAlerts;
  final VoidCallback onProfile;
  final VoidCallback onAbout;
  final VoidCallback onSettings;

  const _AgentDrawer({
    required this.l10n,
    required this.threads,
    required this.activeThreadId,
    required this.currentLanguage,
    required this.onNewChat,
    required this.onOpenThread,
    required this.onRenameThread,
    required this.onDeleteThread,
    required this.onLanguage,
    required this.onSearch,
    required this.onFavorites,
    required this.onAlerts,
    required this.onProfile,
    required this.onAbout,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final compact = context.viewportWidth < 390;
    final width = context.viewportWidth < 420
        ? context.viewportWidth * 0.88
        : 344.0;

    void closeThen(VoidCallback action) {
      Navigator.of(context).pop();
      WidgetsBinding.instance.addPostFrameCallback((_) => action());
    }

    return Drawer(
      width: width,
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(compact ? 9 : 12, 8, 8, 8),
          child: _FrostedSurface(
            borderRadius: compact ? 26 : 30,
            padding: EdgeInsets.fromLTRB(
              compact ? 12 : 14,
              compact ? 12 : 14,
              compact ? 12 : 14,
              12,
            ),
            color: AppColors.adaptiveSurfaceColor(
              context,
              darkAlpha: 0.72,
              lightAlpha: 0.90,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _DrawerBrand(
                  l10n: l10n,
                  onSettings: () => closeThen(onSettings),
                ),
                SizedBox(height: compact ? 14 : 18),
                _DrawerAction(
                  icon: Iconsax.add_circle,
                  label: l10n.aiChatNewChat,
                  emphasized: true,
                  onTap: () => closeThen(onNewChat),
                ),
                SizedBox(height: compact ? 14 : 18),
                _DrawerSectionLabel(label: l10n.aiChatManualActions),
                _DrawerAction(
                  icon: Iconsax.search_normal_1,
                  label: l10n.navSearch,
                  onTap: () => closeThen(onSearch),
                ),
                _DrawerAction(
                  icon: Iconsax.heart,
                  label: l10n.navFavorites,
                  onTap: () => closeThen(onFavorites),
                ),
                _DrawerAction(
                  icon: Iconsax.notification_bing,
                  label: l10n.alertsTitle,
                  onTap: () => closeThen(onAlerts),
                ),
                SizedBox(height: compact ? 14 : 18),
                _DrawerSectionLabel(label: l10n.aiChatHistory),
                Expanded(
                  child: _DrawerHistory(
                    l10n: l10n,
                    threads: threads,
                    activeThreadId: activeThreadId,
                    onOpenThread: (thread) =>
                        closeThen(() => onOpenThread(thread)),
                    onRenameThread: (thread) =>
                        closeThen(() => onRenameThread(thread)),
                    onDeleteThread: (thread) =>
                        closeThen(() => onDeleteThread(thread)),
                  ),
                ),
                SizedBox(height: compact ? 9 : 12),
                _DrawerAction(
                  icon: Iconsax.global,
                  label: l10n.languageTitle,
                  subtitle: currentLanguage.nativeName,
                  onTap: () => closeThen(onLanguage),
                ),
                _DrawerAction(
                  icon: Iconsax.user,
                  label: l10n.navProfile,
                  onTap: () => closeThen(onProfile),
                ),
                _DrawerAction(
                  icon: Iconsax.info_circle,
                  label: l10n.aboutTitle,
                  subtitle: l10n.aboutSubtitle,
                  onTap: () => closeThen(onAbout),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerBrand extends StatelessWidget {
  final AppLocalizations l10n;
  final VoidCallback onSettings;

  const _DrawerBrand({required this.l10n, required this.onSettings});

  @override
  Widget build(BuildContext context) {
    final compact = context.viewportWidth < 390;

    return Row(
      children: <Widget>[
        _BrandAiAvatar(size: compact ? 38 : 42, showOnline: true),
        SizedBox(width: compact ? 10 : 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Dealio',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.45,
                ),
              ),
              Text(
                l10n.aiChatSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onMuted(context),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        _RoundIconButton(
          icon: Iconsax.setting_2,
          tooltip: l10n.profileSettingsPreferences,
          onTap: onSettings,
          size: compact ? 34 : 36,
        ),
      ],
    );
  }
}

class _DrawerSectionLabel extends StatelessWidget {
  final String label;

  const _DrawerSectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.onMuted(context),
          fontWeight: FontWeight.w900,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _DrawerAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool emphasized;
  final VoidCallback onTap;

  const _DrawerAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.subtitle,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    final compact = context.viewportWidth < 390;

    return Padding(
      padding: EdgeInsets.only(bottom: compact ? 5 : 7),
      child: InkWell(
        borderRadius: BorderRadius.circular(compact ? 16 : 18),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 12,
            vertical: compact ? 10 : 12,
          ),
          decoration: BoxDecoration(
            color: emphasized
                ? AppColors.primary.withValues(alpha: 0.16)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(compact ? 16 : 18),
            border: Border.all(
              color: emphasized
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.transparent,
              width: 0.7,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: emphasized
                    ? AppColors.primary
                    : AppColors.onMuted(context),
                size: compact ? 18 : 20,
              ),
              SizedBox(width: compact ? 9 : 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.onSurface(context),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 1),
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.onMuted(context),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerHistory extends StatelessWidget {
  final AppLocalizations l10n;
  final List<AIChatThread> threads;
  final String? activeThreadId;
  final ValueChanged<AIChatThread> onOpenThread;
  final ValueChanged<AIChatThread> onRenameThread;
  final ValueChanged<AIChatThread> onDeleteThread;

  const _DrawerHistory({
    required this.l10n,
    required this.threads,
    required this.activeThreadId,
    required this.onOpenThread,
    required this.onRenameThread,
    required this.onDeleteThread,
  });

  @override
  Widget build(BuildContext context) {
    final compact = context.viewportWidth < 390;
    if (threads.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            l10n.searchHistoryEmpty,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: threads.length,
      separatorBuilder: (_, _) => SizedBox(height: compact ? 5 : 6),
      itemBuilder: (context, index) {
        final thread = threads[index];
        final isActive = thread.id == activeThreadId;
        final preview = thread.lastMessage?.trim();

        return InkWell(
          borderRadius: BorderRadius.circular(17),
          onTap: () => onOpenThread(thread),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 10 : 12,
              vertical: compact ? 9 : 11,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.14)
                  : AppColors.primary.withValues(alpha: 0.055),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: isActive
                    ? AppColors.primary.withValues(alpha: 0.20)
                    : Colors.transparent,
                width: 0.7,
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  isActive ? Iconsax.message_text5 : Iconsax.message_text,
                  color: isActive
                      ? AppColors.primary
                      : AppColors.onMuted(context),
                  size: 17,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        thread.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurface(context),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (preview != null && preview.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          preview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColors.onMuted(context),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
                PopupMenuButton<_ThreadMenuAction>(
                  tooltip: l10n.aiChatRenameChat,
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: AppColors.onMuted(context),
                    size: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: AppColors.adaptiveSurfaceColor(
                    context,
                    darkAlpha: 0.92,
                    lightAlpha: 0.98,
                  ),
                  onSelected: (action) {
                    switch (action) {
                      case _ThreadMenuAction.rename:
                        onRenameThread(thread);
                      case _ThreadMenuAction.delete:
                        onDeleteThread(thread);
                    }
                  },
                  itemBuilder: (context) => <PopupMenuEntry<_ThreadMenuAction>>[
                    PopupMenuItem<_ThreadMenuAction>(
                      value: _ThreadMenuAction.rename,
                      child: Row(
                        children: <Widget>[
                          const Icon(Iconsax.edit_2, size: 17),
                          const SizedBox(width: 10),
                          Text(l10n.aiChatRenameChat),
                        ],
                      ),
                    ),
                    PopupMenuItem<_ThreadMenuAction>(
                      value: _ThreadMenuAction.delete,
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Iconsax.trash,
                            color: AppColors.danger,
                            size: 17,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            l10n.aiChatDeleteChat,
                            style: const TextStyle(color: AppColors.danger),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum _ThreadMenuAction { rename, delete }
