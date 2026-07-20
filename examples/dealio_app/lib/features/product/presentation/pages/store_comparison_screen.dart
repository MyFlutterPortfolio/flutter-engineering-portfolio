import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/favorites/presentation/widgets/favorite_toggle_button.dart';

class StoreComparisonScreen extends StatefulWidget {
  final String productId;
  const StoreComparisonScreen({super.key, required this.productId});

  @override
  State<StoreComparisonScreen> createState() => _StoreComparisonScreenState();
}

class _StoreComparisonScreenState extends State<StoreComparisonScreen> {
  bool _crossCountryEnabled = false;
  bool _priceDropAlerts = false;
  String _selectedCategory = 'Global';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: _GlowCircle(
              color: AppColors.cobalt.withValues(alpha: isDark ? 0.1 : 0.05),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: _GlowCircle(
              color: AppColors.purple.withValues(alpha: isDark ? 0.1 : 0.05),
            ),
          ),

          SafeArea(
            child: ResponsivePageFrame(
              child: CustomScrollView(
                slivers: [
                  // Header
                  SliverAppBar(
                    floating: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    title: Text(
                      'Store Analysis',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.all(24.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // 1. Store Selection
                        _buildStoreSelection(theme),
                        const SizedBox(height: 32),

                        // 2. Store Analysis Table
                        _SectionHeader(title: 'Price Comparison'),
                        const SizedBox(height: 16),
                        _StoreAnalysisTable(),
                        const SizedBox(height: 32),

                        // 3. AI Insights
                        _SectionHeader(title: 'AI Market Insights'),
                        const SizedBox(height: 16),
                        _AiInsightsCard(),
                        const SizedBox(height: 32),

                        // 4. Price Drop Alert
                        _PriceDropAlertSection(
                          isEnabled: _priceDropAlerts,
                          onChanged: (v) =>
                              setState(() => _priceDropAlerts = v),
                        ),
                        const SizedBox(height: 40),

                        // 5. Action Buttons
                        _ActionButtons(productId: widget.productId),
                        SizedBox(height: context.responsiveBottomPadding),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreSelection(ThemeData theme) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Comparison Range',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _SelectionChip(
                label: 'Local',
                isSelected: _selectedCategory == 'Local',
                onTap: () => setState(() => _selectedCategory = 'Local'),
              ),
              const SizedBox(width: 8),
              _SelectionChip(
                label: 'Global',
                isSelected: _selectedCategory == 'Global',
                onTap: () => setState(() => _selectedCategory = 'Global'),
              ),
              const SizedBox(width: 8),
              _SelectionChip(
                label: 'Favorites',
                isSelected: _selectedCategory == 'Favorites',
                onTap: () => setState(() => _selectedCategory = 'Favorites'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cross-country comparison',
                style: theme.textTheme.bodyMedium,
              ),
              Switch(
                value: _crossCountryEnabled,
                onChanged: (v) => setState(() => _crossCountryEnabled = v),
                activeThumbColor: AppColors.cobalt,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary.withValues(alpha: 0.7),
      ),
    ).animate().fade().slideX(begin: -0.1);
  }
}

class _SelectionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.cobalt
              : theme.colorScheme.onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.cobalt
                : theme.dividerColor.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Colors.white
                : theme.textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}

class _StoreAnalysisTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildHeader(theme),
          const _StoreRow(
            name: 'Amazon',
            price: '\$299',
            auth: 'Original',
            rec: 'Yes',
            isBest: false,
          ),
          const _StoreRow(
            name: 'StoreY',
            price: '\$280',
            auth: 'Fake risk',
            rec: 'No',
            isBest: true,
          ),
          const _StoreRow(
            name: 'AliExpress',
            price: '\$310',
            auth: 'Original',
            rec: 'Yes',
            isBest: false,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Store',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.hintColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Price',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.hintColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Authenticity',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.hintColor,
              ),
            ),
          ),
          const Icon(Icons.link, size: 14, color: Colors.transparent),
        ],
      ),
    );
  }
}

class _StoreRow extends StatelessWidget {
  final String name;
  final String price;
  final String auth;
  final String rec;
  final bool isBest;

  const _StoreRow({
    required this.name,
    required this.price,
    required this.auth,
    required this.rec,
    required this.isBest,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isRisk = auth.contains('risk');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              price,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isBest
                    ? AppColors.teal
                    : theme.textTheme.bodyMedium?.color,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(
                  isRisk ? Icons.warning_amber_rounded : Icons.verified_user,
                  size: 14,
                  color: isRisk ? Colors.orange : AppColors.teal,
                ),
                const SizedBox(width: 4),
                Text(
                  auth,
                  style: TextStyle(
                    fontSize: 11,
                    color: isRisk
                        ? Colors.orange
                        : theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Iconsax.export_1, size: 16, color: AppColors.cobalt),
        ],
      ),
    ).animate().fade(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }
}

class _AiInsightsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InsightItem(
            text: 'Best deal found at StoreY, but authenticity risk detected.',
          ),
          _InsightItem(
            text:
                'Amazon offers verified original product at competitive price.',
            isRecommended: true,
          ),
          _InsightItem(
            text: 'Global comparison shows 12% lower prices in Japan stores.',
          ),
        ],
      ),
    );
  }
}

class _InsightItem extends StatelessWidget {
  final String text;
  final bool isRecommended;
  const _InsightItem({required this.text, this.isRecommended = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isRecommended ? Iconsax.magicpen : Iconsax.info_circle,
            size: 14,
            color: isRecommended ? AppColors.teal : AppColors.cobalt,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceDropAlertSection extends StatelessWidget {
  final bool isEnabled;
  final Function(bool) onChanged;

  const _PriceDropAlertSection({
    required this.isEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Iconsax.notification_status,
                    color: AppColors.teal,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Price Drop Alerts',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Switch(
                value: isEnabled,
                onChanged: onChanged,
                activeThumbColor: AppColors.teal,
              ),
            ],
          ),
          if (isEnabled) ...[
            const SizedBox(height: 16),
            Text(
              'Notify me if price drops by:',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.number,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'e.g. 10',
                suffixText: '%',
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Dealio will alert you when this product reaches your target threshold.',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 11,
                color: theme.hintColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    ).animate(target: isEnabled ? 1 : 0).shimmer(duration: 2.seconds);
  }
}

class _ActionButtons extends StatelessWidget {
  final String productId;
  const _ActionButtons({required this.productId});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.push(
            Uri(
              path: '/ai-chat',
              queryParameters: {'productId': productId.trim()},
            ).toString(),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cobalt,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.magicpen, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Ask AI More Details',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: FavoriteToggleButton(
            product: Product(id: productId.trim()),
            size: 54,
            iconSize: 22,
            borderRadius: 16,
          ),
        ),
      ],
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  const _GlowCircle({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
      ),
    );
  }
}
