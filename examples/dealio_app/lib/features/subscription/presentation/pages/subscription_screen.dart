import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/models/subscription_model.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/billing/presentation/providers/subscription_provider.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final billingState = ref.watch(billingStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscription plans',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: billingState.when(
        data: (data) => ResponsivePageFrame(
          child: SingleChildScrollView(
            padding: context.responsivePagePadding(top: 24),
            child: Column(
              children: [
                Text(
                  'Choose your plan',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fade().slideY(begin: 0.2, end: 0),
                const SizedBox(height: 8),
                Text(
                  'Choose a plan that fits your shopping needs',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ).animate().fade(delay: 200.ms),

                const SizedBox(height: 32),

                _PlanCard(
                  title: 'Free',
                  price: '\$0',
                  isActive: data.subscription.plan == SubscriptionPlan.FREE,
                  features: const ['Basic Analysis', '5 searches / month'],
                  onSelect: () => _showPaymentMessage(context),
                ).animate().fade(delay: 300.ms).slideX(begin: -0.1, end: 0),

                const SizedBox(height: 16),

                _PlanCard(
                  title: 'Plus',
                  price: '\$9.99',
                  isActive: data.subscription.plan == SubscriptionPlan.PLUS,
                  features: const [
                    'AI Analysis',
                    'DeepSeek Chat Access',
                    '100 searches / month',
                  ],
                  color: const Color.fromARGB(255, 83, 76, 190),
                  onSelect: () => _showPaymentMessage(context),
                ).animate().fade(delay: 400.ms).scale(),

                const SizedBox(height: 16),

                _PlanCard(
                  title: 'Pro',
                  price: '\$19.99',
                  isActive: data.subscription.plan == SubscriptionPlan.PRO,
                  features: const [
                    'Barcode Scanning',
                    'Super Alerts',
                    'Priority AI Processing',
                    'Verified Reviews',
                  ],
                  isPopular: true,
                  color: AppColors.cobalt,
                  onSelect: () => _showPaymentMessage(context),
                ).animate().fade(delay: 500.ms).slideX(begin: 0.1, end: 0),

                const SizedBox(height: 16),

                _PlanCard(
                  title: 'KVONT (Ultimate)',
                  price: '\$49.99',
                  isActive: data.subscription.plan == SubscriptionPlan.KVONT,
                  features: const [
                    'All Pro Features',
                    'Selected Store Search',
                    'Max Selected Stores (10)',
                    'Unlimited Search Quota',
                  ],
                  color: Colors.purple,
                  onSelect: () => _showPaymentMessage(context),
                ).animate().fade(delay: 600.ms).slideY(begin: 0.1, end: 0),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

void _showPaymentMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Payments will be available soon.')),
  );
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isPopular;
  final bool isActive;
  final Color color;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.features,
    required this.onSelect,
    this.isActive = false,
    this.isPopular = false,
    this.color = Colors.white10,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    price,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.green : AppColors.cobalt,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ...features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.tick_circle,
                        size: 18,
                        color: AppColors.teal,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(feature, style: theme.textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isActive ? null : onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive
                      ? Colors.green.withValues(alpha: 0.2)
                      : (isPopular
                            ? AppColors.cobalt
                            : theme.colorScheme.onSurface.withValues(
                                alpha: 0.1,
                              )),
                  foregroundColor: isPopular || isActive
                      ? Colors.white
                      : theme.textTheme.bodyLarge?.color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(isActive ? 'Active' : 'Switch to $title'),
              ),
            ],
          ),
        ),
        if (isPopular)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'POPULAR',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
