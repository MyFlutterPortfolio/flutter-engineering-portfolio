part of 'search_screen.dart';

class _SearchHeader extends StatelessWidget {
  final BillingStatusResponse? billing;

  const _SearchHeader({required this.billing});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final plan = _planName(billing?.subscription.plan, l10n);
    final quota = billing?.quota.search;
    final quotaText = quota == null || quota.limit > 900000
        ? l10n.searchQuotaUnlimitedCompact(plan)
        : l10n.searchQuotaCompact(plan, quota.remaining);

    final titleStyle = Theme.of(context).textTheme.headlineMedium;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AgentBackButton(),
        const SizedBox(width: 9),
        _LogoMark(size: 36),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.searchHeaderTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: titleStyle?.copyWith(
                  color: AppColors.onSurface(context),
                  fontSize: AgentUiTokens.headerTitleSize(context),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.45,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                quotaText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrimarySearchCard extends StatelessWidget {
  final TextEditingController queryController;
  final VoidCallback onSubmit;
  final VoidCallback onBarcode;
  final VoidCallback onImage;

  const _PrimarySearchCard({
    required this.queryController,
    required this.onSubmit,
    required this.onBarcode,
    required this.onImage,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GlassContainer(
      borderRadius: AgentUiTokens.largeRadius(context),
      padding: EdgeInsets.symmetric(
        horizontal: AgentUiTokens.cardPadding(context),
        vertical: 12,
      ),
      color: AppColors.adaptiveCardColor(
        context,
        darkAlpha: 0.7,
        lightAlpha: 0.96,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 70),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.adaptiveSurfaceColor(
                  context,
                  darkAlpha: 0.62,
                  lightAlpha: 0.86,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.search_normal_1,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.searchInputLabel.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.onMuted(context),
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: queryController,
                    onFieldSubmitted: (_) => onSubmit(),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? l10n.searchValidationQueryRequired
                        : null,
                    maxLines: 1,
                    cursorColor: AppColors.primary,
                    cursorWidth: 2,
                    cursorHeight: 21,
                    textInputAction: TextInputAction.search,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.onSurface(context),
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      height: 1.12,
                    ),
                    decoration: _plainInputDecoration(
                      context,
                      hintText: l10n.searchQueryHint,
                      hintStyle: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(
                            color: AppColors.onMuted(
                              context,
                            ).withValues(alpha: 0.68),
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _SearchFieldActions(onBarcode: onBarcode, onImage: onImage),
          ],
        ),
      ),
    );
  }
}

class _SearchFieldActions extends StatelessWidget {
  final VoidCallback onBarcode;
  final VoidCallback onImage;

  const _SearchFieldActions({required this.onBarcode, required this.onImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _IconAction(icon: Iconsax.scan_barcode, onTap: onBarcode),
        const SizedBox(width: 6),
        _IconAction(icon: Iconsax.gallery, onTap: onImage),
      ],
    );
  }
}

class _AiNeedsInput extends StatefulWidget {
  final TextEditingController controller;

  const _AiNeedsInput({required this.controller});

  @override
  State<_AiNeedsInput> createState() => _AiNeedsInputState();
}

class _AiNeedsInputState extends State<_AiNeedsInput>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _addNeed(String value) {
    final current = widget.controller.text.trim();
    final next = current.isEmpty ? value : '$current, $value';
    widget.controller.text = next;
    widget.controller.selection = TextSelection.collapsed(offset: next.length);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final glow = 0.08 + (_pulse.value * 0.1);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AgentUiTokens.largeRadius(context),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: glow),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: GlassContainer(
            borderRadius: AgentUiTokens.largeRadius(context),
            padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
            color: AppColors.adaptiveCardColor(
              context,
              darkAlpha: 0.64,
              lightAlpha: 0.94,
            ),
            child: child!,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _LogoMark(size: 34),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.searchAiNeedsTitle,
                      style: TextStyle(
                        color: AppColors.onSurface(context),
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.searchAiNeedsSubtitle,
                      style: TextStyle(
                        color: AppColors.onMuted(context),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Container(
            constraints: const BoxConstraints(minHeight: 116),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: AppColors.adaptiveSurfaceColor(
                context,
                darkAlpha: 0.44,
                lightAlpha: 0.8,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextField(
              controller: widget.controller,
              minLines: 3,
              maxLines: 5,
              cursorColor: AppColors.primary,
              cursorWidth: 2,
              cursorHeight: 24,
              textInputAction: TextInputAction.newline,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.onSurface(context),
                fontWeight: FontWeight.w700,
                fontSize: 14.5,
                height: 1.35,
                letterSpacing: -0.15,
              ),
              decoration: _plainInputDecoration(
                context,
                hintText: l10n.searchAiNeedsHint,
                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.onMuted(context).withValues(alpha: 0.72),
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  height: 1.35,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _NeedChips(onTap: _addNeed),
        ],
      ),
    );
  }
}

class _NeedChips extends StatelessWidget {
  final ValueChanged<String> onTap;

  const _NeedChips({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final chips = [
      l10n.searchNeedChipCamera,
      l10n.searchNeedChipBattery,
      l10n.searchNeedChipBudget,
      l10n.searchNeedChipDurable,
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips
          .map(
            (label) => InkWell(
              onTap: () => onTap(label),
              borderRadius: BorderRadius.circular(999),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _FilterSummary {
  final Country? country;
  final int selectedStores;
  final bool selectedMode;
  final bool hasBudget;

  const _FilterSummary({
    required this.country,
    required this.selectedStores,
    required this.selectedMode,
    required this.hasBudget,
  });
}

class _FilterBar extends StatelessWidget {
  final _FilterSummary summary;
  final VoidCallback onTap;

  const _FilterBar({required this.summary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final storeLabel = summary.selectedMode
        ? l10n.searchSelectedScope(summary.selectedStores)
        : l10n.searchGlobalScope;

    return GlassContainer(
      borderRadius: AgentUiTokens.cardRadius(context),
      padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
      color: AppColors.adaptiveCardColor(
        context,
        darkAlpha: 0.58,
        lightAlpha: 0.93,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.searchFiltersTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onSurface(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onTap,
                icon: const Icon(Iconsax.setting_4, size: 16),
                label: Text(l10n.searchFiltersButton),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  textStyle: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _FilterPill(
                icon: Iconsax.global,
                label: summary.country?.name ?? l10n.searchCountryFallback,
                onTap: onTap,
              ),
              _FilterPill(
                icon: Iconsax.wallet_3,
                label: summary.hasBudget
                    ? l10n.searchBudgetActive
                    : l10n.searchBudgetLabel,
                onTap: onTap,
              ),
              _FilterPill(icon: Iconsax.shop, label: storeLabel, onTap: onTap),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FilterPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 42,
        constraints: const BoxConstraints(maxWidth: 190),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.adaptiveCardColor(
            context,
            darkAlpha: 0.58,
            lightAlpha: 0.96,
          ),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
            width: 0.55,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: 15),
            const SizedBox(width: 7),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.onSurface(context),
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentSearches extends StatelessWidget {
  final List<_SearchContextEntry> history;
  final ValueChanged<_SearchContextEntry> onTap;

  const _RecentSearches({required this.history, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.searchRecentTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.onSurface(context),
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        if (history.isEmpty)
          _MiniNotice(icon: Iconsax.clock, text: l10n.searchHistoryEmpty)
        else
          Column(
            children: history.take(5).map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _RecentSearchChip(entry: item, onTap: () => onTap(item)),
              );
            }).toList(),
          ),
      ],
    );
  }
}

class _RecentSearchChip extends StatelessWidget {
  final _SearchContextEntry entry;
  final VoidCallback onTap;

  const _RecentSearchChip({required this.entry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 62),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: AppColors.adaptiveCardColor(
            context,
            darkAlpha: 0.58,
            lightAlpha: 0.96,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
            width: 0.55,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    entry.query,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.onSurface(context),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.metaLabel(l10n),
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
            const SizedBox(width: 10),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.arrow_right_3,
                color: AppColors.primary,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SearchButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Iconsax.search_normal_1, size: 18),
        label: Text(
          l10n.searchButtonLabel,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
        ),
        style: _primaryButtonStyle(context),
      ),
    );
  }
}

class _SearchFiltersSheet extends StatelessWidget {
  final AsyncValue<List<Country>> countriesAsync;
  final Country? selectedCountry;
  final AsyncValue<List<Store>> storesAsync;
  final TextEditingController budgetController;
  final TextEditingController storeSearchController;
  final TextEditingController manualStoreController;
  final List<String> selectedStores;
  final PlanGuard guard;
  final ValueChanged<List<Country>> onCountryTap;
  final VoidCallback onRetryCountries;
  final VoidCallback onFallbackCountry;
  final ValueChanged<String> onStoreQueryChanged;
  final ValueChanged<Store> onStoreTap;
  final VoidCallback onAddManualStore;
  final ValueChanged<String> onRemoveStore;
  final VoidCallback onClearStores;
  final VoidCallback onApply;

  const _SearchFiltersSheet({
    required this.countriesAsync,
    required this.selectedCountry,
    required this.storesAsync,
    required this.budgetController,
    required this.storeSearchController,
    required this.manualStoreController,
    required this.selectedStores,
    required this.guard,
    required this.onCountryTap,
    required this.onRetryCountries,
    required this.onFallbackCountry,
    required this.onStoreQueryChanged,
    required this.onStoreTap,
    required this.onAddManualStore,
    required this.onRemoveStore,
    required this.onClearStores,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.48,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.adaptiveSurfaceColor(
              context,
              darkAlpha: 0.98,
              lightAlpha: 1,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
              width: 0.6,
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.onMuted(context).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _SectionTitle(
                        title: l10n.searchFiltersTitle,
                        subtitle: l10n.searchFiltersSubtitle,
                      ),
                    ),
                    IconButton(
                      onPressed: onApply,
                      icon: const Icon(Iconsax.close_circle),
                      color: AppColors.onMuted(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _Label(l10n.searchCountryLabel),
                const SizedBox(height: 7),
                countriesAsync.when(
                  data: (countries) => _CountryButton(
                    country: selectedCountry,
                    onTap: () => onCountryTap(countries),
                  ),
                  loading: _LoadingLine.new,
                  error: (_, _) => _FallbackCountryRow(
                    onRetry: onRetryCountries,
                    onUseFallback: onFallbackCountry,
                  ),
                ),
                const SizedBox(height: 12),
                _Label(l10n.searchBudgetLabel),
                const SizedBox(height: 7),
                TextField(
                  controller: budgetController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: _inputDecoration(
                    context,
                    hint: l10n.searchBudgetHint,
                    prefixIcon: Iconsax.wallet_3,
                  ),
                ),
                const SizedBox(height: 14),
                _SectionTitle(
                  title: l10n.searchAdvancedTitle,
                  subtitle: l10n.searchStoresLabel,
                ),
                const SizedBox(height: 10),
                if (!guard.canUseSelectedStoreSearch)
                  _MiniNotice(icon: Iconsax.shop, text: l10n.searchFreeModeHint)
                else ...[
                  _SelectedStoreChips(
                    stores: selectedStores,
                    onRemove: onRemoveStore,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: manualStoreController,
                          decoration: _inputDecoration(
                            context,
                            hint: l10n.searchManualStoreHint,
                            prefixIcon: Iconsax.link,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      _SquareButton(icon: Iconsax.add, onTap: onAddManualStore),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: storeSearchController,
                    onChanged: onStoreQueryChanged,
                    decoration: _inputDecoration(
                      context,
                      hint: l10n.searchStoreSearchHint,
                      prefixIcon: Iconsax.search_normal_1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  storesAsync.when(
                    data: (stores) => _StoreList(
                      stores: stores,
                      selectedStores: selectedStores,
                      onTap: onStoreTap,
                    ),
                    loading: _LoadingLine.new,
                    error: (_, _) => _MiniNotice(
                      icon: Iconsax.warning_2,
                      text: l10n.searchStoresLoadFailed,
                      danger: true,
                    ),
                  ),
                  if (selectedStores.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: onClearStores,
                        icon: const Icon(Iconsax.trash, size: 16),
                        label: Text(l10n.searchFiltersClearStores),
                      ),
                    ),
                  ],
                ],
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onApply,
                    style: _primaryButtonStyle(context),
                    child: Text(
                      l10n.searchFiltersApply,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CountryButton extends StatelessWidget {
  final Country? country;
  final VoidCallback onTap;

  const _CountryButton({required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: _fieldBox(context),
        child: Row(
          children: [
            const Icon(Iconsax.global, color: AppColors.primary, size: 17),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                country?.name ?? l10n.searchCountryFallback,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              country?.code ?? '--',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Iconsax.arrow_down_1,
              color: AppColors.onMuted(context),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreList extends StatelessWidget {
  final List<Store> stores;
  final List<String> selectedStores;
  final ValueChanged<Store> onTap;

  const _StoreList({
    required this.stores,
    required this.selectedStores,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (stores.isEmpty) {
      return _MiniNotice(icon: Iconsax.shop, text: l10n.searchStoresEmpty);
    }

    return Column(
      children: stores.take(12).map((store) {
        final selected = selectedStores.contains(store.name);
        return _StoreRow(
          store: store,
          selected: selected,
          onTap: () => onTap(store),
        );
      }).toList(),
    );
  }
}

class _StoreRow extends StatelessWidget {
  final Store store;
  final bool selected;
  final VoidCallback onTap;

  const _StoreRow({
    required this.store,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final domain = store.domains.isEmpty
        ? store.countryCode
        : store.domains.first;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.14)
                : AppColors.adaptiveCardColor(context, darkAlpha: 0.48),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.18)
                  : AppColors.adaptiveBorderColor(AppColors.isDark(context)),
              width: 0.6,
            ),
          ),
          child: Row(
            children: [
              _RoundIcon(icon: Iconsax.shop),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onSurface(context),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      domain,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onMuted(context),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.add_circle_outline_rounded,
                color: selected
                    ? AppColors.primary
                    : AppColors.onMuted(context),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountryPickerSheet extends StatelessWidget {
  final List<Country> countries;
  final Country selected;
  final ValueChanged<Country> onSelect;

  const _CountryPickerSheet({
    required this.countries,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Material(
      color: AppColors.adaptiveSurfaceColor(
        context,
        darkAlpha: 0.98,
        lightAlpha: 1,
      ),
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(
              title: l10n.searchCountryLabel,
              subtitle: l10n.searchFiltersSubtitle,
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 380),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final countryCode = country.code.trim().toUpperCase();
                  final isSelected =
                      countryCode == selected.code.trim().toUpperCase();
                  return _CountryOption(
                    country: country,
                    code: countryCode.isEmpty ? '--' : countryCode,
                    selected: isSelected,
                    onTap: () => onSelect(country),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryOption extends StatelessWidget {
  final Country country;
  final String code;
  final bool selected;
  final VoidCallback onTap;

  const _CountryOption({
    required this.country,
    required this.code,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.14)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              _CodeBadge(code),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  country.name.trim().isEmpty ? code : country.name.trim(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.onSurface(context),
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedStoreChips extends StatelessWidget {
  final List<String> stores;
  final ValueChanged<String> onRemove;

  const _SelectedStoreChips({required this.stores, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    if (stores.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: stores.map((store) {
          return InputChip(
            label: Text(
              store,
              style: TextStyle(
                color: AppColors.onSurface(context),
                fontWeight: FontWeight.w800,
              ),
            ),
            onDeleted: () => onRemove(store),
            deleteIcon: const Icon(Iconsax.close_circle, size: 14),
            backgroundColor: AppColors.adaptiveCardColor(
              context,
              darkAlpha: 0.58,
            ),
            side: BorderSide(
              color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
              width: 0.55,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FallbackCountryRow extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onUseFallback;

  const _FallbackCountryRow({
    required this.onRetry,
    required this.onUseFallback,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: _MiniNotice(
            icon: Iconsax.warning_2,
            text: l10n.searchErrorCountryRequired,
            danger: true,
          ),
        ),
        const SizedBox(width: 8),
        _SmallButton(text: l10n.commonRetry, onTap: onRetry),
        const SizedBox(width: 8),
        _SmallButton(
          text: l10n.searchUseUS,
          onTap: onUseFallback,
          filled: true,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.onSurface(context),
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(
            color: AppColors.onMuted(context),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _LogoMark extends StatelessWidget {
  final double size;

  const _LogoMark({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.16),
          width: 0.7,
        ),
      ),
      child: ClipOval(
        child: Image.asset('assets/logo/app.png', fit: BoxFit.cover),
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.48,
            lightAlpha: 0.78,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
            width: 0.55,
          ),
        ),
        child: Icon(icon, color: AppColors.onMuted(context), size: 14),
      ),
    );
  }
}

class _SquareButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SquareButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 46,
      child: ElevatedButton(
        onPressed: onTap,
        style: _primaryButtonStyle(context),
        child: Icon(icon, size: 18),
      ),
    );
  }
}

class _RoundIcon extends StatelessWidget {
  final IconData icon;

  const _RoundIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, color: AppColors.primary, size: 16),
    );
  }
}

class _CodeBadge extends StatelessWidget {
  final String value;

  const _CodeBadge(this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 29,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        value.toUpperCase(),
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 9.5,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _MiniNotice extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool danger;

  const _MiniNotice({
    required this.icon,
    required this.text,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.danger : AppColors.primary;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.onMuted(context),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool filled;

  const _SmallButton({
    required this.text,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: filled
          ? ElevatedButton(
              onPressed: onTap,
              style: _primaryButtonStyle(context),
              child: Text(text),
            )
          : OutlinedButton(onPressed: onTap, child: Text(text)),
    );
  }
}

class _LoadingLine extends StatelessWidget {
  const _LoadingLine();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: LinearProgressIndicator(
        minHeight: 6,
        color: AppColors.primary,
        backgroundColor: AppColors.primary.withValues(alpha: 0.08),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.onMuted(context),
        letterSpacing: 0.9,
        fontSize: 11,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

InputDecoration _inputDecoration(
  BuildContext context, {
  required String hint,
  String? label,
  IconData? prefixIcon,
}) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      color: AppColors.onMuted(context),
      fontWeight: FontWeight.w800,
    ),
    hintText: hint,
    hintStyle: TextStyle(
      color: AppColors.onMuted(context).withValues(alpha: 0.82),
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
    prefixIcon: prefixIcon == null
        ? null
        : Icon(prefixIcon, color: AppColors.primary, size: 18),
    filled: true,
    fillColor: AppColors.adaptiveCardColor(context, darkAlpha: 0.5),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: AppColors.primary.withValues(alpha: 0.28),
        width: 1,
      ),
    ),
  );
}

InputDecoration _plainInputDecoration(
  BuildContext context, {
  required String hintText,
  TextStyle? hintStyle,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: hintStyle,
    filled: false,
    isCollapsed: true,
    contentPadding: EdgeInsets.zero,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
  );
}

BoxDecoration _fieldBox(BuildContext context) {
  return BoxDecoration(
    color: AppColors.adaptiveCardColor(context, darkAlpha: 0.5),
    borderRadius: BorderRadius.circular(14),
    border: Border.all(
      color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
      width: 0.55,
    ),
  );
}

ButtonStyle _primaryButtonStyle(BuildContext context) {
  return ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  );
}

String _planName(SubscriptionPlan? plan, AppLocalizations l10n) {
  return switch (plan) {
    SubscriptionPlan.PLUS => l10n.planPlus,
    SubscriptionPlan.PRO => l10n.planPro,
    SubscriptionPlan.KVONT => l10n.planKvont,
    SubscriptionPlan.FREE => l10n.planFree,
    null => l10n.planFree,
  };
}

class _SearchContextEntry {
  final String query;
  final String countryCode;
  final String countryName;
  final String countryGl;
  final String countryHl;
  final String countryLocation;
  final String? notes;
  final double? budget;
  final List<String> selectedStores;
  final DateTime createdAt;

  const _SearchContextEntry({
    required this.query,
    required this.countryCode,
    required this.countryName,
    required this.countryGl,
    required this.countryHl,
    required this.countryLocation,
    required this.notes,
    required this.budget,
    required this.selectedStores,
    required this.createdAt,
  });

  Country get country => Country(
    code: countryCode,
    name: countryName,
    gl: countryGl,
    hl: countryHl,
    location: countryLocation,
  );

  String metaLabel(AppLocalizations l10n) {
    final parts = [
      countryName,
      if (selectedStores.isNotEmpty)
        l10n.searchHistoryStores(selectedStores.length),
      if (budget != null) l10n.searchBudgetLabel,
      if ((notes ?? '').trim().isNotEmpty) l10n.searchHistoryContext,
    ];
    return parts.join(' | ');
  }

  factory _SearchContextEntry.fromJson(Map<String, dynamic> json) {
    final stores = json['selectedStores'] is List
        ? (json['selectedStores'] as List)
              .map((item) => item.toString().trim())
              .where((item) => item.isNotEmpty)
              .toList()
        : <String>[];
    final rawBudget = json['budget'];
    return _SearchContextEntry(
      query: json['query']?.toString().trim() ?? '',
      countryCode: (json['countryCode']?.toString().trim() ?? 'US')
          .toUpperCase(),
      countryName: json['countryName']?.toString().trim() ?? 'United States',
      countryGl: json['countryGl']?.toString().trim() ?? 'us',
      countryHl: json['countryHl']?.toString().trim() ?? 'en',
      countryLocation:
          json['countryLocation']?.toString().trim() ?? 'United States',
      notes: json['notes']?.toString(),
      budget: rawBudget is num ? rawBudget.toDouble() : null,
      selectedStores: stores,
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'query': query,
    'countryCode': countryCode,
    'countryName': countryName,
    'countryGl': countryGl,
    'countryHl': countryHl,
    'countryLocation': countryLocation,
    'notes': notes,
    'budget': budget,
    'selectedStores': selectedStores,
    'createdAt': createdAt.toIso8601String(),
  };
}
