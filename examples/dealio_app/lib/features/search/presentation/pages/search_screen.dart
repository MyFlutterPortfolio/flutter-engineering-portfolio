import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/core/common_widgets/agent_back_button.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/localization/app_language.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/core/providers/language_provider.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/core/utils/plan_guard.dart';
import 'package:untitled5/features/billing/presentation/providers/subscription_provider.dart';
import 'package:untitled5/features/billing/presentation/widgets/paywall_widget.dart';
import 'package:untitled5/features/search/presentation/providers/country_provider.dart';
import 'package:untitled5/features/search/presentation/providers/search_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

part 'search_screen_widgets.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  static const Country _fallbackCountry = Country(
    code: 'US',
    name: 'United States',
    gl: 'us',
    hl: 'en',
    location: 'United States',
  );
  static const String _historyKey = 'dealio.search.recent_contexts.v1';
  static const int _historyLimit = 8;

  final _formKey = GlobalKey<FormState>();
  final _queryController = TextEditingController();
  final _needsController = TextEditingController();
  final _budgetController = TextEditingController();
  final _storeSearchController = TextEditingController();
  final _manualStoreController = TextEditingController();
  final _selectedStores = <String>[];
  final _storeDomains = <String, String>{};

  ProviderSubscription<AsyncValue<List<Country>>>? _countriesSub;
  Timer? _storeSearchDebounce;
  List<_SearchContextEntry> _history = const [];
  String _storeLookupQuery = '';
  bool _validate = false;

  AppLocalizations get _l10n => AppLocalizations.of(context);

  @override
  void initState() {
    super.initState();
    _countriesSub = ref.listenManual<AsyncValue<List<Country>>>(
      countriesProvider,
      (_, next) {
        if (ref.read(selectedCountryProvider) != null) return;
        final countries = next.valueOrNull;
        if (countries == null || countries.isEmpty) return;
        ref.read(selectedCountryProvider.notifier).state = countries.first;
      },
      fireImmediately: true,
    );
    unawaited(_loadHistory());
  }

  @override
  void dispose() {
    _countriesSub?.close();
    _storeSearchDebounce?.cancel();
    _queryController.dispose();
    _needsController.dispose();
    _budgetController.dispose();
    _storeSearchController.dispose();
    _manualStoreController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_historyKey) ?? const [];
    final entries = <_SearchContextEntry>[];
    for (final item in raw) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map<String, dynamic>) {
          final entry = _SearchContextEntry.fromJson(decoded);
          if (entry.query.trim().isNotEmpty) entries.add(entry);
        }
      } catch (_) {}
    }
    if (!mounted) return;
    setState(() => _history = entries.take(_historyLimit).toList());
  }

  Future<void> _saveHistory({
    required String query,
    required Country country,
    String? notes,
    double? budget,
    required List<String> stores,
  }) async {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return;

    final entry = _SearchContextEntry(
      query: cleanQuery,
      countryCode: country.code,
      countryName: country.name,
      countryGl: country.gl,
      countryHl: country.hl,
      countryLocation: country.location,
      notes: notes?.trim(),
      budget: budget,
      selectedStores: stores,
      createdAt: DateTime.now(),
    );

    final next = <_SearchContextEntry>[
      entry,
      ..._history.where(
        (old) =>
            old.query.toLowerCase() != cleanQuery.toLowerCase() ||
            old.countryCode.toUpperCase() != country.code.toUpperCase(),
      ),
    ].take(_historyLimit).toList();

    if (mounted) setState(() => _history = next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _historyKey,
      next.map((entry) => jsonEncode(entry.toJson())).toList(),
    );
  }

  void _applyHistory(_SearchContextEntry entry) {
    _queryController.text = entry.query;
    _queryController.selection = TextSelection.collapsed(
      offset: entry.query.length,
    );
    _needsController.text = entry.notes ?? '';
    _budgetController.text = entry.budget == null
        ? ''
        : _formatBudget(entry.budget!);
    ref.read(selectedCountryProvider.notifier).state = entry.country;
    setState(() {
      _selectedStores
        ..clear()
        ..addAll(entry.selectedStores);
      _storeDomains
        ..clear()
        ..addEntries(
          entry.selectedStores
              .where((store) => _normalizeStore(store).contains('.'))
              .map((store) => MapEntry(store, _normalizeStore(store))),
        );
      _storeSearchController.clear();
      _manualStoreController.clear();
      _storeLookupQuery = '';
    });
  }

  void _runSearch() {
    setState(() => _validate = true);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final budget = _parseBudget();
    if (_budgetController.text.trim().isNotEmpty && budget == null) {
      _showSnack(_l10n.searchBudgetInvalid);
      return;
    }

    final planGuard = ref.read(planGuardProvider);
    if (!planGuard.canSearch) {
      _showPaywall();
      return;
    }

    final country = ref.read(selectedCountryProvider);
    if (country == null) {
      _showSnack(_l10n.searchErrorCountryRequired);
      return;
    }

    final selected = _sanitizedSelectedStores();
    final selectedMode =
        planGuard.canUseSelectedStoreSearch && selected.isNotEmpty;
    final notes = _needsController.text.trim();
    final language = ref.read(appLanguageProvider).code;
    final request = SearchRequest(
      query: _queryController.text.trim(),
      country: country.code,
      storeScope: selectedMode ? 'selected' : 'global',
      selectedStores: selectedMode ? selected : null,
      budget: budget,
      notes: notes.isEmpty ? null : notes,
      location: country.location,
      language: language,
    );

    unawaited(
      _saveHistory(
        query: request.query,
        country: country,
        notes: request.notes,
        budget: budget,
        stores: selected,
      ),
    );
    ref.read(searchNotifierProvider.notifier).search(request);
    context.push('/search-results');
  }

  double? _parseBudget() {
    final raw = _budgetController.text.trim();
    if (raw.isEmpty) return null;
    final normalized = raw.replaceAll(',', '.');
    final valid = RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(normalized);
    if (!valid) return null;
    final parsed = double.tryParse(normalized);
    if (parsed == null || parsed <= 0) return null;
    return parsed;
  }

  String _formatBudget(double value) {
    if (value == value.roundToDouble()) return value.toStringAsFixed(0);
    return value.toStringAsFixed(2);
  }

  List<String> _sanitizedSelectedStores() {
    final names = _selectedStores
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty);
    final domains = names
        .map((name) => _normalizeStore(_storeDomains[name] ?? ''))
        .where((item) => item.isNotEmpty);
    return {...names, ...domains}.toList();
  }

  void _toggleStore(Store store, PlanGuard guard) {
    final selected = _selectedStores.contains(store.name);
    if (!selected && _selectedStores.length >= guard.maxSelectedStores) {
      _showSnack(_l10n.searchErrorStoreLimit(guard.maxSelectedStores));
      return;
    }
    setState(() {
      if (selected) {
        _selectedStores.remove(store.name);
        _storeDomains.remove(store.name);
      } else {
        _selectedStores.add(store.name);
        if (store.domains.isNotEmpty) {
          _storeDomains[store.name] = store.domains.first;
        }
      }
    });
  }

  void _addManualStore(PlanGuard guard) {
    final domain = _normalizeStore(_manualStoreController.text);
    if (domain.isEmpty) {
      _showSnack(_l10n.searchErrorEnterStoreDomain);
      return;
    }
    if (_selectedStores.any((store) => store.toLowerCase() == domain) ||
        _storeDomains.values.any((store) => _normalizeStore(store) == domain)) {
      _showSnack(_l10n.searchErrorStoreAlreadySelected);
      return;
    }
    if (_selectedStores.length >= guard.maxSelectedStores) {
      _showSnack(_l10n.searchErrorStoreLimit(guard.maxSelectedStores));
      return;
    }
    setState(() {
      _selectedStores.add(domain);
      _storeDomains[domain] = domain;
      _manualStoreController.clear();
    });
  }

  void _clearStores() {
    setState(() {
      _selectedStores.clear();
      _storeDomains.clear();
      _storeSearchController.clear();
      _manualStoreController.clear();
      _storeLookupQuery = '';
    });
  }

  String _normalizeStore(String raw) {
    final value = raw.trim().toLowerCase();
    if (value.isEmpty) return '';
    final uri = Uri.tryParse(
      value.startsWith('http://') || value.startsWith('https://')
          ? value
          : 'https://$value',
    );
    final host = uri?.host.trim().toLowerCase() ?? value;
    return host.startsWith('www.') ? host.substring(4) : host;
  }

  void _selectCountry(Country country) {
    ref.read(selectedCountryProvider.notifier).state = country;
    _clearStores();
  }

  void _onStoreQueryChanged(String value) {
    final query = value.trim();
    _storeSearchDebounce?.cancel();
    _storeSearchDebounce = Timer(const Duration(milliseconds: 280), () {
      if (!mounted || _storeLookupQuery == query) return;
      setState(() => _storeLookupQuery = query);
    });
  }

  Future<void> _handleBarcode() async {
    if (!ref.read(planGuardProvider).canScanBarcode) {
      _showPaywall();
      return;
    }
    final result = await context.push<String>('/barcode-scan');
    if (result != null && result.trim().isNotEmpty) {
      _setQueryFromTool(result);
    }
  }

  Future<void> _handleImage() async {
    final result = await context.push<String>('/image-analysis');
    if (result != null && result.trim().isNotEmpty) {
      _setQueryFromTool(result);
    }
  }

  void _setQueryFromTool(String value) {
    final query = value.trim();
    _queryController.text = query;
    _queryController.selection = TextSelection.collapsed(offset: query.length);
    FocusScope.of(context).unfocus();
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.danger,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showPaywall() {
    final billing = ref.read(billingStatusProvider).valueOrNull;
    PaywallDialog.show(
      context,
      title: _l10n.searchPlanLimitTitle,
      message: _l10n.searchPlanLimitMessage,
      quota: billing?.quota,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCountry = ref.watch(selectedCountryProvider);
    final billing = ref.watch(billingStatusProvider).valueOrNull;
    final guard = ref.watch(planGuardProvider);
    final selectedMode =
        guard.canUseSelectedStoreSearch && _selectedStores.isNotEmpty;
    final filterSummary = _FilterSummary(
      country: selectedCountry,
      selectedStores: _selectedStores.length,
      selectedMode: selectedMode,
      hasBudget: _budgetController.text.trim().isNotEmpty,
    );
    final pagePadding = AgentUiTokens.screenPadding(context);
    final gap = AgentUiTokens.sectionGap(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlueGlassBackground(
        child: SafeArea(
          child: Form(
            key: _formKey,
            autovalidateMode: _validate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: ResponsivePageFrame(
              maxWidth: context.isCompact ? null : 760,
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  pagePadding,
                  8,
                  pagePadding,
                  context.responsiveBottomPadding,
                ),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  _SearchHeader(billing: billing),
                  SizedBox(height: gap),
                  _PrimarySearchCard(
                    queryController: _queryController,
                    onSubmit: _runSearch,
                    onBarcode: _handleBarcode,
                    onImage: _handleImage,
                  ),
                  SizedBox(height: gap),
                  _AiNeedsInput(controller: _needsController),
                  SizedBox(height: gap),
                  _FilterBar(summary: filterSummary, onTap: _openFiltersSheet),
                  SizedBox(height: gap),
                  _RecentSearches(history: _history, onTap: _applyHistory),
                  const SizedBox(height: 14),
                  _SearchButton(onPressed: _runSearch),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openFiltersSheet() {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Consumer(
          builder: (context, ref, _) {
            final liveCountries = ref.watch(countriesProvider);
            final country = ref.watch(selectedCountryProvider);
            final guard = ref.watch(planGuardProvider);
            final storesAsync = country == null
                ? const AsyncValue.data(<Store>[])
                : ref.watch(
                    availableStoresProvider(
                      StoreLookupParams(
                        countryCode: country.code,
                        query: _storeLookupQuery,
                        limit: 32,
                      ),
                    ),
                  );

            return StatefulBuilder(
              builder: (context, setSheetState) {
                void refreshSheet(VoidCallback action) {
                  action();
                  setSheetState(() {});
                }

                return _SearchFiltersSheet(
                  countriesAsync: liveCountries,
                  selectedCountry: country,
                  storesAsync: storesAsync,
                  budgetController: _budgetController,
                  storeSearchController: _storeSearchController,
                  manualStoreController: _manualStoreController,
                  selectedStores: _selectedStores,
                  guard: guard,
                  onCountryTap: (list) => _openCountryPicker(
                    list.isEmpty ? const [_fallbackCountry] : list,
                    country ?? _fallbackCountry,
                  ),
                  onRetryCountries: () => ref.invalidate(countriesProvider),
                  onFallbackCountry: () =>
                      refreshSheet(() => _selectCountry(_fallbackCountry)),
                  onStoreQueryChanged: (value) =>
                      refreshSheet(() => _onStoreQueryChanged(value)),
                  onStoreTap: (store) =>
                      refreshSheet(() => _toggleStore(store, guard)),
                  onAddManualStore: () =>
                      refreshSheet(() => _addManualStore(guard)),
                  onRemoveStore: (store) => refreshSheet(() {
                    _selectedStores.remove(store);
                    _storeDomains.remove(store);
                  }),
                  onClearStores: () => refreshSheet(_clearStores),
                  onApply: () {
                    setState(() {});
                    Navigator.of(sheetContext).pop();
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _openCountryPicker(List<Country> countries, Country selected) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: _l10n.searchCountryLabel,
      barrierColor: Colors.black.withValues(alpha: 0.18),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (dialogContext, _, _) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: _CountryPickerSheet(
                countries: countries,
                selected: selected,
                onSelect: (country) {
                  Navigator.of(dialogContext).pop();
                  _selectCountry(country);
                },
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
