import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';

class StoreOffersCarousel extends StatelessWidget {
  final List<StoreOffer> offers;

  const StoreOffersCarousel({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) return const SizedBox.shrink();
    final textColor = AppColors.onSurface(context);

    final sorted = [...offers]..sort((a, b) => a.price.compareTo(b.price));
    final topOffers = sorted.take(8).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Iconsax.shop, size: 16, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Best Store Prices',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 124,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: topOffers.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final offer = topOffers[index];
              final isBest = index == 0;
              return _OfferCard(
                offer: offer,
                isBest: isBest,
                onOpen: () => _openLink(offer.link),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _openLink(String link) async {
    await launchExternalWebUrl(link);
  }
}

class _OfferCard extends StatelessWidget {
  final StoreOffer offer;
  final bool isBest;
  final VoidCallback onOpen;

  const _OfferCard({
    required this.offer,
    required this.isBest,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.onSurface(context);
    return Container(
      width: 210,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCardColor(context, darkAlpha: 0.74),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isBest
              ? AppColors.primary.withValues(alpha: 0.24)
              : AppColors.primary.withValues(alpha: 0.045),
          width: isBest ? 0.75 : 0.45,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  offer.store,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              if (isBest)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'BEST',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(
            '${offer.currency} ${offer.price.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                offer.availability ? Iconsax.tick_circle : Iconsax.close_circle,
                size: 14,
                color: offer.availability
                    ? AppColors.success
                    : AppColors.danger,
              ),
              const SizedBox(width: 6),
              Text(
                offer.availability ? 'In stock' : 'Out of stock',
                style: TextStyle(
                  color: offer.availability
                      ? AppColors.success
                      : AppColors.danger,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: offer.link.isEmpty ? null : onOpen,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Iconsax.link_1,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
