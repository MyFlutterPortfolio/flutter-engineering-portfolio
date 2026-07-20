import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/language_picker_sheet.dart';
import 'package:untitled5/core/config/app_flags.dart';
import 'package:untitled5/core/localization/app_language.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/providers/language_provider.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/core/utils/plan_guard.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';
import 'package:untitled5/features/ai_chat/data/repositories/agent_search_repository.dart';
import 'package:untitled5/features/ai_chat/data/repositories/ai_chat_repository.dart';
import 'package:untitled5/features/alerts/domain/entities/alert_entity.dart';
import 'package:untitled5/features/alerts/presentation/providers/alerts_provider.dart';
import 'package:untitled5/features/alerts/presentation/widgets/create_alert_sheet.dart';
import 'package:untitled5/features/alerts/presentation/widgets/manual_link_alert_sheet.dart';
import 'package:untitled5/features/billing/presentation/widgets/paywall_widget.dart';
import 'package:untitled5/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:untitled5/features/profile/presentation/providers/profile_provider.dart';
import 'package:untitled5/features/search/presentation/providers/country_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

part 'ai_recommendations_agent_search.dart';
part 'ai_recommendations_alert_flow.dart';
part 'ai_recommendations_drawer.dart';
part 'ai_recommendations_structured_output.dart';
part 'ai_recommendations_widgets.dart';

class AIRecommendationsScreen extends ConsumerStatefulWidget {
  final String? productId;
  final bool embedded;

  const AIRecommendationsScreen({
    super.key,
    this.productId,
    this.embedded = false,
  });

  @override
  ConsumerState<AIRecommendationsScreen> createState() =>
      _AIRecommendationsScreenState();
}

class _AIRecommendationsScreenState
    extends ConsumerState<AIRecommendationsScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<AIChatThread> _threads = <AIChatThread>[];
  final Set<int> _ratedAssistantMessageIndexes = <int>{};
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Set<String> _threadActionBusyIds = <String>{};
  String? _activeThreadId;
  int _agentSearchRunId = 0;

  bool _isLoadingHistory = true;
  bool _isTyping = false;
  bool _isAgentSearching = false;
  bool _attachmentsOpen = false;

  @override
  void initState() {
    super.initState();
    _bootstrapChat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _bootstrapChat() async {
    try {
      final repository = ref.read(aiChatRepositoryProvider);
      final threads = await repository.getThreads(limit: 30);
      final activeThread = threads.isEmpty ? null : threads.first;
      final history = activeThread == null
          ? const <AIChatHistoryItem>[]
          : await repository.getHistory(limit: 60, threadId: activeThread.id);
      if (!mounted) return;

      final loadedMessages = history
          .map(
            (item) => ChatMessage(
              text: item.text,
              isAi: item.isAi,
              sources: item.sources,
              metadata: item.metadata,
            ),
          )
          .toList();

      setState(() {
        _threads
          ..clear()
          ..addAll(threads);
        _activeThreadId = activeThread?.id;
        _messages
          ..clear()
          ..addAll(loadedMessages);
        _ratedAssistantMessageIndexes.clear();
        _isLoadingHistory = false;
      });
      _scrollToBottom(instant: true);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _messages.clear();
        _isLoadingHistory = false;
      });
    }
  }

  Future<void> _sendMessage([String? text]) async {
    final messageText = (text ?? _controller.text).trim();
    final isBusy = _isTyping || _isAgentSearching;
    if (messageText.isEmpty || isBusy) return;
    final shouldRunAgentSearch = _shouldRunAgentSearch(messageText);
    final agentSearchRunId = ++_agentSearchRunId;

    HapticFeedback.lightImpact();
    setState(() {
      _messages.add(ChatMessage(text: messageText, isAi: false));
      _isTyping = true;
      _isAgentSearching = shouldRunAgentSearch;
      _attachmentsOpen = false;
      if (text == null) {
        _controller.clear();
      }
    });
    _scrollToBottom();

    try {
      final threadId = await _ensureActiveThread(messageText);
      if (shouldRunAgentSearch) {
        unawaited(
          _runAgentSearchForPrompt(
            messageText,
            runId: agentSearchRunId,
            threadId: threadId,
          ),
        );
      }

      final reply = await ref
          .read(aiChatRepositoryProvider)
          .sendMessage(
            message: messageText,
            threadId: threadId,
            productId: widget.productId,
          );
      if (!mounted) return;

      setState(() {
        _activeThreadId ??= reply.threadId;
        _messages.add(
          ChatMessage(
            text: reply.message,
            isAi: true,
            sources: reply.sources,
            metadata: reply.metadata,
          ),
        );
        _isTyping = false;
      });
      unawaited(_refreshThreads());
      _scrollToBottom();
    } catch (_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      setState(() {
        _messages.add(ChatMessage(text: l10n.aiChatErrorReply, isAi: true));
        _isTyping = false;
        _isAgentSearching = false;
      });
      _scrollToBottom();
    }
  }

  void _startNewChat() {
    HapticFeedback.selectionClick();
    setState(() {
      _agentSearchRunId++;
      _messages.clear();
      _ratedAssistantMessageIndexes.clear();
      _activeThreadId = null;
      _attachmentsOpen = false;
      _isTyping = false;
      _isAgentSearching = false;
      _controller.clear();
    });
    _scrollToBottom(instant: true);
  }

  Future<String?> _ensureActiveThread(String firstMessage) async {
    final currentThreadId = _activeThreadId?.trim();
    if (currentThreadId != null && currentThreadId.isNotEmpty) {
      return currentThreadId;
    }

    try {
      final thread = await ref
          .read(aiChatRepositoryProvider)
          .createThread(title: firstMessage, productId: widget.productId);
      if (!mounted) return thread.id;
      setState(() {
        _activeThreadId = thread.id;
        _threads.removeWhere((item) => item.id == thread.id);
        _threads.insert(0, thread);
      });
      return thread.id;
    } catch (_) {
      return null;
    }
  }

  Future<void> _refreshThreads() async {
    try {
      final threads = await ref.read(aiChatRepositoryProvider).getThreads();
      if (!mounted) return;
      setState(() {
        _threads
          ..clear()
          ..addAll(threads);
      });
    } catch (_) {}
  }

  Future<void> _openThread(AIChatThread thread) async {
    final threadId = thread.id.trim();
    if (threadId.isEmpty || threadId == _activeThreadId) return;

    HapticFeedback.selectionClick();
    setState(() {
      _agentSearchRunId++;
      _activeThreadId = threadId;
      _messages.clear();
      _ratedAssistantMessageIndexes.clear();
      _attachmentsOpen = false;
      _isTyping = false;
      _isAgentSearching = false;
      _isLoadingHistory = true;
      _controller.clear();
    });

    try {
      final history = await ref
          .read(aiChatRepositoryProvider)
          .getHistory(limit: 60, threadId: threadId);
      if (!mounted || _activeThreadId != threadId) return;
      setState(() {
        _messages
          ..clear()
          ..addAll(
            history.map(
              (item) => ChatMessage(
                text: item.text,
                isAi: item.isAi,
                sources: item.sources,
                metadata: item.metadata,
              ),
            ),
          );
        _isLoadingHistory = false;
      });
      _scrollToBottom(instant: true);
    } catch (_) {
      if (!mounted || _activeThreadId != threadId) return;
      setState(() => _isLoadingHistory = false);
    }
  }

  Future<void> _renameThread(AIChatThread thread) async {
    final threadId = thread.id.trim();
    if (threadId.isEmpty || _threadActionBusyIds.contains(threadId)) return;
    final failureMessage = AppLocalizations.of(context).aiChatActionFailed;

    final newTitle = await _showRenameThreadDialog(thread);
    final cleanTitle = newTitle?.trim();
    if (cleanTitle == null ||
        cleanTitle.isEmpty ||
        cleanTitle == thread.title.trim()) {
      return;
    }

    setState(() => _threadActionBusyIds.add(threadId));
    try {
      await ref
          .read(aiChatRepositoryProvider)
          .renameThread(threadId: threadId, title: cleanTitle);
      if (!mounted) return;
      setState(() {
        final index = _threads.indexWhere((item) => item.id == threadId);
        if (index >= 0) {
          final current = _threads[index];
          _threads[index] = AIChatThread(
            id: current.id,
            title: cleanTitle,
            lastMessage: current.lastMessage,
            messageCount: current.messageCount,
            updatedAt: current.updatedAt,
            createdAt: current.createdAt,
          );
        }
      });
      unawaited(_refreshThreads());
    } catch (_) {
      if (mounted) _showAgentSnack(failureMessage);
    } finally {
      if (mounted) setState(() => _threadActionBusyIds.remove(threadId));
    }
  }

  Future<void> _deleteThread(AIChatThread thread) async {
    final threadId = thread.id.trim();
    if (threadId.isEmpty || _threadActionBusyIds.contains(threadId)) return;
    final failureMessage = AppLocalizations.of(context).aiChatActionFailed;

    final confirmed = await _showDeleteThreadDialog(thread);
    if (confirmed != true) return;

    setState(() => _threadActionBusyIds.add(threadId));
    try {
      await ref.read(aiChatRepositoryProvider).archiveThread(threadId);
      if (!mounted) return;
      setState(() {
        _threads.removeWhere((item) => item.id == threadId);
        if (_activeThreadId == threadId) {
          _agentSearchRunId++;
          _activeThreadId = null;
          _messages.clear();
          _ratedAssistantMessageIndexes.clear();
          _attachmentsOpen = false;
          _isTyping = false;
          _isAgentSearching = false;
          _controller.clear();
        }
      });
    } catch (_) {
      if (mounted) _showAgentSnack(failureMessage);
    } finally {
      if (mounted) setState(() => _threadActionBusyIds.remove(threadId));
    }
  }

  Future<String?> _showRenameThreadDialog(AIChatThread thread) async {
    final l10n = AppLocalizations.of(context);
    final textController = TextEditingController(text: thread.title);
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 22),
          child: _FrostedSurface(
            borderRadius: 28,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            color: AppColors.adaptiveSurfaceColor(
              dialogContext,
              darkAlpha: 0.82,
              lightAlpha: 0.96,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.aiChatRenameTitle,
                  style: Theme.of(dialogContext).textTheme.titleMedium
                      ?.copyWith(
                        color: AppColors.onSurface(dialogContext),
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: textController,
                  autofocus: true,
                  maxLength: 56,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) =>
                      Navigator.of(dialogContext).pop(textController.text),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: l10n.aiChatRenameHint,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: Text(l10n.commonCancel),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.of(dialogContext).pop(textController.text),
                      child: Text(l10n.aiChatRenameSave),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    textController.dispose();
    return result;
  }

  Future<bool?> _showDeleteThreadDialog(AIChatThread thread) {
    final l10n = AppLocalizations.of(context);
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 22),
          child: _FrostedSurface(
            borderRadius: 28,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            color: AppColors.adaptiveSurfaceColor(
              dialogContext,
              darkAlpha: 0.82,
              lightAlpha: 0.96,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.aiChatDeleteTitle,
                  style: Theme.of(dialogContext).textTheme.titleMedium
                      ?.copyWith(
                        color: AppColors.onSurface(dialogContext),
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.aiChatDeleteBody,
                  style: Theme.of(dialogContext).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onMuted(dialogContext),
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      child: Text(l10n.commonCancel),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.danger,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      child: Text(l10n.aiChatDeleteConfirm),
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

  void _updateAgentSearchState(VoidCallback update) {
    if (!mounted) return;
    setState(update);
  }

  Future<void> _openBarcodeScan() async {
    await _openAttachment(
      route: '/barcode-scan',
      label: AppLocalizations.of(context).aiChatAttachBarcode,
    );
  }

  Future<void> _openImageSearch() async {
    await _openAttachment(
      route: '/image-analysis',
      label: AppLocalizations.of(context).aiChatAttachImage,
    );
  }

  Future<void> _openAttachment({
    required String route,
    required String label,
  }) async {
    HapticFeedback.selectionClick();
    setState(() => _attachmentsOpen = false);
    final result = await context.push<String>(route);
    final value = result?.trim();
    if (!mounted || value == null || value.isEmpty) return;
    await _sendMessage('$label: $value');
  }

  void _toggleAttachments() {
    HapticFeedback.selectionClick();
    setState(() => _attachmentsOpen = !_attachmentsOpen);
  }

  Future<void> _runAgentAction(_AgentActionType action) async {
    final l10n = AppLocalizations.of(context);
    switch (action) {
      case _AgentActionType.refineNeeds:
        await _sendMessage(l10n.aiAgentPromptNeeds);
      case _AgentActionType.rankResults:
        await _sendMessage(l10n.aiAgentPromptResults);
      case _AgentActionType.trackPrice:
        await _openAgentPriceAlertSheet();
      case _AgentActionType.buyingAdvice:
        await _sendMessage(l10n.aiAgentPromptAdvice);
      case _AgentActionType.compareStores:
        await _sendMessage(l10n.aiAgentPromptCompareStores);
    }
  }

  Future<void> _openAgentPriceAlertSheet() async {
    HapticFeedback.selectionClick();
    final planGuard = ref.read(planGuardProvider);
    final kvontMode = planGuard.canUseSuperAlerts;

    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AgentPriceAlertSheet(
        productId: widget.productId,
        kvontMode: kvontMode,
        onAdvancedSetup: () async {
          Navigator.of(context).pop(false);
          await showModalBottomSheet<bool>(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            builder: (_) => ManualLinkAlertSheet(kvontMode: kvontMode),
          );
        },
      ),
    );
    if (!mounted || created != true) return;

    final l10n = AppLocalizations.of(context);
    setState(() {
      _messages.add(
        ChatMessage(text: l10n.aiAgentAlertCreatedMessage, isAi: true),
      );
    });
    _scrollToBottom();
  }

  Future<void> _openStructuredProduct(_AgentProductCandidate product) async {
    HapticFeedback.selectionClick();
    final productId = product.productId;
    if (productId != null) {
      await context.push('/product/${Uri.encodeComponent(productId)}');
      return;
    }
    final link = product.link;
    if (link != null) {
      await launchExternalWebUrl(link);
    }
  }

  Future<void> _saveStructuredProduct(_AgentProductCandidate product) async {
    final productId = product.productId;
    if (productId == null) return;

    HapticFeedback.selectionClick();
    final l10n = AppLocalizations.of(context);
    try {
      await ref
          .read(favoritesRepositoryProvider)
          .addFavorite(product.toProduct());
      ref.invalidate(favoritesProvider);
      ref.invalidate(favoriteIdsProvider);
      _showAgentSnack(l10n.favoritesSaved);
    } catch (_) {
      _showAgentSnack(l10n.favoritesActionFailed);
    }
  }

  Future<void> _trackStructuredProduct(_AgentProductCandidate product) async {
    HapticFeedback.selectionClick();
    final productId = product.productId;
    if (productId == null) {
      await _openAgentPriceAlertSheet();
      return;
    }

    final planGuard = ref.read(planGuardProvider);
    await showModalBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.42),
      isScrollControlled: true,
      builder: (context) => CreateAlertSheet(
        productId: productId,
        initialTitle: product.title,
        currentPrice: product.price,
        priceOffers: product.dynamicPrices,
        kvontMode: planGuard.canUseSuperAlerts,
        countryCode: ref.read(selectedCountryProvider)?.code,
      ),
    );
  }

  Future<void> _compareStructuredProduct(_AgentProductCandidate product) async {
    final productId = product.productId;
    if (productId == null) return;

    HapticFeedback.selectionClick();
    await context.push('/store-comparison/${Uri.encodeComponent(productId)}');
  }

  void _showAgentSnack(String message) {
    final trimmed = message.trim();
    if (trimmed.isEmpty || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(trimmed),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  void _recordAgentFeedback({
    required int messageIndex,
    required bool helpful,
  }) {
    if (_ratedAssistantMessageIndexes.contains(messageIndex)) return;
    if (messageIndex < 0 || messageIndex >= _messages.length) return;

    HapticFeedback.selectionClick();
    setState(() => _ratedAssistantMessageIndexes.add(messageIndex));

    final assistantMessage = _messages[messageIndex];
    unawaited(
      ref
          .read(aiChatRepositoryProvider)
          .submitFeedback(
            assistantMessage: assistantMessage.text,
            userPrompt: _lastUserPromptBefore(messageIndex),
            helpful: helpful,
            sources: assistantMessage.sources,
          ),
    );

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          helpful
              ? AppLocalizations.of(context).aiAgentFeedbackHelpfulThanks
              : AppLocalizations.of(context).aiAgentFeedbackImproveThanks,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  String _lastUserPromptBefore(int messageIndex) {
    for (var index = messageIndex - 1; index >= 0; index -= 1) {
      if (!_messages[index].isAi) return _messages[index].text;
    }
    return '';
  }

  void _goFromDrawer(String path) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_isShellRoute(path)) {
        context.go(path);
        return;
      }
      context.push(path);
    });
  }

  Future<void> _openLanguagePicker() => showLanguagePickerSheet(context);

  bool _isShellRoute(String path) {
    return path == '/home' ||
        path == '/search' ||
        path == '/favorites' ||
        path == '/profile' ||
        path.startsWith('/profile/');
  }

  String _greetingName({
    required String fallback,
    String? firstName,
    String? displayName,
  }) {
    final candidates = <String?>[firstName, displayName];
    for (final candidate in candidates) {
      final value = candidate?.trim();
      if (value == null || value.isEmpty) continue;
      final firstToken = value.split(RegExp(r'\s+')).first.trim();
      if (firstToken.isNotEmpty) return firstToken;
    }
    return fallback;
  }

  void _scrollToBottom({bool instant = false}) {
    Future<void>.delayed(
      instant ? Duration.zero : const Duration(milliseconds: 80),
      () {
        if (!_scrollController.hasClients) return;
        final target = _scrollController.position.maxScrollExtent;
        if (instant) {
          _scrollController.jumpTo(target);
          return;
        }
        _scrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final appLanguage = ref.watch(appLanguageProvider);
    final profile = ref.watch(profileProvider).profile;
    final greetingName = _greetingName(
      fallback: l10n.aiChatEmptyNameFallback,
      firstName: profile?.user.firstName,
      displayName: profile?.user.displayName,
    );
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 12;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawerScrimColor: Colors.black.withValues(alpha: 0.42),
      drawer: _AgentDrawer(
        l10n: l10n,
        threads: _threads,
        activeThreadId: _activeThreadId,
        currentLanguage: appLanguage,
        onNewChat: _startNewChat,
        onOpenThread: _openThread,
        onRenameThread: _renameThread,
        onDeleteThread: _deleteThread,
        onLanguage: _openLanguagePicker,
        onSearch: () => _goFromDrawer('/search'),
        onFavorites: () => _goFromDrawer('/favorites'),
        onAlerts: () => _goFromDrawer('/alerts'),
        onProfile: () => _goFromDrawer('/profile'),
        onAbout: () => _goFromDrawer('/profile/about'),
        onSettings: () => _goFromDrawer('/profile/settings'),
      ),
      body: BlueGlassBackground(
        child: SafeArea(
          bottom: false,
          child: ResponsivePageFrame(
            maxWidth: context.usesNavigationRail ? 820 : null,
            child: Column(
              children: <Widget>[
                Builder(
                  builder: (headerContext) {
                    return _AgentHeader(
                      l10n: l10n,
                      onOpenMenu: () => Scaffold.of(headerContext).openDrawer(),
                      onNewChat: _startNewChat,
                      onUpgrade: () => context.push('/subscription'),
                    );
                  },
                ),
                Expanded(
                  child: _isLoadingHistory
                      ? const _ChatLoadingState()
                      : _messages.isEmpty && !_isTyping && !_isAgentSearching
                      ? _AgentEmptyState(l10n: l10n, userName: greetingName)
                      : _AgentMessageList(
                          messages: _messages,
                          scrollController: _scrollController,
                          isTyping: _isTyping || _isAgentSearching,
                          ratedAssistantMessageIndexes:
                              _ratedAssistantMessageIndexes,
                          onAgentAction: _runAgentAction,
                          onQuickReply: _sendMessage,
                          onOpenProduct: _openStructuredProduct,
                          onSaveProduct: _saveStructuredProduct,
                          onTrackProduct: _trackStructuredProduct,
                          onCompareProduct: _compareStructuredProduct,
                          onOpenPriceAlert: _openAgentPriceAlertSheet,
                          onFeedback: _recordAgentFeedback,
                        ),
                ),
                _ChatDock(
                  l10n: l10n,
                  controller: _controller,
                  enabled: !_isTyping && !_isAgentSearching,
                  attachmentsOpen: _attachmentsOpen,
                  bottomPadding: bottomPadding,
                  onSend: () => _sendMessage(),
                  onToggleAttachments: _toggleAttachments,
                  onBarcode: _openBarcodeScan,
                  onImage: _openImageSearch,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
