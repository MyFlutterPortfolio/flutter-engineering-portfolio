part of 'ai_recommendations_screen.dart';

class _AgentPriceAlertSheet extends ConsumerStatefulWidget {
  final String? productId;
  final bool kvontMode;
  final VoidCallback onAdvancedSetup;

  const _AgentPriceAlertSheet({
    required this.productId,
    required this.kvontMode,
    required this.onAdvancedSetup,
  });

  @override
  ConsumerState<_AgentPriceAlertSheet> createState() =>
      _AgentPriceAlertSheetState();
}

class _AgentPriceAlertSheetState extends ConsumerState<_AgentPriceAlertSheet> {
  final TextEditingController _linkController = TextEditingController();

  RealtimePriceQuoteEntity? _productQuote;
  RealtimePriceQuoteEntity? _linkQuote;
  bool _loadingProductQuote = false;
  bool _checkingLink = false;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final productId = widget.productId?.trim();
    if (productId != null && productId.isNotEmpty) {
      unawaited(_loadProductQuote(productId));
    }
  }

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  bool get _hasSelectedProduct {
    final productId = widget.productId?.trim();
    return productId != null && productId.isNotEmpty;
  }

  bool get _isBusy => _loadingProductQuote || _checkingLink || _saving;

  RealtimePriceQuoteEntity? get _activeQuote => _linkQuote ?? _productQuote;

  Future<void> _loadProductQuote(String productId) async {
    final languageCode = ref.read(appLanguageProvider).code;
    setState(() {
      _loadingProductQuote = true;
      _error = null;
    });

    final quote = await ref
        .read(alertsProvider.notifier)
        .getRealtimeQuote(productId: productId, language: languageCode);

    if (!mounted) return;
    setState(() {
      _productQuote = quote;
      _loadingProductQuote = false;
      _error = quote == null
          ? ref.read(alertsProvider).errorMessage ??
                AppLocalizations.of(context).aiAgentAlertQuoteUnavailable
          : null;
    });
  }

  Future<void> _checkLink() async {
    final link = _normalizedHttpUrl(_linkController.text);
    final l10n = AppLocalizations.of(context);
    if (link == null) {
      setState(() {
        _linkQuote = null;
        _error = l10n.alertSheetCustomStoreInvalid;
      });
      return;
    }

    final languageCode = ref.read(appLanguageProvider).code;
    setState(() {
      _checkingLink = true;
      _error = null;
    });

    final quote = await ref
        .read(alertsProvider.notifier)
        .getManualLinkQuote(
          storeLink: link,
          selectedStore: _hostFromUrl(link),
          language: languageCode,
        );

    if (!mounted) return;
    setState(() {
      _linkQuote = quote;
      _checkingLink = false;
      _error = quote == null
          ? ref.read(alertsProvider).errorMessage ??
                l10n.aiAgentAlertQuoteUnavailable
          : null;
    });
  }

  Future<void> _saveAlert() async {
    var quote = _activeQuote;
    if (quote == null) {
      if (_hasSelectedProduct && _linkController.text.trim().isEmpty) {
        final productId = widget.productId?.trim();
        if (productId != null && productId.isNotEmpty) {
          await _loadProductQuote(productId);
        }
      } else {
        await _checkLink();
      }
      if (!mounted) return;
      quote = _activeQuote;
      if (quote == null) return;
    }

    final l10n = AppLocalizations.of(context);
    final observed = _observedPrice(quote);
    final target = _targetPrice(quote);
    if (observed == null ||
        observed <= 0 ||
        target == null ||
        target >= observed) {
      setState(() => _error = l10n.alertSheetRealtimeUnavailable);
      return;
    }

    final languageCode = ref.read(appLanguageProvider).code;
    final bestOffer = _bestOffer(quote);
    final link = _preferredLink(quote, bestOffer);
    final host = link == null ? quote.storeDomain : _hostFromUrl(link);
    final dropPercent = _dropPercent(quote, observed: observed, target: target);

    setState(() {
      _saving = true;
      _error = null;
    });

    if (_linkQuote != null || !_hasSelectedProduct) {
      final manualLink = link ?? _normalizedHttpUrl(_linkController.text);
      if (manualLink == null) {
        setState(() {
          _saving = false;
          _error = l10n.alertSheetCustomStoreInvalid;
        });
        return;
      }
      await ref
          .read(alertsProvider.notifier)
          .createManualLinkAlert(
            storeLink: manualLink,
            targetPrice: target,
            alertType: AlertType.PRICE_SPECIFIC,
            cooldownMinutes: 60,
            selectedStore: bestOffer?.store ?? host,
            dropPercent: dropPercent,
            currentObservedPrice: observed,
            language: languageCode,
            realtimeMode: true,
            autoBuyArmed: widget.kvontMode ? false : null,
            autoBuyConsent: widget.kvontMode ? false : null,
            checkoutPrepared: widget.kvontMode ? false : null,
          );
    } else {
      final productId = widget.productId?.trim();
      if (productId == null || productId.isEmpty) {
        setState(() {
          _saving = false;
          _error = l10n.aiAgentAlertNeedProduct;
        });
        return;
      }
      await ref
          .read(alertsProvider.notifier)
          .createAlert(
            productId: quote.productId.trim().isNotEmpty
                ? quote.productId.trim()
                : productId,
            targetPrice: target,
            alertType: AlertType.PRICE_SPECIFIC,
            cooldownMinutes: 60,
            selectedStore: bestOffer?.store,
            selectedStoreDomain: host,
            preferredStoreLink: link,
            dropPercent: dropPercent,
            currentObservedPrice: observed,
            language: languageCode,
            realtimeMode: true,
            autoBuyArmed: widget.kvontMode ? false : null,
            autoBuyConsent: widget.kvontMode ? false : null,
            checkoutPrepared: widget.kvontMode ? false : null,
          );
    }

    if (!mounted) return;
    setState(() => _saving = false);

    final error = ref.read(alertsProvider).errorMessage;
    if (error != null && error.trim().isNotEmpty) {
      if (_shouldOpenUpgrade(error)) {
        await PaywallDialog.show(
          context,
          title: l10n.alertManualLimitTitle,
          message: l10n.alertManualLimitMessage,
        );
        if (mounted) ref.read(alertsProvider.notifier).clearError();
        return;
      }
      setState(() => _error = error);
      return;
    }

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  bool _shouldOpenUpgrade(String message) {
    final normalized = message.toLowerCase();
    return normalized.contains('monthly_price_alert_limit_reached') ||
        normalized.contains('price alert limit') ||
        normalized.contains('upgrade');
  }

  RealtimeOfferEntity? _bestOffer(RealtimePriceQuoteEntity quote) {
    final offers = quote.offers.where((offer) => offer.price > 0).toList()
      ..sort((a, b) {
        if (a.availability != b.availability) {
          return a.availability ? -1 : 1;
        }
        return a.price.compareTo(b.price);
      });
    return offers.isEmpty ? null : offers.first;
  }

  double? _observedPrice(RealtimePriceQuoteEntity quote) {
    final bestOffer = _bestOffer(quote);
    final candidates = <double?>[
      quote.currentPrice,
      quote.lowestPrice,
      bestOffer?.price,
    ];
    for (final candidate in candidates) {
      if (candidate != null && candidate > 0) return candidate;
    }
    return null;
  }

  double? _targetPrice(RealtimePriceQuoteEntity quote) {
    final observed = _observedPrice(quote);
    if (observed == null || observed <= 0) return null;

    final recommended = quote.recommendedTargetPrice;
    if (recommended != null && recommended > 0 && recommended < observed) {
      return recommended;
    }

    final suggestedPercent = quote.suggestedDropPercent;
    final dropPercent = suggestedPercent != null && suggestedPercent > 0
        ? suggestedPercent
        : 5;
    final safePercent = dropPercent.clamp(1, 45).toDouble();
    return observed * (1 - safePercent / 100);
  }

  double? _dropPercent(
    RealtimePriceQuoteEntity quote, {
    required double observed,
    required double target,
  }) {
    final suggested = quote.suggestedDropPercent;
    if (suggested != null && suggested > 0) return suggested;
    if (observed <= 0 || target <= 0 || target >= observed) return null;
    return ((observed - target) / observed) * 100;
  }

  String? _preferredLink(
    RealtimePriceQuoteEntity quote,
    RealtimeOfferEntity? bestOffer,
  ) {
    final candidates = <String?>[bestOffer?.link, quote.storeLink];
    for (final candidate in candidates) {
      final normalized = _normalizedHttpUrl(candidate);
      if (normalized != null) return normalized;
    }
    return null;
  }

  String? _normalizedHttpUrl(String? raw) {
    final value = raw?.trim();
    if (value == null || value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || uri.host.trim().isEmpty) return null;
    final scheme = uri.scheme.toLowerCase();
    if (scheme != 'http' && scheme != 'https') return null;
    return uri.toString();
  }

  String? _hostFromUrl(String? raw) {
    final normalized = _normalizedHttpUrl(raw);
    if (normalized == null) return null;
    return Uri.tryParse(normalized)?.host;
  }

  String _priceText(double? value, String currency) {
    if (value == null || value <= 0) {
      return AppLocalizations.of(context).aiAgentAlertPriceUnknown;
    }
    final compact = value >= 100
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(2);
    return '$compact $currency';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final compact = context.viewportWidth < 390;
    final quote = _activeQuote;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(14, 0, 14, 12 + viewInsets.bottom),
        child: _FrostedSurface(
          borderRadius: compact ? 26 : 30,
          padding: EdgeInsets.fromLTRB(
            compact ? 14 : 16,
            10,
            compact ? 14 : 16,
            compact ? 14 : 16,
          ),
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.78,
            lightAlpha: 0.94,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.onMuted(context).withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _AgentAlertHeader(
                  title: l10n.aiAgentAlertTitle,
                  subtitle: l10n.aiAgentAlertSubtitle,
                  onClose: () => Navigator.of(context).pop(false),
                ),
                const SizedBox(height: 14),
                if (_loadingProductQuote)
                  _AgentAlertLoading(message: l10n.aiAgentAlertLoading)
                else if (quote != null)
                  _AgentAlertQuoteCard(
                    quote: quote,
                    observedText: _priceText(
                      _observedPrice(quote),
                      quote.currency,
                    ),
                    targetText: _priceText(_targetPrice(quote), quote.currency),
                    storeText:
                        _bestOffer(quote)?.store ??
                        _hostFromUrl(
                          _preferredLink(quote, _bestOffer(quote)),
                        ) ??
                        l10n.aiAgentAlertAnyStore,
                  )
                else
                  _AgentAlertLinkEntry(
                    controller: _linkController,
                    enabled: !_isBusy,
                    onCheck: _checkLink,
                  ),
                if (_error != null) ...[
                  const SizedBox(height: 10),
                  _AgentAlertError(message: _error!),
                ],
                if (quote != null && _linkQuote == null) ...[
                  const SizedBox(height: 12),
                  _AgentAlertLinkEntry(
                    controller: _linkController,
                    enabled: !_isBusy,
                    compact: true,
                    onCheck: _checkLink,
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _AgentAlertSecondaryButton(
                        label: l10n.aiAgentAlertAdvanced,
                        onTap: _isBusy ? null : widget.onAdvancedSetup,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _AgentAlertPrimaryButton(
                        label: quote == null
                            ? l10n.aiAgentAlertCheckLink
                            : l10n.aiAgentAlertCreate,
                        loading: _checkingLink || _saving,
                        onTap: _isBusy
                            ? null
                            : quote == null
                            ? _checkLink
                            : _saveAlert,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AgentAlertHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onClose;

  const _AgentAlertHeader({
    required this.title,
    required this.subtitle,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BrandAiAvatar(size: 38, showOnline: true),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.35,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onMuted(context),
                  fontWeight: FontWeight.w700,
                  height: 1.28,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onClose,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.adaptiveSurfaceColor(
                context,
                darkAlpha: 0.44,
                lightAlpha: 0.72,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close_rounded,
              color: AppColors.onMuted(context),
              size: 19,
            ),
          ),
        ),
      ],
    );
  }
}

class _AgentAlertLoading extends StatelessWidget {
  final String message;

  const _AgentAlertLoading({required this.message});

  @override
  Widget build(BuildContext context) {
    return _FrostedSurface(
      borderRadius: 20,
      padding: const EdgeInsets.all(12),
      color: AppColors.primary.withValues(alpha: 0.08),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: AppColors.primary,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.onSurface(context),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentAlertQuoteCard extends StatelessWidget {
  final RealtimePriceQuoteEntity quote;
  final String observedText;
  final String targetText;
  final String storeText;

  const _AgentAlertQuoteCard({
    required this.quote,
    required this.observedText,
    required this.targetText,
    required this.storeText,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.075),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.11),
          width: 0.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Iconsax.notification_bing,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  quote.productTitle.trim().isEmpty
                      ? l10n.aiAgentAlertSelectedProduct
                      : quote.productTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.onSurface(context),
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _AgentAlertMetric(
                  label: l10n.aiAgentAlertCurrent,
                  value: observedText,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _AgentAlertMetric(
                  label: l10n.aiAgentAlertTarget,
                  value: targetText,
                  highlighted: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l10n.aiAgentAlertStoreScope(storeText),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentAlertMetric extends StatelessWidget {
  final String label;
  final String value;
  final bool highlighted;

  const _AgentAlertMetric({
    required this.label,
    required this.value,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.primary.withValues(alpha: 0.12)
            : AppColors.adaptiveSurfaceColor(
                context,
                darkAlpha: 0.34,
                lightAlpha: 0.76,
              ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: highlighted
                  ? AppColors.primary
                  : AppColors.onSurface(context),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentAlertLinkEntry extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final bool compact;
  final VoidCallback onCheck;

  const _AgentAlertLinkEntry({
    required this.controller,
    required this.enabled,
    required this.onCheck,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!compact)
          Text(
            l10n.aiAgentAlertPasteLink,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w800,
            ),
          ),
        if (!compact) const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onCheck(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.onSurface(context),
            fontWeight: FontWeight.w800,
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: AppColors.adaptiveSurfaceColor(
              context,
              darkAlpha: 0.38,
              lightAlpha: 0.74,
            ),
            prefixIcon: const Icon(
              Iconsax.link_21,
              color: AppColors.primary,
              size: 18,
            ),
            hintText: l10n.aiAgentAlertLinkHint,
            hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w700,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
                width: 0.7,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
                width: 0.7,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.55),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AgentAlertError extends StatelessWidget {
  final String message;

  const _AgentAlertError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.18),
          width: 0.7,
        ),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Iconsax.warning_2, color: AppColors.error, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.onSurface(context),
                fontWeight: FontWeight.w800,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentAlertPrimaryButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onTap;

  const _AgentAlertPrimaryButton({
    required this.label,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        height: 48,
        decoration: BoxDecoration(
          color: onTap == null
              ? AppColors.onMuted(context).withValues(alpha: 0.18)
              : AppColors.primary,
          borderRadius: BorderRadius.circular(18),
          boxShadow: onTap == null
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.20),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
        ),
      ),
    );
  }
}

class _AgentAlertSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _AgentAlertSecondaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.38,
            lightAlpha: 0.72,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
            width: 0.7,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: onTap == null
                ? AppColors.onMuted(context)
                : AppColors.onSurface(context),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
