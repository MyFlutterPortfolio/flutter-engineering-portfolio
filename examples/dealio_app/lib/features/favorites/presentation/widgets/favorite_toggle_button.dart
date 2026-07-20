import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class FavoriteToggleButton extends ConsumerStatefulWidget {
  final Product product;
  final double size;
  final double iconSize;
  final double borderRadius;

  const FavoriteToggleButton({
    super.key,
    required this.product,
    this.size = 44,
    this.iconSize = 19,
    this.borderRadius = 16,
  });

  @override
  ConsumerState<FavoriteToggleButton> createState() =>
      _FavoriteToggleButtonState();
}

class _FavoriteToggleButtonState extends ConsumerState<FavoriteToggleButton> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final favoriteIds = ref.watch(favoriteIdsProvider);
    final productId = widget.product.id.trim();
    final isSaved = favoriteIds.valueOrNull?.contains(productId) == true;
    final l10n = AppLocalizations.of(context);
    final tooltip = isSaved
        ? l10n.favoritesRemoveTooltip
        : l10n.favoritesSaveTooltip;

    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: InkWell(
          onTap: _busy ? null : () => _toggle(isSaved),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: (isSaved ? AppColors.danger : AppColors.primary)
                  .withValues(alpha: isSaved ? 0.14 : 0.1),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: (isSaved ? AppColors.danger : AppColors.primary)
                    .withValues(alpha: isSaved ? 0.18 : 0.1),
                width: 0.7,
              ),
            ),
            child: Center(
              child: _busy
                  ? SizedBox(
                      width: widget.iconSize,
                      height: widget.iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: isSaved ? AppColors.danger : AppColors.primary,
                      ),
                    )
                  : Icon(
                      isSaved ? Iconsax.heart5 : Iconsax.heart,
                      color: isSaved ? AppColors.danger : AppColors.primary,
                      size: widget.iconSize,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _toggle(bool isSaved) async {
    final l10n = AppLocalizations.of(context);
    final productId = widget.product.id.trim();
    if (productId.isEmpty) {
      _showSnack(l10n.favoritesActionFailed);
      return;
    }

    setState(() => _busy = true);
    try {
      final repository = ref.read(favoritesRepositoryProvider);
      if (isSaved) {
        await repository.removeFavorite(productId);
      } else {
        await repository.addFavorite(widget.product);
      }

      ref.invalidate(favoritesProvider);
      if (!mounted) return;
      _showSnack(isSaved ? l10n.favoritesRemoved : l10n.favoritesSaved);
    } catch (_) {
      if (!mounted) return;
      _showSnack(l10n.favoritesActionFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
