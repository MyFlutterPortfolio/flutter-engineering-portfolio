import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/localization/app_language.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/providers/language_provider.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/alerts/domain/entities/alert_entity.dart';
import 'package:untitled5/features/alerts/presentation/providers/alerts_provider.dart';
import 'package:untitled5/features/alerts/presentation/widgets/price_trend_chart.dart';
import 'package:untitled5/features/billing/presentation/widgets/paywall_widget.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class CreateAlertSheet extends ConsumerStatefulWidget {
  final String productId;
  final String initialTitle;
  final double? currentPrice;
  final List<DynamicPrice> priceOffers;
  final bool kvontMode;
  final String? countryCode;

  const CreateAlertSheet({
    super.key,
    required this.productId,
    required this.initialTitle,
    required this.currentPrice,
    required this.priceOffers,
    required this.kvontMode,
    this.countryCode,
  });

  @override
  ConsumerState<CreateAlertSheet> createState() => _CreateAlertSheetState();
}

enum _TargetMode { percent, amount }

class _CreateAlertSheetState extends ConsumerState<CreateAlertSheet> {
  final _cooldownController = TextEditingController(text: '30');
  final _dropPercentController = TextEditingController(text: '2.0');
  final _dropAmountController = TextEditingController(text: '5.0');
  final _customStoreNameController = TextEditingController();
  final _customStoreLinkController = TextEditingController();

  RealtimePriceQuoteEntity? _quote;
  bool _loadingQuote = false;
  bool _saving = false;
  String? _quoteError;

  _TargetMode _targetMode = _TargetMode.percent;
  bool _realtimeMode = true;
  bool _autoBuyArmed = false;
  bool _autoBuyConsent = false;
  bool _checkoutPrepared = false;

  _StoreOption? _selectedStore;
  int _quoteRequestId = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRealtimeQuote();
    });
  }

  @override
  void dispose() {
    _cooldownController.dispose();
    _dropPercentController.dispose();
    _dropAmountController.dispose();
    _customStoreNameController.dispose();
    _customStoreLinkController.dispose();
    super.dispose();
  }

  List<_StoreOption> get _storeOptions {
    final byKey = <String, _StoreOption>{};

    void upsert({
      required String name,
      required String domain,
      required String link,
      required double? price,
    }) {
      if (name.trim().isEmpty) return;
      final key = '${name.toLowerCase().trim()}|${domain.toLowerCase().trim()}';
      final existing = byKey[key];
      if (existing == null) {
        byKey[key] = _StoreOption(
          name: name.trim(),
          domain: domain.trim(),
          link: link.trim(),
          price: price,
        );
        return;
      }

      final bestPrice =
          (price != null && (existing.price == null || price < existing.price!))
          ? price
          : existing.price;
      byKey[key] = _StoreOption(
        name: existing.name,
        domain: existing.domain.isNotEmpty ? existing.domain : domain.trim(),
        link: existing.link.isNotEmpty ? existing.link : link.trim(),
        price: bestPrice,
      );
    }

    for (final offer in widget.priceOffers) {
      upsert(
        name: offer.store,
        domain: _extractDomain(offer.link),
        link: offer.link,
        price: offer.price,
      );
    }

    final quoteOffers = _quote?.offers ?? const <RealtimeOfferEntity>[];
    for (final offer in quoteOffers) {
      upsert(
        name: offer.store,
        domain: _extractDomain(offer.link),
        link: offer.link,
        price: offer.price,
      );
    }

    final list = byKey.values.toList();
    list.sort((a, b) {
      final byPrice = (a.price ?? 999999).compareTo(b.price ?? 999999);
      if (byPrice != 0) return byPrice;
      return a.name.compareTo(b.name);
    });
    return list;
  }

  double? get _fallbackPriceFromOffers {
    if (widget.priceOffers.isEmpty) return null;
    return widget.priceOffers.map((e) => e.price).reduce(math.min);
  }

  double? get _currentObservedPrice {
    final selectedPrice = _selectedStore?.price;
    return _quote?.currentPrice ??
        selectedPrice ??
        widget.currentPrice ??
        _fallbackPriceFromOffers;
  }

  String? get _customStoreLink {
    final raw = _customStoreLinkController.text.trim();
    return raw.isEmpty ? null : raw;
  }

  String? get _customStoreDomain {
    final domain = _extractDomain(_customStoreLink);
    return domain.isEmpty ? null : domain;
  }

  String? get _customStoreName {
    final rawName = _customStoreNameController.text.trim();
    if (rawName.isNotEmpty) return rawName;
    return _customStoreDomain;
  }

  bool get _hasCustomStoreLink => _customStoreLink != null;

  double? get _dropPercent {
    if (_targetMode != _TargetMode.percent) return null;
    return _parsePositive(_dropPercentController.text);
  }

  double? get _dropAmount {
    if (_targetMode != _TargetMode.amount) return null;
    return _parsePositive(_dropAmountController.text);
  }

  double? get _targetPreview {
    final observed = _currentObservedPrice;
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
    final quoteSeries =
        _quote?.trendPoints.map((e) => e.price).where((e) => e > 0).toList() ??
        const <double>[];
    if (quoteSeries.length >= 2) return quoteSeries;

    final offers = widget.priceOffers.map((e) => e.price).toList();
    if (offers.length >= 2) {
      offers.sort();
      return offers;
    }

    final observed = _currentObservedPrice;
    if (observed != null && observed > 0) {
      return <double>[observed * 1.03, observed * 1.015, observed];
    }

    return const <double>[220, 217, 214, 213];
  }

  Future<void> _loadRealtimeQuote() async {
    final requestId = ++_quoteRequestId;
    if (!mounted) return;
    setState(() {
      _loadingQuote = true;
      _quoteError = null;
    });

    final languageCode = ref.read(appLanguageProvider).code;
    final result = await ref
        .read(alertsProvider.notifier)
        .getRealtimeQuote(
          productId: widget.productId,
          selectedStore: _hasCustomStoreLink
              ? _customStoreName
              : _selectedStore?.name,
          selectedStoreDomain: _hasCustomStoreLink
              ? _customStoreDomain
              : _selectedStore?.domain,
          preferredStoreLink: _hasCustomStoreLink ? _customStoreLink : null,
          language: languageCode,
          countryCode: widget.countryCode,
        );

    if (!mounted || requestId != _quoteRequestId) return;

    if (result == null) {
      setState(() {
        _loadingQuote = false;
        _quoteError = ref.read(alertsProvider).errorMessage;
      });
      return;
    }

    final suggestedPercent = result.suggestedDropPercent;
    if (suggestedPercent != null && suggestedPercent > 0) {
      _dropPercentController.text = suggestedPercent.toStringAsFixed(2);
    }
    final suggestedAmount = result.suggestedDropAmount;
    if (suggestedAmount != null && suggestedAmount > 0) {
      _dropAmountController.text = suggestedAmount.toStringAsFixed(2);
    }

    setState(() {
      _quote = result;
      _loadingQuote = false;
      _quoteError = null;
    });
  }

  Future<void> _saveAlert() async {
    final observed = _currentObservedPrice;
    final target = _targetPreview;
    final l10n = AppLocalizations.of(context);
    final customStoreLink = _customStoreLink;
    final customStoreDomain = _customStoreDomain;

    if (customStoreLink != null && customStoreDomain == null) {
      _showMessage(l10n.alertSheetCustomStoreInvalid, isError: true);
      return;
    }

    if (observed == null || observed <= 0) {
      _showMessage(l10n.alertSheetRealtimeUnavailable, isError: true);
      return;
    }
    if (target == null || target <= 0 || target >= observed) {
      _showMessage(l10n.alertSheetTargetInvalid, isError: true);
      return;
    }

    final cooldown = _parseCooldown(_cooldownController.text);
    final languageCode = ref.read(appLanguageProvider).code;

    setState(() => _saving = true);
    await ref
        .read(alertsProvider.notifier)
        .createAlert(
          productId: widget.productId,
          targetPrice: target,
          alertType: AlertType.PRICE_SPECIFIC,
          cooldownMinutes: cooldown,
          selectedStore: customStoreLink != null
              ? _customStoreName
              : _selectedStore?.name,
          selectedStoreDomain: customStoreLink != null
              ? customStoreDomain
              : _selectedStore?.domain,
          preferredStoreLink: customStoreLink ?? _selectedStore?.link,
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
          title: l10n.alertManualLimitTitle,
          message: l10n.alertManualLimitMessage,
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
        content: Text(l10n.alertSheetSaved),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  int _parseCooldown(String input) {
    final value = int.tryParse(input.trim()) ?? 30;
    return value.clamp(5, 1440);
  }

  double? _parsePositive(String input) {
    final raw = input.trim();
    if (raw.isEmpty) return null;
    final normalized = raw.replaceAll(',', '.');
    if (!RegExp(r'^(?:\d+|\d*\.\d+)$').hasMatch(normalized)) {
      return null;
    }
    final value = double.tryParse(normalized);
    if (value == null || value <= 0) return null;
    return value;
  }

  String _extractDomain(String? link) {
    if (link == null || link.trim().isEmpty) return '';
    final uri = Uri.tryParse(link.trim());
    final scheme = (uri?.scheme ?? '').toLowerCase();
    if (scheme != 'http' && scheme != 'https') return '';
    final host = (uri?.host ?? '').trim().toLowerCase();
    if (host.isEmpty) return '';
    return host.startsWith('www.') ? host.substring(4) : host;
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

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.danger : AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool _shouldOpenUpgrade(String message) {
    final normalized = message.toLowerCase();
    return normalized.contains('price alert limit') ||
        normalized.contains('monthly alert quota') ||
        normalized.contains('upgrade');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final observedPrice = _currentObservedPrice;
    final target = _targetPreview;
    final notifierState = ref.watch(alertsProvider);

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
                maxHeight: MediaQuery.sizeOf(context).height * 0.88,
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
                    Text(
                      l10n.alertSheetTitle,
                      style: TextStyle(
                        color: AppColors.onSurface(context),
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.initialTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onMuted(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildRealtimeCard(observedPrice, isDark),
                    const SizedBox(height: 12),
                    _buildStoreSelector(),
                    const SizedBox(height: 12),
                    _buildTrendCard(),
                    const SizedBox(height: 12),
                    _buildTargetConfig(observedPrice, target),
                    const SizedBox(height: 12),
                    _buildAdvancedOptions(),
                    if (_quoteError != null &&
                        _quoteError!.trim().isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        _quoteError!,
                        style: const TextStyle(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    if (notifierState.errorMessage != null &&
                        notifierState.errorMessage!.trim().isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        notifierState.errorMessage!,
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
                        onPressed: (_saving || notifierState.isActionInProgress)
                            ? null
                            : _saveAlert,
                        icon: (_saving || notifierState.isActionInProgress)
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

  Widget _buildRealtimeCard(double? observedPrice, bool isDark) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.07),
          width: 0.6,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.14 : 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Iconsax.flash_1,
              color: AppColors.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.alertSheetRealtimePriceLabel,
                  style: TextStyle(
                    color: AppColors.onMuted(context),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatMoney(observedPrice),
                  style: TextStyle(
                    color: AppColors.onSurface(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _loadingQuote ? null : _loadRealtimeQuote,
            icon: _loadingQuote
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Iconsax.refresh, color: AppColors.primary),
            tooltip: l10n.alertSheetRefreshQuote,
          ),
        ],
      ),
    );
  }

  Widget _buildStoreSelector() {
    final l10n = AppLocalizations.of(context);
    final stores = _storeOptions;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.06),
          width: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.alertSheetStoreTargeting,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<_StoreOption>(
            initialValue: _selectedStore,
            items: [
              DropdownMenuItem<_StoreOption>(
                value: null,
                child: Text(l10n.alertSheetAllStores),
              ),
              ...stores.map(
                (store) => DropdownMenuItem<_StoreOption>(
                  value: store,
                  child: Text(
                    store.price != null
                        ? '${store.name}  (${_formatMoney(store.price)})'
                        : store.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() => _selectedStore = value);
              _loadRealtimeQuote();
            },
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: AppColors.adaptiveCardColor(context, darkAlpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.alertSheetCustomStoreLink,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _customStoreLinkController,
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
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) {
              if (_customStoreDomain != null) {
                _loadRealtimeQuote();
              }
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _customStoreNameController,
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
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                onPressed: _customStoreDomain == null || _loadingQuote
                    ? null
                    : _loadRealtimeQuote,
                icon: _loadingQuote
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Iconsax.refresh, size: 18),
                tooltip: l10n.alertSheetCheckStore,
              ),
            ],
          ),
          if (_customStoreLink != null && _customStoreDomain == null) ...[
            const SizedBox(height: 6),
            Text(
              l10n.alertSheetCustomStoreInvalid,
              style: const TextStyle(
                color: AppColors.danger,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ] else if (_customStoreDomain != null) ...[
            const SizedBox(height: 6),
            Text(
              l10n.alertSheetCustomStoreScope(_customStoreDomain!),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrendCard() {
    final l10n = AppLocalizations.of(context);
    final low = _quote?.lowestPrice;
    final high = _quote?.highestPrice;
    final target = _targetPreview;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.06),
          width: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.alertSheetTrendTitle,
            style: TextStyle(
              color: AppColors.onMuted(context),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          PriceTrendChart(
            points: _trendSeries,
            height: 110,
            lineColor: AppColors.primary,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _statPill(
                l10n.alertSheetStatLow,
                _formatMoney(low),
                AppColors.success,
              ),
              const SizedBox(width: 6),
              _statPill(
                l10n.alertSheetStatHigh,
                _formatMoney(high),
                AppColors.warning,
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

  Widget _buildTargetConfig(double? observedPrice, double? target) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.06),
          width: 0.6,
        ),
      ),
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
                icon: Icon(Iconsax.percentage_square, size: 16),
              ),
              ButtonSegment<_TargetMode>(
                value: _TargetMode.amount,
                label: Text(l10n.alertSheetDropAmount),
                icon: Icon(Iconsax.money_4, size: 16),
              ),
            ],
            selected: <_TargetMode>{_targetMode},
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
              observedPrice == null
                  ? l10n.alertSheetWaitingPrice
                  : l10n.alertSheetCurrentTarget(
                      _formatMoney(target),
                      _formatMoney(observedPrice),
                    ),
              style: TextStyle(
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
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.06),
          width: 0.6,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 12),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
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
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.08),
          width: 0.6,
        ),
      ),
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
          const SizedBox(height: 8),
          SwitchListTile.adaptive(
            value: _autoBuyArmed,
            activeThumbColor: AppColors.accent,
            contentPadding: EdgeInsets.zero,
            title: Text(
              l10n.alertSheetArmAutoBuy,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
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
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
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
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
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

class _StoreOption {
  final String name;
  final String domain;
  final String link;
  final double? price;

  const _StoreOption({
    required this.name,
    required this.domain,
    required this.link,
    required this.price,
  });
}
