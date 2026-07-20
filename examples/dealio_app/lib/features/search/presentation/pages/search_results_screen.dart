import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/agent_back_button.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/core/utils/plan_guard.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';
import 'package:untitled5/features/alerts/presentation/widgets/create_alert_sheet.dart';
import 'package:untitled5/features/billing/presentation/widgets/paywall_widget.dart';
import 'package:untitled5/features/favorites/presentation/widgets/favorite_toggle_button.dart';
import 'package:untitled5/features/search/presentation/providers/search_provider.dart';
import 'package:untitled5/features/search/presentation/providers/search_state.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class SearchResultsScreen extends ConsumerWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchNotifierProvider);
    final planGuard = ref.watch(planGuardProvider);
    final l10n = AppLocalizations.of(context);
    final pagePadding = AgentUiTokens.screenPadding(context);
    final gap = AgentUiTokens.sectionGap(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlueGlassBackground(
        child: SafeArea(
          child: ResponsivePageFrame(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pagePadding,
                      8,
                      pagePadding,
                      0,
                    ),
                    child: _TopBar(state: state, l10n: l10n),
                  ),
                ),
                if (state.status == SearchStatus.loadingStage1 &&
                    state.results.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _LoadingState(l10n: l10n),
                  )
                else if (state.status == SearchStatus.error ||
                    state.status == SearchStatus.quotaExceeded)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.all(pagePadding),
                      child: _ErrorState(state: state, ref: ref, l10n: l10n),
                    ),
                  )
                else if (state.results.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyState(l10n: l10n),
                  )
                else
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        pagePadding,
                        gap,
                        pagePadding,
                        0,
                      ),
                      child: _ResultsContent(
                        state: state,
                        l10n: l10n,
                        onOpen: (product) => context.push(
                          '/product/${Uri.encodeComponent(product.id.trim())}',
                        ),
                        onDeal: _openBestDeal,
                        onAlert: (product) => _openAlertSheet(
                          context,
                          ref,
                          product,
                          planGuard.canUseSuperAlerts,
                        ),
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: context.responsiveBottomPadding,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> _openAlertSheet(
    BuildContext context,
    WidgetRef ref,
    Product product,
    bool hasSuperAlerts,
  ) async {
    await showModalBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.42),
      isScrollControlled: true,
      builder: (context) => CreateAlertSheet(
        productId: product.id,
        initialTitle: _title(product, AppLocalizations.of(context)),
        currentPrice: _bestPrice(product)?.price,
        priceOffers: product.dynamicPrices,
        kvontMode: hasSuperAlerts,
        countryCode: ref.read(searchNotifierProvider).lastRequest?.country,
      ),
    );
  }

  static Future<void> _openBestDeal(Product product) async {
    await _openLink(_bestPrice(product)?.link ?? '');
  }

  static Future<void> _openLink(String link) async {
    await launchExternalWebUrl(link);
  }

  static List<DynamicPrice> _offersForProduct(
    SearchState state,
    Product product,
  ) {
    final title = product.title.trim().toLowerCase();
    final model = product.modelName.trim().toLowerCase();
    final sessionOffers = state.storeOffers
        .where((offer) {
          final productId = offer.productId?.trim();
          if (productId != null && productId.isNotEmpty) {
            return productId == product.id;
          }

          final offerTitle = offer.productTitle?.trim().toLowerCase();
          if (offerTitle == null || offerTitle.isEmpty) return false;
          return (title.isNotEmpty &&
                  (offerTitle.contains(title) || title.contains(offerTitle))) ||
              (model.isNotEmpty &&
                  (offerTitle.contains(model) || model.contains(offerTitle)));
        })
        .map(
          (offer) => DynamicPrice(
            store: offer.store,
            price: offer.price,
            currency: offer.currency,
            link: offer.link,
            availability: offer.availability,
            stock: offer.stock,
          ),
        );
    final productOffers = product.dynamicPrices;
    final prices =
        [
          ...sessionOffers,
          ...productOffers,
        ].where((price) => price.price > 0).toList()..sort((a, b) {
          if (a.availability != b.availability) {
            return a.availability ? -1 : 1;
          }
          return a.price.compareTo(b.price);
        });
    final seen = <String>{};
    return prices
        .where((price) {
          final key = '${price.store}-${price.price}-${price.link}';
          if (seen.contains(key)) return false;
          seen.add(key);
          return true;
        })
        .take(10)
        .toList();
  }
}

class _ResultsContent extends StatelessWidget {
  final SearchState state;
  final AppLocalizations l10n;
  final ValueChanged<Product> onOpen;
  final ValueChanged<Product> onDeal;
  final ValueChanged<Product> onAlert;

  const _ResultsContent({
    required this.state,
    required this.l10n,
    required this.onOpen,
    required this.onDeal,
    required this.onAlert,
  });

  @override
  Widget build(BuildContext context) {
    final products = state.results;
    final leadProduct = products.first;
    final offers = SearchResultsScreen._offersForProduct(state, leadProduct);
    final hasInsight = _hasInsight(leadProduct);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final overview = _OverviewStrip(state: state, l10n: l10n);
        final hero = _HeroResult(
          product: leadProduct,
          status: state.status,
          onOpen: () => onOpen(leadProduct),
          onDeal: () => onDeal(leadProduct),
          onAlert: () => onAlert(leadProduct),
        );
        final stage = _StageCard(state: state, l10n: l10n);
        final insight = _InsightCard(product: leadProduct);
        final offersRail = _OfferRail(
          offers: offers,
          l10n: l10n,
          onOpen: SearchResultsScreen._openLink,
        );
        final matchesHeader = _SectionHeader(
          title: l10n.resultsProductsOptimized(products.length),
          subtitle: l10n.resultsMatchesSubtitle,
        );
        final matches = _ResultsList(
          products: products,
          onOpen: onOpen,
          onDeal: onDeal,
          onAlert: onAlert,
        );

        if (!isWide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              overview,
              SizedBox(height: AgentUiTokens.sectionGap(context)),
              hero,
              SizedBox(height: AgentUiTokens.sectionGap(context)),
              stage,
              if (hasInsight) ...[
                SizedBox(height: AgentUiTokens.sectionGap(context)),
                insight,
              ],
              const SizedBox(height: 16),
              offersRail,
              const SizedBox(height: 16),
              matchesHeader,
              const SizedBox(height: 8),
              matches,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  overview,
                  SizedBox(height: AgentUiTokens.sectionGap(context)),
                  hero,
                  if (hasInsight) ...[
                    SizedBox(height: AgentUiTokens.sectionGap(context)),
                    insight,
                  ],
                ],
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  stage,
                  SizedBox(height: AgentUiTokens.sectionGap(context)),
                  offersRail,
                  const SizedBox(height: 16),
                  matchesHeader,
                  const SizedBox(height: 8),
                  matches,
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ResultsList extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product> onOpen;
  final ValueChanged<Product> onDeal;
  final ValueChanged<Product> onAlert;

  const _ResultsList({
    required this.products,
    required this.onOpen,
    required this.onDeal,
    required this.onAlert,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < products.length; index++)
          Padding(
            padding: EdgeInsets.only(
              bottom: index == products.length - 1 ? 0 : 10,
            ),
            child: _ResultRow(
              index: index,
              product: products[index],
              onOpen: () => onOpen(products[index]),
              onDeal: () => onDeal(products[index]),
              onAlert: () => onAlert(products[index]),
            ),
          ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  final SearchState state;
  final AppLocalizations l10n;

  const _TopBar({required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final stage = _stageCopy(state, l10n);
    final query = state.lastRequest?.query.trim();

    return Row(
      children: [
        const AgentBackButton(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                query == null || query.isEmpty
                    ? l10n.resultsNeuralSearch
                    : query,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontSize: AgentUiTokens.headerTitleSize(context),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                stage.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        _Pill(label: stage.title, color: stage.color),
      ],
    );
  }
}

class _OverviewStrip extends StatelessWidget {
  final SearchState state;
  final AppLocalizations l10n;

  const _OverviewStrip({required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _MetricPill(
            icon: Iconsax.global,
            label:
                state.lastRequest?.country.toUpperCase() ??
                l10n.resultsCountryFallback,
          ),
          _MetricPill(
            icon: Iconsax.medal_star,
            label: _planName(state.plan, l10n),
            color: AppColors.accent,
          ),
          _MetricPill(
            icon: Iconsax.cpu,
            label: _cleanLabel(
              state.searchProvider,
              l10n.resultsProviderFallback,
            ),
          ),
          if (state.quota != null)
            _MetricPill(
              icon: Iconsax.status,
              label: l10n.settingsSearchesLeft(
                state.quota!.search.remaining,
                state.quota!.search.limit,
              ),
              color: AppColors.success,
            ),
        ],
      ),
    );
  }
}

class _HeroResult extends StatelessWidget {
  final Product product;
  final SearchStatus status;
  final VoidCallback onOpen;
  final VoidCallback onDeal;
  final VoidCallback onAlert;

  const _HeroResult({
    required this.product,
    required this.status,
    required this.onOpen,
    required this.onDeal,
    required this.onAlert,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final best = _bestPrice(product);
    final score = _score(product);

    return Semantics(
      button: true,
      label: l10n.resultsOpenProductTooltip,
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(AgentUiTokens.largeRadius(context)),
        child: Container(
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          decoration: BoxDecoration(
            color: AppColors.adaptiveCardColor(context, darkAlpha: 0.82),
            borderRadius: BorderRadius.circular(
              AgentUiTokens.largeRadius(context),
            ),
            border: Border.all(
              color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: AppColors.isDark(context) ? 0.22 : 0.07,
                ),
                blurRadius: 26,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 430;
              final imageSize = isCompact ? 82.0 : 108.0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProductImage(
                        product: product,
                        size: imageSize,
                        radius: AgentUiTokens.cardRadius(context),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _Tag(text: l10n.resultsTopPick),
                                const Spacer(),
                                _Pill(
                                  label: status == SearchStatus.stage3Ready
                                      ? l10n.resultsReady
                                      : l10n.resultsLive,
                                  color: status == SearchStatus.stage3Ready
                                      ? AppColors.success
                                      : AppColors.primary,
                                ),
                              ],
                            ),
                            const SizedBox(height: 9),
                            Text(
                              _title(product, l10n),
                              maxLines: isCompact ? 2 : 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.onSurface(context),
                                fontSize: isCompact ? 17 : 20,
                                fontWeight: FontWeight.w900,
                                height: 1.08,
                                letterSpacing: -0.45,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _subtitle(product, l10n),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.onMuted(context),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _BestPricePanel(best: best, score: score, l10n: l10n),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          label: l10n.notificationsViewProduct,
                          icon: Iconsax.box,
                          onTap: onOpen,
                          filled: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      _SquareAction(
                        icon: Iconsax.shopping_cart,
                        tooltip: l10n.resultsOpenDealTooltip,
                        enabled: best?.link.trim().isNotEmpty ?? false,
                        onTap: onDeal,
                      ),
                      const SizedBox(width: 8),
                      _SquareAction(
                        icon: Iconsax.notification_bing,
                        tooltip: l10n.resultsCreateAlertTooltip,
                        color: AppColors.accent,
                        onTap: onAlert,
                      ),
                      const SizedBox(width: 8),
                      FavoriteToggleButton(product: product),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BestPricePanel extends StatelessWidget {
  final DynamicPrice? best;
  final double? score;
  final AppLocalizations l10n;

  const _BestPricePanel({
    required this.best,
    required this.score,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final store = _cleanLabel(best?.store, l10n.resultsStoreFallback);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(
          alpha: AppColors.isDark(context) ? 0.1 : 0.055,
        ),
        borderRadius: BorderRadius.circular(AgentUiTokens.cardRadius(context)),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.09),
          width: 0.7,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  best == null
                      ? l10n.resultsPriceSyncing
                      : l10n.resultsBestLivePrice,
                  style: TextStyle(
                    color: AppColors.onMuted(context),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  best == null
                      ? l10n.resultsCheckingStores
                      : _money(best!.price, best!.currency),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.9,
                  ),
                ),
                if (best != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    store,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.onMuted(context),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (score != null) ...[
            const SizedBox(width: 12),
            _ScoreRing(score: score!),
          ],
        ],
      ),
    );
  }
}

class _StageCard extends StatelessWidget {
  final SearchState state;
  final AppLocalizations l10n;

  const _StageCard({required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final stage = _stageCopy(state, l10n);
    final progress = switch (state.status) {
      SearchStatus.loadingStage1 => 0.22,
      SearchStatus.stage1Ready => 0.45,
      SearchStatus.stage1ReadyAiPending => 0.58,
      SearchStatus.stage2Ready => 0.76,
      SearchStatus.stage3Ready => 1.0,
      _ => 0.15,
    };

    return _SoftCard(
      child: Row(
        children: [
          _RoundIcon(icon: Iconsax.activity, color: stage.color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        stage.title,
                        style: TextStyle(
                          color: AppColors.onSurface(context),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: TextStyle(
                        color: stage.color,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    value: progress,
                    color: stage.color,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.08),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  _stageNote(state, l10n),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.onMuted(context),
                    fontSize: 12,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final Product product;

  const _InsightCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final ai = product.aiAnalysis;
    final verdict =
        ai?.recommendationForUser ??
        ai?.fitSummary ??
        ai?.finalShoppingVerdict ??
        product.description;
    final chips = _highlights(product);

    if (verdict.trim().isEmpty && chips.isEmpty) {
      return const SizedBox.shrink();
    }

    return _SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Iconsax.magic_star,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.resultsDealioTake,
                style: TextStyle(
                  color: AppColors.onSurface(context),
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              if (ai?.confidence != null)
                _Pill(
                  label: '${ai!.confidence!.round()}%',
                  color: AppColors.success,
                ),
            ],
          ),
          if (verdict.trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              verdict,
              style: TextStyle(
                color: AppColors.onSurface(context),
                fontSize: 14,
                height: 1.35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          if (chips.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: chips.map((item) => _TinyChip(text: item)).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _OfferRail extends StatelessWidget {
  final List<DynamicPrice> offers;
  final AppLocalizations l10n;
  final ValueChanged<String> onOpen;

  const _OfferRail({
    required this.offers,
    required this.l10n,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: l10n.resultsLiveOffersTitle,
          subtitle: offers.isEmpty
              ? l10n.resultsNoLiveOffers
              : l10n.resultsLiveOffersSubtitle,
        ),
        const SizedBox(height: 10),
        if (offers.isEmpty)
          _SoftCard(
            child: Row(
              children: [
                _RoundIcon(
                  icon: Iconsax.shop,
                  color: AppColors.onMuted(context),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.resultsNoLiveOffers,
                    style: TextStyle(
                      color: AppColors.onMuted(context),
                      fontSize: 13,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          SizedBox(
            height: 132,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: offers.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) => _OfferTile(
                offer: offers[index],
                isBest: index == 0,
                l10n: l10n,
                onTap: () => onOpen(offers[index].link),
              ),
            ),
          ),
      ],
    );
  }
}

class _OfferTile extends StatelessWidget {
  final DynamicPrice offer;
  final bool isBest;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  const _OfferTile({
    required this.offer,
    required this.isBest,
    required this.l10n,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final canOpen = offer.link.trim().isNotEmpty;
    final store = _cleanLabel(offer.store, l10n.resultsStoreFallback);

    return Semantics(
      button: canOpen,
      label: canOpen ? l10n.resultsOpenDealTooltip : store,
      child: InkWell(
        onTap: canOpen ? onTap : null,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: 216,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.adaptiveCardColor(context, darkAlpha: 0.76),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: (isBest ? AppColors.success : AppColors.primary)
                  .withValues(alpha: isBest ? 0.18 : 0.055),
              width: isBest ? 0.75 : 0.55,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      store,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onSurface(context),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  if (isBest) _Tag(text: l10n.resultsBestBadge),
                ],
              ),
              const Spacer(),
              Text(
                _money(offer.price, offer.currency),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    offer.availability
                        ? Iconsax.tick_circle
                        : Iconsax.close_circle,
                    size: 14,
                    color: offer.availability
                        ? AppColors.success
                        : AppColors.danger,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      offer.availability
                          ? l10n.resultsOfferAvailable
                          : l10n.resultsOfferUnavailable,
                      style: TextStyle(
                        color: offer.availability
                            ? AppColors.success
                            : AppColors.danger,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Icon(
                    canOpen ? Iconsax.link_1 : Iconsax.lock,
                    size: 14,
                    color: canOpen
                        ? AppColors.primary
                        : AppColors.onMuted(context),
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

class _ResultRow extends StatelessWidget {
  final int index;
  final Product product;
  final VoidCallback onOpen;
  final VoidCallback onDeal;
  final VoidCallback onAlert;

  const _ResultRow({
    required this.index,
    required this.product,
    required this.onOpen,
    required this.onDeal,
    required this.onAlert,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final best = _bestPrice(product);
    final score = _score(product);

    return Semantics(
      button: true,
      label: l10n.resultsOpenProductTooltip,
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(24),
        child: _SoftCard(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _ProductImage(product: product, size: 74, radius: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _RankBadge(index: index),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            _subtitle(product, l10n),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.onMuted(context),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (score != null) ...[
                          const SizedBox(width: 8),
                          _MiniScore(score: score),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _title(product, l10n),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onSurface(context),
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        height: 1.18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                best == null
                                    ? l10n.resultsPricePending
                                    : _money(best.price, best.currency),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              if (best != null)
                                Text(
                                  _cleanLabel(
                                    best.store,
                                    l10n.resultsStoreFallback,
                                  ),
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
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  _MiniAction(
                    icon: Iconsax.shopping_cart,
                    tooltip: l10n.resultsOpenDealTooltip,
                    enabled: best?.link.trim().isNotEmpty ?? false,
                    onTap: onDeal,
                  ),
                  const SizedBox(height: 8),
                  _MiniAction(
                    icon: Iconsax.notification_bing,
                    tooltip: l10n.resultsCreateAlertTooltip,
                    color: AppColors.accent,
                    onTap: onAlert,
                  ),
                  const SizedBox(height: 8),
                  FavoriteToggleButton(
                    product: product,
                    size: 38,
                    iconSize: 17,
                    borderRadius: 13,
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

class _LoadingState extends StatelessWidget {
  final AppLocalizations l10n;

  const _LoadingState({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AgentUiTokens.screenPadding(context),
        ),
        child: _SoftCard(
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 34,
                height: 34,
                child: CircularProgressIndicator(
                  strokeWidth: 2.6,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                l10n.resultsLoadingTitle,
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
                l10n.resultsLoadingSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                  height: 1.38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final SearchState state;
  final WidgetRef ref;
  final AppLocalizations l10n;

  const _ErrorState({
    required this.state,
    required this.ref,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final isQuota = state.status == SearchStatus.quotaExceeded;
    return Center(
      child: _SoftCard(
        padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.danger, color: AppColors.danger, size: 32),
            const SizedBox(height: 10),
            Text(
              isQuota
                  ? l10n.resultsSearchLimitReached
                  : l10n.resultsNeuralGlitch,
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
              state.errorMessage ?? l10n.resultsUnexpectedError,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.onMuted(context),
                height: 1.35,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
            const SizedBox(height: 12),
            _ActionButton(
              label: isQuota ? l10n.resultsUpgradeNow : l10n.resultsTryAgain,
              icon: isQuota ? Iconsax.medal_star : Iconsax.refresh,
              filled: true,
              onTap: () {
                if (isQuota) {
                  PaywallDialog.show(
                    context,
                    title: l10n.resultsUpgradePlanTitle,
                    message: l10n.resultsUpgradePlanMessage,
                    quota: state.quota,
                  );
                } else {
                  ref.read(searchNotifierProvider.notifier).retry();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final AppLocalizations l10n;

  const _EmptyState({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AgentUiTokens.screenPadding(context),
        ),
        child: _SoftCard(
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.search_status,
                size: 32,
                color: AppColors.onMuted(context).withValues(alpha: 0.32),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.resultsEmptyTitle,
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
                l10n.resultsEmptyDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.onMuted(context),
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(height: 12),
              _ActionButton(
                label: l10n.resultsAdjustParameters,
                icon: Iconsax.arrow_left_2,
                onTap: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _SoftCard({
    required this.child,
    this.padding = const EdgeInsets.all(14),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.76),
        borderRadius: BorderRadius.circular(AgentUiTokens.cardRadius(context)),
        border: Border.all(
          color: AppColors.adaptiveBorderColor(AppColors.isDark(context)),
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: AppColors.isDark(context) ? 0.14 : 0.045,
            ),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ProductImage extends StatelessWidget {
  final Product product;
  final double size;
  final double radius;

  const _ProductImage({
    required this.product,
    required this.size,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final image = product.imageUrl?.trim();
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: image == null || image.isEmpty
            ? Icon(Iconsax.image, color: AppColors.onMuted(context))
            : Image.network(
                image,
                fit: BoxFit.contain,
                cacheWidth: (size * 2.2).round(),
                filterQuality: FilterQuality.low,
                errorBuilder: (_, _, _) =>
                    Icon(Iconsax.image, color: AppColors.onMuted(context)),
              ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: filled
          ? ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, size: 18),
              label: Text(label),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.isDark(context)
                    ? AppColors.background
                    : Colors.white,
                elevation: 0,
                textStyle: const TextStyle(fontWeight: FontWeight.w900),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          : OutlinedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, size: 18),
              label: Text(label),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  width: 0.8,
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.w900),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
    );
  }
}

class _SquareAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final Color color;
  final bool enabled;

  const _SquareAction({
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.color = AppColors.primary,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: enabled,
        label: tooltip,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: enabled ? 0.13 : 0.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: enabled ? color : AppColors.onMuted(context),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final Color color;
  final bool enabled;

  const _MiniAction({
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.color = AppColors.primary,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: enabled,
        label: tooltip,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(13),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: enabled ? 0.12 : 0.045),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: enabled ? color : AppColors.onMuted(context),
              size: 17,
            ),
          ),
        ),
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetricPill({
    required this.icon,
    required this.label,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.72),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.05), width: 0.45),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              color: AppColors.onSurface(context),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;

  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  final int index;

  const _RankBadge({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.onSurface(context).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '#${index + 1}',
        style: TextStyle(
          color: AppColors.onSurface(context),
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ScoreRing extends StatelessWidget {
  final double score;

  const _ScoreRing({required this.score});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: 0.1),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.18),
          width: 0.7,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              score.round().clamp(0, 100).toInt().toString(),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              l10n.resultsFitLabel,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 8,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniScore extends StatelessWidget {
  final double score;

  const _MiniScore({required this.score});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        l10n.resultsFitScore(score.round().clamp(0, 100).toInt()),
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _RoundIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _RoundIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 19),
    );
  }
}

class _TinyChip extends StatelessWidget {
  final String text;

  const _TinyChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.onSurface(context),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.onSurface(context),
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.25,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(
            color: AppColors.onMuted(context),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _StageCopy {
  final String title;
  final String subtitle;
  final Color color;

  const _StageCopy({
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

_StageCopy _stageCopy(SearchState state, AppLocalizations l10n) {
  return switch (state.status) {
    SearchStatus.stage1Ready => _StageCopy(
      title: l10n.resultsStage1ReadyTitle,
      subtitle: l10n.resultsStage1ReadySubtitle,
      color: AppColors.info,
    ),
    SearchStatus.stage1ReadyAiPending => _StageCopy(
      title: l10n.resultsStageFindingTitle,
      subtitle: l10n.resultsStageFindingSubtitle,
      color: AppColors.primary,
    ),
    SearchStatus.stage2Ready => _StageCopy(
      title: l10n.resultsStage2ReadyTitle,
      subtitle: l10n.resultsStage2ReadySubtitle,
      color: AppColors.accent,
    ),
    SearchStatus.stage3Ready => _StageCopy(
      title: l10n.resultsStage3ReadyTitle,
      subtitle: l10n.resultsStage3ReadySubtitle,
      color: AppColors.success,
    ),
    SearchStatus.quotaExceeded => _StageCopy(
      title: l10n.resultsSearchQuotaTitle,
      subtitle: l10n.resultsSearchLimitReached,
      color: AppColors.warning,
    ),
    SearchStatus.error => _StageCopy(
      title: l10n.resultsNeuralGlitch,
      subtitle: l10n.resultsUnexpectedError,
      color: AppColors.danger,
    ),
    _ => _StageCopy(
      title: l10n.resultsStageFindingTitle,
      subtitle: l10n.resultsStageFindingSubtitle,
      color: AppColors.primary,
    ),
  };
}

String _stageNote(SearchState state, AppLocalizations l10n) {
  if (state.stage3Error) {
    return l10n.resultsFinalAiDelayed;
  }
  if (state.stage2Error) {
    return l10n.resultsStoreValidationDelayed;
  }
  return _stageCopy(state, l10n).subtitle;
}

DynamicPrice? _bestPrice(Product product) {
  if (product.dynamicPrices.isEmpty) return null;
  final validPrices = product.dynamicPrices
      .where((price) => price.price > 0)
      .toList();
  if (validPrices.isEmpty) return null;
  final availablePrices = validPrices
      .where((price) => price.availability)
      .toList();
  final prices = [
    if (availablePrices.isNotEmpty) ...availablePrices else ...validPrices,
  ]..sort((a, b) => a.price.compareTo(b.price));
  return prices.first;
}

double? _score(Product product) {
  final raw =
      product.aiAnalysis?.needsMatchScore ??
      product.needsMatch?.matchPercentage;
  if (raw == null) return null;
  return raw <= 1 ? raw * 100 : raw;
}

String _title(Product product, AppLocalizations l10n) {
  final title = product.title.trim();
  if (title.isNotEmpty) return title;
  final model = product.modelName.trim();
  return model.isNotEmpty ? model : l10n.resultsProductFallback;
}

String _subtitle(Product product, AppLocalizations l10n) {
  final parts = [
    product.brand.trim(),
    product.category.trim(),
  ].where((part) => part.isNotEmpty).toList();
  return parts.isEmpty ? l10n.resultsSmartMatch : parts.join(' | ');
}

String _cleanLabel(String? value, String fallback) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? fallback : trimmed;
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

String _money(num price, String currency) {
  return '$currency ${price.toStringAsFixed(price >= 100 ? 0 : 2)}';
}

bool _hasInsight(Product product) {
  final ai = product.aiAnalysis;
  final verdict =
      ai?.recommendationForUser ??
      ai?.fitSummary ??
      ai?.finalShoppingVerdict ??
      product.description;
  return verdict.trim().isNotEmpty || _highlights(product).isNotEmpty;
}

List<String> _highlights(Product product) {
  final ai = product.aiAnalysis;
  final raw = <String>[
    ...?ai?.prosForUser,
    ...?ai?.pros,
    if ((ai?.marketSentiment ?? '').trim().isNotEmpty) ai!.marketSentiment!,
    if ((ai?.authenticityReport ?? '').trim().isNotEmpty)
      ai!.authenticityReport!,
  ];
  final seen = <String>{};
  final items = <String>[];
  for (final item in raw) {
    final value = item.trim();
    if (value.isEmpty || seen.contains(value.toLowerCase())) continue;
    seen.add(value.toLowerCase());
    items.add(value);
    if (items.length == 3) break;
  }
  return items;
}
