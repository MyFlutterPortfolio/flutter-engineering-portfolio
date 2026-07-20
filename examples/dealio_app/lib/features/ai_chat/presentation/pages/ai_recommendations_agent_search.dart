part of 'ai_recommendations_screen.dart';

extension _AgentSearchBridge on _AIRecommendationsScreenState {
  bool _shouldRunAgentSearch(String prompt) {
    final text = prompt.trim().toLowerCase();
    if (text.length < 4) return false;

    final l10n = AppLocalizations.of(context);
    if (prompt == l10n.aiAgentPromptNeeds ||
        prompt == l10n.aiAgentPromptAdvice) {
      return false;
    }

    const intentSignals = <String>[
      'buy',
      'shop',
      'find',
      'search',
      'compare',
      'price',
      'deal',
      'discount',
      'budget',
      'under',
      'iphone',
      'samsung',
      'laptop',
      'phone',
      'camera',
      'headphone',
      'watch',
      'sotib',
      'qidir',
      'top',
      'solishtir',
      'narx',
      'arzon',
      'chegirma',
      'budjet',
      'mahsulot',
      'telefon',
      'noutbuk',
      'kamera',
    ];

    final hasCurrencySymbol =
        text.contains(r'$') || text.contains('€') || text.contains('£');
    return intentSignals.any(text.contains) ||
        hasCurrencySymbol ||
        RegExp(r'\d+\s?(usd|eur|gbp|dollar)').hasMatch(text);
  }

  Future<void> _runAgentSearchForPrompt(
    String prompt, {
    required int runId,
    required String? threadId,
  }) async {
    try {
      final l10n = AppLocalizations.of(context);
      final planGuard = ref.read(planGuardProvider);
      if (!planGuard.canSearch) {
        _appendAgentSearchMessage(
          runId: runId,
          threadId: threadId,
          message: l10n.searchPlanLimitMessage,
          metadata: const <String, dynamic>{},
          sources: const <String>[],
        );
        return;
      }

      final country = await _resolveAgentSearchCountry();
      if (!mounted || runId != _agentSearchRunId) return;
      if (country == null) {
        _appendAgentSearchMessage(
          runId: runId,
          threadId: threadId,
          message: l10n.searchErrorCountryRequired,
          metadata: const <String, dynamic>{},
          sources: const <String>[],
        );
        return;
      }

      final query = _agentSearchQuery(prompt);
      final response = await ref
          .read(agentSearchRepositoryProvider)
          .search(
            AgentSearchRequest(
              query: query,
              countryCode: country.code,
              language: ref.read(appLanguageProvider).code,
              userContext: _agentSearchContext(),
              productId: widget.productId,
            ),
          );

      if (!mounted || runId != _agentSearchRunId) return;
      final message = response.products.isEmpty
          ? l10n.aiAgentSearchNoResults(query)
          : response.summary.trim().isNotEmpty
          ? response.summary.trim()
          : l10n.aiAgentSearchResults(query, response.products.length);

      _appendAgentSearchMessage(
        runId: runId,
        threadId: threadId,
        message: message,
        metadata: response.toChatMetadata(),
        sources: response.sources,
      );
    } catch (_) {
      if (!mounted || runId != _agentSearchRunId) return;
      _appendAgentSearchMessage(
        runId: runId,
        threadId: threadId,
        message: AppLocalizations.of(context).aiAgentSearchFailed,
        metadata: const <String, dynamic>{},
        sources: const <String>[],
      );
    }
  }

  Future<Country?> _resolveAgentSearchCountry() async {
    final selected = ref.read(selectedCountryProvider);
    if (selected != null) return selected;

    try {
      final countries = await ref.read(countriesProvider.future);
      if (countries.isEmpty) return null;
      final country = countries.first;
      ref.read(selectedCountryProvider.notifier).state = country;
      return country;
    } catch (_) {
      return null;
    }
  }

  String _agentSearchQuery(String prompt) {
    final labelSeparator = prompt.indexOf(':');
    if (labelSeparator > 0 && labelSeparator < 32) {
      final value = prompt.substring(labelSeparator + 1).trim();
      if (value.isNotEmpty) return value;
    }
    return prompt.trim();
  }

  String _agentSearchContext() {
    final lines = _messages.reversed
        .take(6)
        .toList()
        .reversed
        .map((message) {
          final role = message.isAi ? 'assistant' : 'user';
          final text = message.text.trim().replaceAll(RegExp(r'\s+'), ' ');
          return '$role: $text';
        })
        .where((line) => line.length > 8)
        .join('\n');
    if (lines.length <= 1200) return lines;
    return lines.substring(lines.length - 1200);
  }

  void _appendAgentSearchMessage({
    required int runId,
    required String? threadId,
    required String message,
    required Map<String, dynamic> metadata,
    required List<String> sources,
  }) {
    if (!mounted || runId != _agentSearchRunId) return;
    _updateAgentSearchState(() {
      _messages.add(
        ChatMessage(
          text: message.trim(),
          isAi: true,
          sources: sources,
          metadata: metadata,
        ),
      );
      _isAgentSearching = false;
    });
    unawaited(
      ref
          .read(aiChatRepositoryProvider)
          .persistAssistantMessage(
            message: message,
            threadId: threadId,
            productId: widget.productId,
            metadata: metadata,
            sources: sources,
          )
          .then((_) => _refreshThreads())
          .catchError((_) {}),
    );
    _scrollToBottom();
  }
}
