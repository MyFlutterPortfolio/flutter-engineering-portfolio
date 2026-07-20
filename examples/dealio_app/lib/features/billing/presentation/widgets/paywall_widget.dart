import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/core/theme/app_colors.dart';

class PaywallDialog extends ConsumerWidget {
  final String title;
  final String message;
  final QuotaInfo? quota;

  const PaywallDialog({
    super.key,
    required this.title,
    required this.message,
    this.quota,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    QuotaInfo? quota,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          PaywallDialog(title: title, message: message, quota: quota),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Icon(Iconsax.crown, size: 64, color: AppColors.cobalt),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (quota != null) ...[
            const SizedBox(height: 24),
            _buildQuotaInfo(context, quota!),
          ],
          const SizedBox(height: 32),
          _buildPlanOption(
            context,
            'PLUS',
            'AI Chat & Enhanced Analysis',
            '\$9.99/mo',
            AppColors.teal,
            () {
              // ref.read(billingStatusProvider.notifier).upgradeToPlan(SubscriptionPlan.PLUS);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 12),
          _buildPlanOption(
            context,
            'PRO',
            'Barcode, Reviews & More',
            '\$19.99/mo',
            AppColors.cobalt,
            () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Maybe Later',
              style: TextStyle(color: AppColors.textTertiary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuotaInfo(BuildContext context, QuotaInfo quota) {
    final search = quota.search;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cobalt.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Search Quota',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${search.used}/${search.limit}',
                style: const TextStyle(
                  color: AppColors.cobalt,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: search.used / search.limit,
            backgroundColor: AppColors.cobalt.withValues(alpha: 0.1),
            valueColor: const AlwaysStoppedAnimation(AppColors.cobalt),
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Text(
            'Resets at ${search.resetAt}',
            style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanOption(
    BuildContext context,
    String title,
    String subtitle,
    String price,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.16), width: 0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
