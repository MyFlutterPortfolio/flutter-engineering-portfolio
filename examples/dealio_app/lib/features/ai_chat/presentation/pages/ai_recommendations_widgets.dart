part of 'ai_recommendations_screen.dart';

class _AgentHeader extends StatelessWidget {
  final AppLocalizations l10n;
  final VoidCallback onOpenMenu;
  final VoidCallback onNewChat;
  final VoidCallback onUpgrade;

  const _AgentHeader({
    required this.l10n,
    required this.onOpenMenu,
    required this.onNewChat,
    required this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    final compact = context.viewportWidth < 390;

    return Padding(
      padding: EdgeInsets.fromLTRB(compact ? 13 : 16, 6, compact ? 13 : 16, 4),
      child: Row(
        children: <Widget>[
          _RoundIconButton(
            icon: Icons.menu_rounded,
            tooltip: l10n.aiChatManualActions,
            onTap: onOpenMenu,
            size: compact ? 34 : 36,
          ),
          SizedBox(width: compact ? 8 : 10),
          _BrandAiAvatar(size: compact ? 32 : 34, showOnline: true),
          SizedBox(width: compact ? 8 : 9),
          Expanded(
            child: Text(
              l10n.aiChatTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.onSurface(context),
                fontWeight: FontWeight.w900,
                letterSpacing: -0.42,
              ),
            ),
          ),
          SizedBox(width: compact ? 4 : 6),
          _UpgradePlanButton(l10n: l10n, compact: compact, onTap: onUpgrade),
          SizedBox(width: compact ? 4 : 6),
          _RoundIconButton(
            icon: Iconsax.add,
            tooltip: l10n.aiChatNewChat,
            onTap: onNewChat,
            size: compact ? 34 : 36,
          ),
        ],
      ),
    );
  }
}

class _UpgradePlanButton extends StatelessWidget {
  final AppLocalizations l10n;
  final bool compact;
  final VoidCallback onTap;

  const _UpgradePlanButton({
    required this.l10n,
    required this.compact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: l10n.resultsUpgradePlanTitle,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          height: compact ? 34 : 36,
          padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 11),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.13),
              width: 0.7,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.workspace_premium_rounded,
                color: AppColors.primary,
                size: 16,
              ),
              if (!compact) ...[
                const SizedBox(width: 5),
                Text(
                  l10n.commonUpgrade,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.onSurface(context),
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.05,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AgentEmptyState extends StatelessWidget {
  final AppLocalizations l10n;
  final String userName;

  const _AgentEmptyState({required this.l10n, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const _BrandAiAvatar(size: 54, showOnline: true),
            const SizedBox(height: 18),
            Text(
              l10n.aiChatEmptyTitle(userName),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.onSurface(context),
                fontWeight: FontWeight.w900,
                letterSpacing: -0.35,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.aiChatEmptySubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onMuted(context),
                fontWeight: FontWeight.w700,
                height: 1.38,
              ),
            ),
            const SizedBox(height: 14),
            _EmptyRotatingHint(l10n: l10n),
          ],
        ),
      ),
    );
  }
}

class _EmptyRotatingHint extends StatefulWidget {
  final AppLocalizations l10n;

  const _EmptyRotatingHint({required this.l10n});

  @override
  State<_EmptyRotatingHint> createState() => _EmptyRotatingHintState();
}

class _EmptyRotatingHintState extends State<_EmptyRotatingHint> {
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 2800), (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % _hints.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<String> get _hints => <String>[
    widget.l10n.aiChatEmptyHintCamera,
    widget.l10n.aiChatEmptyHintBudget,
    widget.l10n.aiChatEmptyHintAlert,
  ];

  @override
  Widget build(BuildContext context) {
    return _FrostedSurface(
      borderRadius: 999,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      color: AppColors.adaptiveSurfaceColor(
        context,
        darkAlpha: 0.22,
        lightAlpha: 0.58,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Iconsax.magic_star, color: AppColors.primary, size: 15),
          const SizedBox(width: 7),
          Text(
            widget.l10n.aiChatEmptyHintPrefix,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 240),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: Text(
                _hints[_index],
                key: ValueKey<String>(_hints[_index]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.onMuted(context),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentMessageList extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController scrollController;
  final bool isTyping;
  final Set<int> ratedAssistantMessageIndexes;
  final ValueChanged<_AgentActionType> onAgentAction;
  final ValueChanged<String> onQuickReply;
  final ValueChanged<_AgentProductCandidate> onOpenProduct;
  final ValueChanged<_AgentProductCandidate> onSaveProduct;
  final ValueChanged<_AgentProductCandidate> onTrackProduct;
  final ValueChanged<_AgentProductCandidate> onCompareProduct;
  final VoidCallback onOpenPriceAlert;
  final void Function({required int messageIndex, required bool helpful})
  onFeedback;

  const _AgentMessageList({
    required this.messages,
    required this.scrollController,
    required this.isTyping,
    required this.ratedAssistantMessageIndexes,
    required this.onAgentAction,
    required this.onQuickReply,
    required this.onOpenProduct,
    required this.onSaveProduct,
    required this.onTrackProduct,
    required this.onCompareProduct,
    required this.onOpenPriceAlert,
    required this.onFeedback,
  });

  @override
  Widget build(BuildContext context) {
    final latestAssistantIndex = isTyping ? -1 : _latestAssistantIndex;
    final compact = context.viewportWidth < 390;
    final horizontalPadding = compact ? 13.0 : 18.0;

    return ListView.builder(
      controller: scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        compact ? 10 : 14,
        horizontalPadding,
        compact ? 12 : 14,
      ),
      itemCount: messages.length + (isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _TypingIndicator(),
            ),
          );
        }
        return _ChatMessageView(
          key: ValueKey('message-$index-${messages[index].isAi}'),
          message: messages[index],
          userPrompt: _lastUserPromptBefore(index),
          showAgentActions: index == latestAssistantIndex,
          feedbackGiven: ratedAssistantMessageIndexes.contains(index),
          onAgentAction: onAgentAction,
          onQuickReply: onQuickReply,
          onOpenProduct: onOpenProduct,
          onSaveProduct: onSaveProduct,
          onTrackProduct: onTrackProduct,
          onCompareProduct: onCompareProduct,
          onOpenPriceAlert: onOpenPriceAlert,
          onFeedback: (helpful) =>
              onFeedback(messageIndex: index, helpful: helpful),
        );
      },
    );
  }

  int get _latestAssistantIndex {
    for (var index = messages.length - 1; index >= 0; index -= 1) {
      if (messages[index].isAi) return index;
    }
    return -1;
  }

  String _lastUserPromptBefore(int messageIndex) {
    for (var index = messageIndex - 1; index >= 0; index -= 1) {
      if (!messages[index].isAi) return messages[index].text;
    }
    return '';
  }
}

class _ChatMessageView extends StatelessWidget {
  final ChatMessage message;
  final String userPrompt;
  final bool showAgentActions;
  final bool feedbackGiven;
  final ValueChanged<_AgentActionType> onAgentAction;
  final ValueChanged<String> onQuickReply;
  final ValueChanged<_AgentProductCandidate> onOpenProduct;
  final ValueChanged<_AgentProductCandidate> onSaveProduct;
  final ValueChanged<_AgentProductCandidate> onTrackProduct;
  final ValueChanged<_AgentProductCandidate> onCompareProduct;
  final VoidCallback onOpenPriceAlert;
  final ValueChanged<bool> onFeedback;

  const _ChatMessageView({
    super.key,
    required this.message,
    required this.userPrompt,
    required this.showAgentActions,
    required this.feedbackGiven,
    required this.onAgentAction,
    required this.onQuickReply,
    required this.onOpenProduct,
    required this.onSaveProduct,
    required this.onTrackProduct,
    required this.onCompareProduct,
    required this.onOpenPriceAlert,
    required this.onFeedback,
  });

  @override
  Widget build(BuildContext context) {
    final compact = context.viewportWidth < 390;
    final maxWidth = message.isAi
        ? (context.viewportWidth > 760
              ? 620.0
              : context.viewportWidth * (compact ? 0.92 : 0.88))
        : (context.viewportWidth > 760
              ? 520.0
              : context.viewportWidth * (compact ? 0.78 : 0.74));

    return Padding(
      padding: EdgeInsets.only(bottom: compact ? 15 : 18),
      child: Align(
        alignment: message.isAi ? Alignment.centerLeft : Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: message.isAi
              ? _AssistantMessage(
                  message: message,
                  userPrompt: userPrompt,
                  showAgentActions: showAgentActions,
                  feedbackGiven: feedbackGiven,
                  onAgentAction: onAgentAction,
                  onQuickReply: onQuickReply,
                  onOpenProduct: onOpenProduct,
                  onSaveProduct: onSaveProduct,
                  onTrackProduct: onTrackProduct,
                  onCompareProduct: onCompareProduct,
                  onOpenPriceAlert: onOpenPriceAlert,
                  onFeedback: onFeedback,
                )
              : _UserMessage(message: message),
        ),
      ),
    );
  }
}

class _AssistantMessage extends StatelessWidget {
  final ChatMessage message;
  final String userPrompt;
  final bool showAgentActions;
  final bool feedbackGiven;
  final ValueChanged<_AgentActionType> onAgentAction;
  final ValueChanged<String> onQuickReply;
  final ValueChanged<_AgentProductCandidate> onOpenProduct;
  final ValueChanged<_AgentProductCandidate> onSaveProduct;
  final ValueChanged<_AgentProductCandidate> onTrackProduct;
  final ValueChanged<_AgentProductCandidate> onCompareProduct;
  final VoidCallback onOpenPriceAlert;
  final ValueChanged<bool> onFeedback;

  const _AssistantMessage({
    required this.message,
    required this.userPrompt,
    required this.showAgentActions,
    required this.feedbackGiven,
    required this.onAgentAction,
    required this.onQuickReply,
    required this.onOpenProduct,
    required this.onSaveProduct,
    required this.onTrackProduct,
    required this.onCompareProduct,
    required this.onOpenPriceAlert,
    required this.onFeedback,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final structuredOutput = _AgentStructuredOutput.fromMessage(
      message: message,
      userPrompt: userPrompt,
    );

    return Semantics(
      label: l10n.aiChatAssistantLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SelectableText(
            message.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurface(context),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.48,
              letterSpacing: -0.12,
            ),
          ),
          if (message.sources.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: message.sources
                  .take(4)
                  .map((source) => _SourceChip(source: source))
                  .toList(),
            ),
          ],
          if (showAgentActions && structuredOutput.hasContent) ...[
            const SizedBox(height: 12),
            _AgentStructuredOutputView(
              output: structuredOutput,
              onQuickReply: onQuickReply,
              onOpenProduct: onOpenProduct,
              onSaveProduct: onSaveProduct,
              onTrackProduct: onTrackProduct,
              onCompareProduct: onCompareProduct,
              onOpenPriceAlert: onOpenPriceAlert,
            ),
          ],
          if (showAgentActions) ...[
            const SizedBox(height: 12),
            _AgentActionPanel(
              userPrompt: userPrompt,
              hasSources: message.sources.isNotEmpty,
              feedbackGiven: feedbackGiven,
              onAgentAction: onAgentAction,
              onFeedback: onFeedback,
            ),
          ],
        ],
      ),
    );
  }
}

class _UserMessage extends StatelessWidget {
  final ChatMessage message;

  const _UserMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Semantics(
      label: l10n.aiChatUserLabel,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(
            alpha: AppColors.isDark(context) ? 0.92 : 0.98,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.16),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            height: 1.34,
            letterSpacing: -0.1,
          ),
        ),
      ),
    );
  }
}

class _SourceChip extends StatelessWidget {
  final String source;

  const _SourceChip({required this.source});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.10),
          width: 0.7,
        ),
      ),
      child: Text(
        source,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.05,
        ),
      ),
    );
  }
}

enum _AgentActionType {
  refineNeeds,
  rankResults,
  trackPrice,
  buyingAdvice,
  compareStores,
}

class _AgentActionPanel extends StatelessWidget {
  final String userPrompt;
  final bool hasSources;
  final bool feedbackGiven;
  final ValueChanged<_AgentActionType> onAgentAction;
  final ValueChanged<bool> onFeedback;

  const _AgentActionPanel({
    required this.userPrompt,
    required this.hasSources,
    required this.feedbackGiven,
    required this.onAgentAction,
    required this.onFeedback,
  });

  @override
  Widget build(BuildContext context) {
    final actions = _actionsForPrompt(userPrompt, hasSources: hasSources);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: actions
              .map(
                (action) => _AgentActionChip(
                  action: action,
                  onTap: () => onAgentAction(action),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        _AgentFeedbackStrip(
          feedbackGiven: feedbackGiven,
          onHelpful: () => onFeedback(true),
          onImprove: () => onFeedback(false),
        ),
      ],
    );
  }

  List<_AgentActionType> _actionsForPrompt(
    String prompt, {
    required bool hasSources,
  }) {
    final normalized = prompt.toLowerCase();
    final asksPrice =
        normalized.contains('price') ||
        normalized.contains('narx') ||
        normalized.contains('arzon') ||
        normalized.contains('cheap') ||
        normalized.contains('discount') ||
        normalized.contains('sale') ||
        normalized.contains('alert') ||
        normalized.contains('deal');
    final asksCompare =
        normalized.contains('compare') ||
        normalized.contains('comparison') ||
        normalized.contains('solishtir') ||
        normalized.contains('taqqos') ||
        normalized.contains('store') ||
        normalized.contains('doвЂkon') ||
        normalized.contains("do'kon");
    final asksNeeds =
        normalized.length < 38 ||
        normalized.contains('need') ||
        normalized.contains('ehtiyoj') ||
        normalized.contains('budget') ||
        normalized.contains('budjet') ||
        normalized.contains('recommend') ||
        normalized.contains('maslahat');

    final actions = <_AgentActionType>[];
    void add(_AgentActionType action) {
      if (!actions.contains(action) && actions.length < 4) {
        actions.add(action);
      }
    }

    if (asksNeeds) add(_AgentActionType.refineNeeds);
    if (hasSources || asksCompare) add(_AgentActionType.rankResults);
    if (asksPrice || hasSources) add(_AgentActionType.trackPrice);
    if (asksCompare) add(_AgentActionType.compareStores);
    add(_AgentActionType.buyingAdvice);
    add(_AgentActionType.refineNeeds);
    add(_AgentActionType.rankResults);

    return actions;
  }
}

class _AgentActionChip extends StatelessWidget {
  final _AgentActionType action;
  final VoidCallback onTap;

  const _AgentActionChip({required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final descriptor = _descriptor(l10n);

    return Semantics(
      button: true,
      label: descriptor.label,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.adaptiveSurfaceColor(
              context,
              darkAlpha: 0.26,
              lightAlpha: 0.64,
            ),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: descriptor.accent.withValues(alpha: 0.15),
              width: 0.7,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(descriptor.icon, size: 15, color: descriptor.accent),
              const SizedBox(width: 6),
              Text(
                descriptor.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.04,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _AgentActionDescriptor _descriptor(AppLocalizations l10n) {
    switch (action) {
      case _AgentActionType.refineNeeds:
        return _AgentActionDescriptor(
          label: l10n.aiAgentActionNeeds,
          icon: Iconsax.message_question,
          accent: AppColors.primary,
        );
      case _AgentActionType.rankResults:
        return _AgentActionDescriptor(
          label: l10n.aiAgentActionResults,
          icon: Iconsax.search_status,
          accent: AppColors.primary,
        );
      case _AgentActionType.trackPrice:
        return _AgentActionDescriptor(
          label: l10n.aiAgentActionAlert,
          icon: Iconsax.notification_bing,
          accent: AppColors.success,
        );
      case _AgentActionType.buyingAdvice:
        return _AgentActionDescriptor(
          label: l10n.aiAgentActionAdvice,
          icon: Iconsax.magicpen,
          accent: AppColors.accent,
        );
      case _AgentActionType.compareStores:
        return _AgentActionDescriptor(
          label: l10n.aiAgentActionCompare,
          icon: Iconsax.shop,
          accent: AppColors.primary,
        );
    }
  }
}

class _AgentActionDescriptor {
  final String label;
  final IconData icon;
  final Color accent;

  const _AgentActionDescriptor({
    required this.label,
    required this.icon,
    required this.accent,
  });
}

class _AgentFeedbackStrip extends StatelessWidget {
  final bool feedbackGiven;
  final VoidCallback onHelpful;
  final VoidCallback onImprove;

  const _AgentFeedbackStrip({
    required this.feedbackGiven,
    required this.onHelpful,
    required this.onImprove,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (feedbackGiven) {
      return _AgentFeedbackPill(
        icon: Iconsax.tick_circle,
        label: l10n.aiAgentFeedbackSaved,
        onTap: null,
      );
    }

    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: <Widget>[
        _AgentFeedbackPill(
          icon: Icons.thumb_up_alt_rounded,
          label: l10n.aiAgentFeedbackHelpful,
          onTap: onHelpful,
        ),
        _AgentFeedbackPill(
          icon: Icons.tune_rounded,
          label: l10n.aiAgentFeedbackImprove,
          onTap: onImprove,
        ),
      ],
    );
  }
}

class _AgentFeedbackPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _AgentFeedbackPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.onMuted(context);

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.16,
            lightAlpha: 0.46,
          ),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
            width: 0.6,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: muted),
            const SizedBox(width: 5),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: muted,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatDock extends StatelessWidget {
  final AppLocalizations l10n;
  final TextEditingController controller;
  final bool enabled;
  final bool attachmentsOpen;
  final double bottomPadding;
  final VoidCallback onSend;
  final VoidCallback onToggleAttachments;
  final VoidCallback onBarcode;
  final VoidCallback onImage;

  const _ChatDock({
    required this.l10n,
    required this.controller,
    required this.enabled,
    required this.attachmentsOpen,
    required this.bottomPadding,
    required this.onSend,
    required this.onToggleAttachments,
    required this.onBarcode,
    required this.onImage,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.viewportWidth < 390 ? 12.0 : 16.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        0,
        horizontalPadding,
        bottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: attachmentsOpen
                ? _AttachmentMenu(
                    key: const ValueKey('attachment-menu'),
                    l10n: l10n,
                    onBarcode: onBarcode,
                    onImage: onImage,
                  )
                : const SizedBox.shrink(key: ValueKey('empty-dock-top')),
          ),
          SizedBox(height: attachmentsOpen ? 8 : 0),
          _ChatComposer(
            l10n: l10n,
            controller: controller,
            enabled: enabled,
            attachmentsOpen: attachmentsOpen,
            onSend: onSend,
            onToggleAttachments: onToggleAttachments,
          ),
        ],
      ),
    );
  }
}

class _AttachmentMenu extends StatelessWidget {
  final AppLocalizations l10n;
  final VoidCallback onBarcode;
  final VoidCallback onImage;

  const _AttachmentMenu({
    super.key,
    required this.l10n,
    required this.onBarcode,
    required this.onImage,
  });

  @override
  Widget build(BuildContext context) {
    return _FrostedSurface(
      width: 196,
      borderRadius: 22,
      padding: const EdgeInsets.all(8),
      color: AppColors.adaptiveSurfaceColor(
        context,
        darkAlpha: 0.56,
        lightAlpha: 0.82,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 7),
            child: Text(
              l10n.aiChatAddToChat,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.onMuted(context),
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
          ),
          _AttachmentAction(
            icon: Iconsax.scan_barcode,
            title: l10n.aiChatAttachBarcode,
            onTap: onBarcode,
          ),
          const SizedBox(height: 5),
          _AttachmentAction(
            icon: Iconsax.gallery,
            title: l10n.aiChatAttachImage,
            onTap: onImage,
          ),
        ],
      ),
    );
  }
}

class _AttachmentAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AttachmentAction({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(17),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, color: AppColors.primary, size: 16),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  final AppLocalizations l10n;
  final TextEditingController controller;
  final bool enabled;
  final bool attachmentsOpen;
  final VoidCallback onSend;
  final VoidCallback onToggleAttachments;

  const _ChatComposer({
    required this.l10n,
    required this.controller,
    required this.enabled,
    required this.attachmentsOpen,
    required this.onSend,
    required this.onToggleAttachments,
  });

  @override
  Widget build(BuildContext context) {
    final compact = context.viewportWidth < 390;

    return _FrostedSurface(
      borderRadius: compact ? 28 : 30,
      padding: EdgeInsets.fromLTRB(
        compact ? 6 : 8,
        compact ? 6 : 8,
        compact ? 6 : 8,
        compact ? 6 : 8,
      ),
      color: Colors.white.withValues(
        alpha: AppColors.isDark(context) ? 0.10 : 0.76,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _ComposerPlusButton(
            compact: compact,
            open: attachmentsOpen,
            onTap: onToggleAttachments,
          ),
          SizedBox(width: compact ? 8 : 10),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: compact ? 42 : 44),
              child: TextField(
                controller: controller,
                enabled: enabled,
                minLines: 1,
                maxLines: 4,
                cursorColor: AppColors.primary,
                cursorWidth: 2,
                textInputAction: TextInputAction.send,
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.onSurface(context),
                  fontSize: compact ? 14.5 : 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.12,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: compact ? 10.5 : 11.5,
                  ),
                  hintText: l10n.aiChatInputHint,
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onMuted(context).withValues(alpha: 0.86),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          SizedBox(width: compact ? 8 : 10),
          _SendButton(compact: compact, enabled: enabled, onTap: onSend),
        ],
      ),
    );
  }
}

class _ComposerPlusButton extends StatelessWidget {
  final bool compact;
  final bool open;
  final VoidCallback onTap;

  const _ComposerPlusButton({
    required this.compact,
    required this.open,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: compact ? 38 : 42,
        height: compact ? 38 : 42,
        decoration: BoxDecoration(
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.54,
            lightAlpha: 0.74,
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary.withValues(alpha: open ? 0.24 : 0.10),
            width: 0.8,
          ),
        ),
        child: AnimatedRotation(
          turns: open ? 0.125 : 0,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          child: Icon(
            Icons.add_rounded,
            color: AppColors.onSurface(context),
            size: compact ? 22 : 23,
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool compact;
  final bool enabled;
  final VoidCallback onTap;

  const _SendButton({
    required this.compact,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: compact ? 38 : 42,
        height: compact ? 38 : 42,
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.primary
              : AppColors.onMuted(context).withValues(alpha: 0.18),
          shape: BoxShape.circle,
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 7),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: _SendGlyph(
            color: enabled ? Colors.white : AppColors.onMuted(context),
          ),
        ),
      ),
    );
  }
}

class _SendGlyph extends StatelessWidget {
  final Color color;

  const _SendGlyph({required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(18, 18),
      painter: _SendGlyphPainter(color: color),
    );
  }
}

class _SendGlyphPainter extends CustomPainter {
  final Color color;

  const _SendGlyphPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.1
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.54)
      ..lineTo(size.width * 0.82, size.height * 0.18)
      ..lineTo(size.width * 0.55, size.height * 0.82)
      ..lineTo(size.width * 0.45, size.height * 0.58)
      ..lineTo(size.width * 0.18, size.height * 0.54);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SendGlyphPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _BrandAiAvatar extends StatelessWidget {
  final double size;
  final bool showOnline;

  const _BrandAiAvatar({required this.size, this.showOnline = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: size,
            height: size,
            padding: EdgeInsets.all(size * 0.07),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.adaptiveSurfaceColor(context),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.16),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: size * 0.58,
                  offset: Offset(0, size * 0.18),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/logo/app.png',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Icon(
                  Iconsax.message_question,
                  color: AppColors.primary,
                  size: size * 0.44,
                ),
              ),
            ),
          ),
          if (showOnline)
            Positioned(
              right: -1,
              top: 2,
              child: Container(
                width: size * 0.27,
                height: size * 0.27,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final double size;

  const _RoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
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
          child: Icon(
            icon,
            color: AppColors.onSurface(context),
            size: size <= 34 ? 18 : 20,
          ),
        ),
      ),
    );
  }
}

class _FrostedSurface extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double? width;

  const _FrostedSurface({
    required this.child,
    required this.borderRadius,
    required this.padding,
    this.color,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    final isDark = AppColors.isDark(context);
    final content = Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius,
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.075)
              : Colors.white.withValues(alpha: 0.64),
          width: 0.75,
        ),
        gradient: color == null
            ? LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: isDark ? 0.12 : 0.72),
                  Colors.white.withValues(alpha: isDark ? 0.045 : 0.42),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
      ),
      child: child,
    );

    return ClipRRect(
      borderRadius: radius,
      child: AppFlags.reduceExpensiveVisualEffects
          ? content
          : BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: content,
            ),
    );
  }
}

class _ChatLoadingState extends StatelessWidget {
  const _ChatLoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 34,
        height: 34,
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2.4,
          backgroundColor: AppColors.primary.withValues(alpha: 0.10),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator> {
  Timer? _timer;
  int _step = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 980), (_) {
      if (!mounted) return;
      setState(() => _step = (_step + 1) % 4);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = <String>[
      l10n.aiChatThinkingAnalyzing,
      l10n.aiChatThinkingSearching,
      l10n.aiChatThinkingPricing,
      l10n.aiChatThinkingRanking,
    ];
    final compact = context.viewportWidth < 390;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _BrandAiAvatar(size: compact ? 28 : 30, showOnline: true),
        SizedBox(width: compact ? 8 : 10),
        _FrostedSurface(
          borderRadius: 24,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 11 : 13,
            vertical: compact ? 9 : 10,
          ),
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.38,
            lightAlpha: 0.78,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: compact ? 24 : 26,
                    height: compact ? 24 : 26,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.13),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.search_status,
                      color: AppColors.primary,
                      size: 15,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.viewportWidth * (compact ? 0.52 : 0.58),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: Text(
                        labels[_step],
                        key: ValueKey<String>(labels[_step]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.onSurface(context),
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.06,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Row(
                    children: List<Widget>.generate(3, (index) {
                      return Padding(
                        padding: EdgeInsets.only(right: index == 2 ? 0 : 4),
                        child: _TypingDot(delay: index * 140),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              _ThinkingStepSegments(currentStep: _step, totalSteps: 4),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThinkingStepSegments extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _ThinkingStepSegments({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.viewportWidth < 390 ? 168.0 : 204.0;

    return SizedBox(
      width: width,
      child: Row(
        children: List<Widget>.generate(totalSteps, (index) {
          final isActive = index == currentStep;
          final isDone = index < currentStep;
          final color = isActive || isDone
              ? AppColors.primary
              : AppColors.onMuted(context).withValues(alpha: 0.22);

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 5),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                height: isActive ? 5 : 4,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isActive ? 0.95 : 0.46),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TypingDot extends StatefulWidget {
  final int delay;

  const _TypingDot({required this.delay});

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 760),
    );
    _scale = Tween<double>(begin: 0.58, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
    Future<void>.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isAi;
  final List<String> sources;
  final Map<String, dynamic> metadata;

  const ChatMessage({
    required this.text,
    required this.isAi,
    this.sources = const <String>[],
    this.metadata = const <String, dynamic>{},
  });
}
