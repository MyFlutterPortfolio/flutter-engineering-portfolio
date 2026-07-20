import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/localization/app_language.dart';
import 'package:untitled5/core/providers/language_provider.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/alerts/domain/entities/alert_entity.dart';
import 'package:untitled5/features/alerts/presentation/providers/alerts_provider.dart';
import 'package:untitled5/features/alerts/presentation/widgets/price_trend_chart.dart';
import 'package:untitled5/features/billing/presentation/widgets/paywall_widget.dart';

import '../../../../l10n/generated/app_localizations.dart';

enum _TargetMode { percent, amount }

class ManualLinkAlertSheet extends ConsumerStatefulWidget {
  final bool kvontMode;
  final String? countryCode;

  const ManualLinkAlertSheet({
    super.key,
    required this.kvontMode,
    this.countryCode,
  });

  @override
  ConsumerState<ManualLinkAlertSheet> createState() =>
      _ManualLinkAlertSheetState();
}

class _ManualLinkAlertSheetState extends ConsumerState<ManualLinkAlertSheet> {
  final _linkController = TextEditingController();
  final _storeNameController = TextEditingController();
  final _cooldownController = TextEditingController(text: '30');
  final _dropPercentController = TextEditingController(text: '2.0');
  final _dropAmountController = TextEditingController(text: '5.0');

  RealtimePriceQuoteEntity? _quote;
  bool _loadingQuote = false;
  bool _saving = false;
  String? _localError;
  _TargetMode _targetMode = _TargetMode.percent;
  bool _realtimeMode = true;
  bool _autoBuyArmed = false;
  bool _autoBuyConsent = false;
  bool _checkoutPrepared = false;
  int _quoteRequestId = 0;

  @override
  void dispose() {
    _linkController.dispose();
    _storeNameController.dispose();
    _cooldownController.dispose();
    _dropPercentController.dispose();
    _dropAmountController.dispose();
    super.dispose();
  }

  String get _storeLink => _linkController.text.trim();

  String? get _storeName {
    final value = _storeNameController.text.trim();
    if (value.isNotEmpty) return value;
    return _quote?.storeDomain;
  }

  double? get _observedPrice =>
      _quote?.currentPrice ?? _quote?.lowestPrice ?? _bestOffer?.price;

  RealtimeOfferEntity? get _bestOffer {
    final offers = _quote?.offers ?? const <RealtimeOfferEntity>[];
    if (offers.isEmpty) return null;
    final sorted = [...offers]..sort((a, b) => a.price.compareTo(b.price));
    return sorted.first;
  }

  double? get _dropPercent {
    if (_targetMode != _TargetMode.percent) return null;
    return _parsePositive(_dropPercentController.text);
  }

  double? get _dropAmount {
    if (_targetMode != _TargetMode.amount) return null;
    return _parsePositive(_dropAmountController.text);
  }

  double? get _targetPreview {
    final observed = _observedPrice;
    if (observed == null || observed <= 0) {
      return _quote?.recommendedTargetPrice;
    }

    final percent = _dropPercent;
    if (percent != null && percent > 0) {
      return math.max(0.01, observed - (observed * (percent / 100)));
    }

    final amount = _dropAmount;
    if (amount != null && amount > 0) {
      return math.max(0.01, observed - amount);
    }

    return _quote?.recommendedTargetPrice;
  }

  List<double> get _trendSeries {
    final points =
        _quote?.trendPoints.map((e) => e.price).where((e) => e > 0).toList() ??
        const <double>[];
    if (points.length >= 2) return points;

    final observed = _observedPrice;
    if (observed != null && observed > 0) {
      return [observed * 1.03, observed * 1.015, observed];
    }
    return const [220, 217, 214, 213];
  }

  Future<void> _analyzeLink() async {
    final link = _storeLink;
    if (!_isValidHttpUrl(link)) {
      setState(() {
        _localError = AppLocalizations.of(context).alertManualInvalidUrl;
        _quote = null;
      });
      return;
    }

    final requestId = ++_quoteRequestId;
    final languageCode = ref.read(appLanguageProvider).code;
    setState(() {
      _loadingQuote = true;
      _localError = null;
    });

    final quote = await ref
        .read(alertsProvider.notifier)
        .getManualLinkQuote(
          storeLink: link,
          selectedStore: _storeName,
          language: languageCode,
          countryCode: widget.countryCode,
        );

    if (!mounted || requestId != _quoteRequestId) return;

    if (quote == null) {
      setState(() {
        _loadingQuote = false;
        _quote = null;
        _localError = ref.read(alertsProvider).errorMessage;
      });
      return;
    }

    final suggestedPercent = quote.suggestedDropPercent;
    if (suggestedPercent != null && suggestedPercent > 0) {
      _dropPercentController.text = suggestedPercent.toStringAsFixed(2);
    }
    final suggestedAmount = quote.suggestedDropAmount;
    if (suggestedAmount != null && suggestedAmount > 0) {
      _dropAmountController.text = suggestedAmount.toStringAsFixed(2);
    }

    setState(() {
      _quote = quote;
      _loadingQuote = false;
      _localError = null;
    });
  }

  Future<void> _saveAlert() async {
    final quote = _quote;
    if (quote == null) {
      await _analyzeLink();
      if (!mounted || _quote == null) return;
    }

    final observed = _observedPrice;
    final target = _targetPreview;
    if (observed == null || observed <= 0) {
      _showMessage(
        AppLocalizations.of(context).alertManualPriceUnavailable,
        isError: true,
      );
      return;
    }
    if (target == null || target <= 0 || target >= observed) {
      _showMessage(
        AppLocalizations.of(context).alertSheetTargetInvalid,
        isError: true,
      );
      return;
    }

    final languageCode = ref.read(appLanguageProvider).code;
    setState(() => _saving = true);
    await ref
        .read(alertsProvider.notifier)
        .createManualLinkAlert(
          storeLink: _storeLink,
          targetPrice: target,
          alertType: AlertType.PRICE_SPECIFIC,
          cooldownMinutes: _parseCooldown(_cooldownController.text),
          selectedStore: _storeName,
          dropAmount: _dropAmount,
          dropPercent: _dropPercent,
          currentObservedPrice: observed,
          language: languageCode,
          countryCode: widget.countryCode,
          realtimeMode: _realtimeMode,
          autoBuyArmed: widget.kvontMode ? _autoBuyArmed : false,
          autoBuyConsent: widget.kvontMode ? _autoBuyConsent : false,
          checkoutPrepared: widget.kvontMode ? _checkoutPrepared : false,
        );

    if (!mounted) return;
    setState(() => _saving = false);

    final error = ref.read(alertsProvider).errorMessage;
    if (error != null && error.trim().isNotEmpty) {
      if (_shouldOpenUpgrade(error)) {
        await PaywallDialog.show(
          context,
          title: AppLocalizations.of(context).alertManualLimitTitle,
          message: AppLocalizations.of(context).alertManualLimitMessage,
        );
        if (mounted) {
          ref.read(alertsProvider.notifier).clearError();
        }
        return;
      }
      _showMessage(error, isError: true);
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop(true);
    messenger.showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).alertManualCreated),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool _isValidHttpUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    final scheme = (uri?.scheme ?? '').toLowerCase();
    return uri != null &&
        (scheme == 'http' || scheme == 'https') &&
        (uri.host).trim().isNotEmpty;
  }

  int _parseCooldown(String input) {
    final value = int.tryParse(input.trim()) ?? 30;
    return value.clamp(5, 1440);
  }

  double? _parsePositive(String input) {
    final normalized = input.trim().replaceAll(',', '.');
    if (!RegExp(r'^(?:\d+|\d*\.\d+)$').hasMatch(normalized)) {
      return null;
    }
    final value = double.tryParse(normalized);
    if (value == null || value <= 0) return null;
    return value;
  }

  String _formatMoney(double? value, {String? currency}) {
    if (value == null) return '--';
    final code = (currency ?? _quote?.currency ?? 'USD').toUpperCase();
    try {
      return NumberFormat.simpleCurrency(name: code).format(value);
    } catch (_) {
      return '$code ${value.toStringAsFixed(2)}';
    }
  }

  bool _shouldOpenUpgrade(String message) {
    final normalized = message.toLowerCase();
    return normalized.contains('price alert limit') ||
        normalized.contains('monthly alert quota') ||
        normalized.contains('upgrade');
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.danger : AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(alertsProvider);
    final observed = _observedPrice;
    final target = _targetPreview;

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 14,
            right: 14,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 12,
            top: 10,
          ),
          child: GlassContainer(
            borderRadius: 26,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            color: AppColors.adaptiveSurfaceColor(
              context,
              darkAlpha: 0.98,
              lightAlpha: 1,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.9,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 46,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.onMuted(
                            context,
                          ).withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Iconsax.link_1,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.alertManualTitle,
                                style: TextStyle(
                                  color: AppColors.onSurface(context),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 21,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.alertManualSubtitle,
                                style: TextStyle(
                                  color: AppColors.onMuted(context),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildLinkCard(),
                    const SizedBox(height: 12),
                    _buildQuoteCard(observed),
                    const SizedBox(height: 12),
                    _buildTrendCard(target),
                    const SizedBox(height: 12),
                    _buildTargetConfig(observed, target),
                    const SizedBox(height: 12),
                    _buildAdvancedOptions(),
                    if ((_localError ?? state.errorMessage)
                            ?.trim()
                            .isNotEmpty ==
                        true) ...[
                      const SizedBox(height: 12),
                      Text(
                        (_localError ?? state.errorMessage)!,
                        style: const TextStyle(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: (_saving || state.isActionInProgress)
                            ? null
                            : _saveAlert,
                        icon: (_saving || state.isActionInProgress)
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.background,
                                ),
                              )
                            : const Icon(Iconsax.notification, size: 18),
                        label: Text(
                          l10n.alertSheetSaveButton,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.background,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLinkCard() {
    final l10n = AppLocalizations.of(context);
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.alertManualStepLink,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _linkController,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'https://store.com/product-page',
              prefixIcon: const Icon(Iconsax.link_1, size: 18),
              filled: true,
              fillColor: AppColors.adaptiveCardColor(context, darkAlpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (_) => setState(() => _quote = null),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _storeNameController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: l10n.alertSheetStoreNameOptional,
                    prefixIcon: const Icon(Iconsax.shop, size: 18),
                    filled: true,
                    fillColor: AppColors.adaptiveCardColor(
                      context,
                      darkAlpha: 0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _loadingQuote ? null : _analyzeLink,
                icon: _loadingQuote
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.background,
                        ),
                      )
                    : const Icon(Iconsax.flash_1, size: 18),
                tooltip: l10n.alertManualAnalyzeLink,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.alertManualSecurityNote,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(double? observed) {
    final l10n = AppLocalizations.of(context);
    final quote = _quote;
    return _CardShell(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Iconsax.money_4,
              color: AppColors.success,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote == null
                      ? l10n.alertManualWaitingAnalysis
                      : quote.productTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.onSurface(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  quote == null
                      ? l10n.alertManualAnalyzeForPrice
                      : l10n.alertManualQuoteConfidence(
                          quote.storeDomain ??
                              _bestOffer?.store ??
                              l10n.alertManualStoreFallback,
                          (quote.confidence ?? 0).toStringAsFixed(2),
                        ),
                  style: TextStyle(
                    color: AppColors.onMuted(context),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatMoney(observed),
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendCard(double? target) {
    final l10n = AppLocalizations.of(context);
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.alertManualStepSignal,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          PriceTrendChart(
            points: _trendSeries,
            height: 104,
            lineColor: AppColors.primary,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _statPill(
                l10n.alertSheetStatNow,
                _formatMoney(_observedPrice),
                AppColors.info,
              ),
              const SizedBox(width: 6),
              _statPill(
                l10n.alertSheetStatLow,
                _formatMoney(_quote?.lowestPrice),
                AppColors.success,
              ),
              const SizedBox(width: 6),
              _statPill(
                l10n.alertSheetStatTarget,
                _formatMoney(target),
                AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetConfig(double? observed, double? target) {
    final l10n = AppLocalizations.of(context);
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.alertSheetTriggerSetup,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          SegmentedButton<_TargetMode>(
            segments: [
              ButtonSegment<_TargetMode>(
                value: _TargetMode.percent,
                label: Text(l10n.alertSheetDropPercent),
                icon: const Icon(Iconsax.percentage_square, size: 16),
              ),
              ButtonSegment<_TargetMode>(
                value: _TargetMode.amount,
                label: Text(l10n.alertSheetDropAmount),
                icon: const Icon(Iconsax.money_4, size: 16),
              ),
            ],
            selected: {_targetMode},
            onSelectionChanged: (selection) {
              if (selection.isEmpty) return;
              setState(() => _targetMode = selection.first);
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _dropPercentController,
                  enabled: _targetMode == _TargetMode.percent,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l10n.alertSheetDropPercent,
                    filled: true,
                    fillColor: AppColors.adaptiveCardColor(
                      context,
                      darkAlpha: 0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _dropAmountController,
                  enabled: _targetMode == _TargetMode.amount,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l10n.alertSheetDropAmount,
                    filled: true,
                    fillColor: AppColors.adaptiveCardColor(
                      context,
                      darkAlpha: 0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              observed == null
                  ? l10n.alertManualAnalyzeTargetHint
                  : l10n.alertSheetCurrentTarget(
                      _formatMoney(target),
                      _formatMoney(observed),
                    ),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile.adaptive(
            value: _realtimeMode,
            activeThumbColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
            title: Text(
              l10n.alertSheetRealtimeMonitoring,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
            subtitle: Text(
              l10n.alertSheetRealtimeMonitoringSubtitle,
              style: TextStyle(fontSize: 12, color: AppColors.onMuted(context)),
            ),
            onChanged: (value) => setState(() => _realtimeMode = value),
          ),
        ],
      ),
    );
  }

  Widget _buildCooldownField() {
    final l10n = AppLocalizations.of(context);
    return TextField(
      controller: _cooldownController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: l10n.alertSheetCooldownLabel,
        helperText: l10n.alertSheetCooldownHelper,
        helperStyle: TextStyle(color: AppColors.onMuted(context)),
        filled: true,
        fillColor: AppColors.adaptiveCardColor(context, darkAlpha: 0.65),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildAdvancedOptions() {
    final l10n = AppLocalizations.of(context);
    return _CardShell(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(top: 8),
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.onMuted(context),
          title: Text(
            l10n.alertSheetAdvancedOptions,
            style: TextStyle(
              color: AppColors.onSurface(context),
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
          subtitle: Text(
            l10n.alertSheetAdvancedSubtitle,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          children: [
            _buildCooldownField(),
            if (widget.kvontMode) ...[
              const SizedBox(height: 12),
              _buildKvontToggles(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildKvontToggles() {
    final l10n = AppLocalizations.of(context);
    return _CardShell(
      accent: AppColors.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.alertSheetKvontTitle,
            style: TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.alertSheetKvontSubtitle,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          SwitchListTile.adaptive(
            value: _autoBuyArmed,
            activeThumbColor: AppColors.accent,
            contentPadding: EdgeInsets.zero,
            title: Text(
              l10n.alertSheetArmAutoBuy,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
            onChanged: (value) {
              setState(() {
                _autoBuyArmed = value;
                if (!value) {
                  _autoBuyConsent = false;
                  _checkoutPrepared = false;
                }
              });
            },
          ),
          SwitchListTile.adaptive(
            value: _autoBuyConsent,
            activeThumbColor: AppColors.accent,
            contentPadding: EdgeInsets.zero,
            title: Text(
              l10n.alertSheetUserConsent,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            onChanged: _autoBuyArmed
                ? (value) => setState(() => _autoBuyConsent = value)
                : null,
          ),
          SwitchListTile.adaptive(
            value: _checkoutPrepared,
            activeThumbColor: AppColors.accent,
            contentPadding: EdgeInsets.zero,
            title: Text(
              l10n.alertSheetCheckoutPrepared,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            onChanged: _autoBuyArmed
                ? (value) => setState(() => _checkoutPrepared = value)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _statPill(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.1), width: 0.6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.onSurface(context),
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget child;
  final Color accent;

  const _CardShell({required this.child, this.accent = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.07), width: 0.6),
      ),
      child: child,
    );
  }
}
