import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:untitled5/core/common_widgets/agent_back_button.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/agent_ui_tokens.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  final Set<String> _removedIds = <String>{};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final favoritesAsync = ref.watch(favoritesProvider);
    final products =
        favoritesAsync.valueOrNull
            ?.where((product) => !_removedIds.contains(product.id))
            .toList() ??
        const <Product>[];
    final pagePadding = AgentUiTokens.screenPadding(context);

    return Scaffold(
      body: BlueGlassBackground(
        child: SafeArea(
          child: ResponsivePageFrame(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pagePadding,
                      8,
                      pagePadding,
                      0,
                    ),
                    child: _header(context, products),
                  ),
                ),
                favoritesAsync.when(
                  loading: () => const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  error: (_, _) => SliverFillRemaining(
                    hasScrollBody: false,
                    child: _FavoritesLoadError(
                      onRetry: () => ref.invalidate(favoritesProvider),
                      onSearch: () => context.push('/search'),
                    ),
                  ),
                  data: (_) {
                    if (products.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: _EmptyFavorites(
                          onSearch: () => context.push('/search'),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        pagePadding,
                        AgentUiTokens.sectionGap(context),
                        pagePadding,
                        context.responsiveBottomPadding,
                      ),
                      sliver: SliverList.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _FavoriteCard(
                              product: product,
                              onRemove: () => _remove(product),
                              onAnalyze: () => context.push(
                                '/ai-analysis/${Uri.encodeComponent(product.id.trim())}',
                              ),
                              l10n: l10n,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, List<Product> products) {
    final l10n = AppLocalizations.of(context);
    final textColor = AppColors.onSurface(context);
    final mutedColor = AppColors.onMuted(context);

    return Row(
      children: [
        const AgentBackButton(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.favoritesTitle,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w900,
                  fontSize: AgentUiTokens.headerTitleSize(context),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.favoritesSubtitle,
                style: TextStyle(
                  color: mutedColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
        if (products.isNotEmpty)
          TextButton.icon(
            onPressed: () => _clearAll(products),
            icon: const Icon(Iconsax.trash, color: AppColors.danger, size: 16),
            label: Text(
              l10n.commonClear,
              style: const TextStyle(
                color: AppColors.danger,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _remove(Product product) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _removedIds.add(product.id));
    try {
      await ref.read(favoritesRepositoryProvider).removeFavorite(product.id);
      ref.invalidate(favoritesProvider);
    } catch (_) {
      if (!mounted) return;
      setState(() => _removedIds.remove(product.id));
      _showSnack(l10n.favoritesActionFailed);
    }
  }

  Future<void> _clearAll(List<Product> products) async {
    final l10n = AppLocalizations.of(context);
    final ids = products
        .map((product) => product.id.trim())
        .where((productId) => productId.isNotEmpty)
        .toList();

    setState(() => _removedIds.addAll(ids));
    final repository = ref.read(favoritesRepositoryProvider);
    try {
      for (final productId in ids) {
        await repository.removeFavorite(productId);
      }
      ref.invalidate(favoritesProvider);
    } catch (_) {
      if (!mounted) return;
      setState(() => _removedIds.removeAll(ids));
      ref.invalidate(favoritesProvider);
      _showSnack(l10n.favoritesActionFailed);
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _FavoriteCard extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;
  final VoidCallback onAnalyze;
  final AppLocalizations l10n;

  const _FavoriteCard({
    required this.product,
    required this.onRemove,
    required this.onAnalyze,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.onSurface(context);
    final mutedColor = AppColors.onMuted(context);
    final bestPrice = _bestPrice(product);
    final imageUrl = product.imageUrl?.trim();

    return Dismissible(
      key: ValueKey<String>(product.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.danger.withValues(alpha: 0.2),
        ),
        child: const Icon(Iconsax.trash, color: AppColors.danger),
      ),
      child: GlassContainer(
        borderRadius: AgentUiTokens.cardRadius(context),
        padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: imageUrl == null || imageUrl.isEmpty
                      ? const Icon(
                          Iconsax.box,
                          color: AppColors.primary,
                          size: 18,
                        )
                      : Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          cacheWidth: 96,
                          errorBuilder: (_, _, _) => const Icon(
                            Iconsax.box,
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _title(product),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (bestPrice != null)
                  _Tag(text: _formatMoney(bestPrice.price, bestPrice.currency)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _subtitle(product),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: mutedColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                if (bestPrice != null) ...[
                  _Tag(text: bestPrice.store),
                  const SizedBox(width: 8),
                ],
                if (product.category.trim().isNotEmpty)
                  _Tag(text: product.category.trim()),
                const Spacer(),
                OutlinedButton(
                  onPressed: onAnalyze,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(98, 36),
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(l10n.favoritesAnalyze),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DynamicPrice? _bestPrice(Product product) {
    if (product.dynamicPrices.isEmpty) return null;
    final prices = [...product.dynamicPrices]
      ..sort((a, b) => a.price.compareTo(b.price));
    return prices.first;
  }

  String _title(Product product) {
    final title = product.title.trim();
    if (title.isNotEmpty) return title;
    final model = product.modelName.trim();
    if (model.isNotEmpty) return model;
    return l10n.favoritesProductFallback;
  }

  String _subtitle(Product product) {
    final verdict = product.aiAnalysis?.finalShoppingVerdict?.trim();
    if (verdict != null && verdict.isNotEmpty) return verdict;
    final summary = product.needsMatch?.summary.trim();
    if (summary != null && summary.isNotEmpty) return summary;
    final description = product.description.trim();
    if (description.isNotEmpty) return description;
    return l10n.favoritesNoNotes;
  }

  String _formatMoney(double value, String currency) {
    final code = currency.trim().isEmpty ? 'USD' : currency.trim();
    try {
      return NumberFormat.simpleCurrency(name: code).format(value);
    } catch (_) {
      return '$code ${value.toStringAsFixed(2)}';
    }
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
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
          fontSize: 10.5,
        ),
      ),
    );
  }
}

class _FavoritesLoadError extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onSearch;

  const _FavoritesLoadError({required this.onRetry, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textColor = AppColors.onSurface(context);
    final mutedColor = AppColors.onMuted(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: GlassContainer(
            borderRadius: AgentUiTokens.largeRadius(context),
            padding: EdgeInsets.fromLTRB(
              AgentUiTokens.cardPadding(context),
              18,
              AgentUiTokens.cardPadding(context),
              16,
            ),
            color: AppColors.adaptiveCardColor(
              context,
              darkAlpha: 0.7,
              lightAlpha: 0.96,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.warning.withValues(alpha: 0.12),
                    border: Border.all(
                      color: AppColors.warning.withValues(alpha: 0.24),
                      width: 0.8,
                    ),
                  ),
                  child: const Icon(
                    Icons.cloud_off_rounded,
                    size: 26,
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.favoritesLoadFailed,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: -0.4,
                    height: 1.12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.favoritesLoadSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mutedColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                    height: 1.42,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: Text(l10n.favoritesLoadAction),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: onSearch,
                  child: Text(l10n.favoritesStartShopping),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  final VoidCallback onSearch;

  const _EmptyFavorites({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textColor = AppColors.onSurface(context);
    final mutedColor = AppColors.onMuted(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AgentUiTokens.screenPadding(context),
        ),
        child: GlassContainer(
          borderRadius: AgentUiTokens.largeRadius(context),
          padding: EdgeInsets.all(AgentUiTokens.cardPadding(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Iconsax.heart, size: 32, color: AppColors.primary),
              const SizedBox(height: 8),
              Text(
                l10n.favoritesEmptyTitle,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.favoritesEmptySubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mutedColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSearch,
                  child: Text(l10n.favoritesStartShopping),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
