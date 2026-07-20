import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  static const List<_NavConfig> _items = <_NavConfig>[
    _NavConfig(
      labelBuilder: _homeLabel,
      icon: Iconsax.message_question,
      activeIcon: Iconsax.message_question,
    ),
    _NavConfig(
      labelBuilder: _searchLabel,
      icon: Iconsax.search_normal_1,
      activeIcon: Iconsax.search_normal_1,
    ),
    _NavConfig(
      labelBuilder: _favoritesLabel,
      icon: Iconsax.heart,
      activeIcon: Iconsax.heart5,
    ),
    _NavConfig(
      labelBuilder: _profileLabel,
      icon: Iconsax.user,
      activeIcon: Iconsax.user_octagon,
    ),
  ];

  static String _homeLabel(AppLocalizations l10n) => l10n.navHome;
  static String _searchLabel(AppLocalizations l10n) => l10n.navSearch;
  static String _favoritesLabel(AppLocalizations l10n) => l10n.navFavorites;
  static String _profileLabel(AppLocalizations l10n) => l10n.navProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final usesRail = context.usesNavigationRail;
    return Scaffold(
      body: usesRail
          ? Row(
              children: [
                _DesktopNavRail(
                  items: _items,
                  currentIndex: navigationShell.currentIndex,
                  l10n: l10n,
                  onSelect: _goBranch,
                ),
                Expanded(child: navigationShell),
              ],
            )
          : navigationShell,
      bottomNavigationBar: usesRail
          ? null
          : SafeArea(
              top: false,
              child: NavigationBar(
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: _goBranch,
                destinations: [
                  for (final item in _items)
                    NavigationDestination(
                      icon: Icon(item.icon),
                      selectedIcon: Icon(item.activeIcon),
                      label: item.labelBuilder(l10n),
                    ),
                ],
              ),
            ),
      extendBody: false,
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _DesktopNavRail extends StatelessWidget {
  final List<_NavConfig> items;
  final int currentIndex;
  final AppLocalizations l10n;
  final ValueChanged<int> onSelect;

  const _DesktopNavRail({
    required this.items,
    required this.currentIndex,
    required this.l10n,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final expanded = context.viewportWidth >= AppBreakpoints.large;
    final railWidth = expanded ? 174.0 : 88.0;

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(12, 12, 0, 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: railWidth,
            height: constraints.maxHeight,
            child: GlassContainer(
              borderRadius: 28,
              blur: 24,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              child: Column(
                children: [
                  _RailBrand(expanded: expanded),
                  const SizedBox(height: 18),
                  for (var index = 0; index < items.length; index++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _RailNavItem(
                        config: items[index],
                        label: items[index].labelBuilder(l10n),
                        expanded: expanded,
                        isActive: currentIndex == index,
                        onTap: () => onSelect(index),
                      ),
                    ),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RailBrand extends StatelessWidget {
  final bool expanded;

  const _RailBrand({required this.expanded});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: expanded
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.95),
                AppColors.primary.withValues(alpha: 0.48),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.18),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Iconsax.shopping_bag,
            color: Colors.white,
            size: 21,
          ),
        ),
        if (expanded) ...[
          const SizedBox(width: 10),
          Text(
            'Dealio',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.onSurface(context),
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ],
    );
  }
}

class _RailNavItem extends StatelessWidget {
  final _NavConfig config;
  final String label;
  final bool expanded;
  final bool isActive;
  final VoidCallback onTap;

  const _RailNavItem({
    required this.config,
    required this.label,
    required this.expanded,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inactiveColor = theme.brightness == Brightness.dark
        ? AppColors.muted
        : AppColors.lightTextSecondary;

    return Semantics(
      button: true,
      selected: isActive,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: expanded ? 13 : 0,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.13)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: expanded
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Icon(
                isActive ? config.activeIcon : config.icon,
                color: isActive ? AppColors.primary : inactiveColor,
                size: 22,
              ),
              if (expanded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isActive ? AppColors.primary : inactiveColor,
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.w900 : FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavConfig {
  final String Function(AppLocalizations l10n) labelBuilder;
  final IconData icon;
  final IconData activeIcon;

  const _NavConfig({
    required this.labelBuilder,
    required this.icon,
    required this.activeIcon,
  });
}
