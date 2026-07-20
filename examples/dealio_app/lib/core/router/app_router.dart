import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled5/core/config/app_flags.dart';
import 'package:untitled5/core/session/auth_gate.dart';
import 'package:untitled5/features/ai_chat/presentation/pages/ai_recommendations_screen.dart';
import 'package:untitled5/features/alerts/presentation/pages/alert_events_screen.dart';
import 'package:untitled5/features/alerts/presentation/pages/alerts_screen.dart';
import 'package:untitled5/features/auth/presentation/pages/login_screen.dart';
import 'package:untitled5/features/auth/presentation/pages/register_screen.dart';
import 'package:untitled5/features/barcode/presentation/pages/barcode_scan_screen.dart';
import 'package:untitled5/features/favorites/presentation/pages/favorites_screen.dart';
import 'package:untitled5/features/image_analysis/presentation/pages/image_analysis_screen.dart';
import 'package:untitled5/features/main/presentation/pages/main_scaffold.dart';
import 'package:untitled5/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:untitled5/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:untitled5/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:untitled5/features/product/presentation/pages/ai_analysis_dashboard.dart';
import 'package:untitled5/features/product/presentation/pages/clario_ai_analysis_screen.dart';
import 'package:untitled5/features/product/presentation/pages/needs_match_detail_screen.dart';
import 'package:untitled5/features/product/presentation/pages/product_composition_screen.dart';
import 'package:untitled5/features/product/presentation/pages/product_detail_screen.dart';
import 'package:untitled5/features/product/presentation/pages/store_comparison_screen.dart';
import 'package:untitled5/features/profile/presentation/pages/about_screen.dart';
import 'package:untitled5/features/profile/presentation/pages/profile_screen.dart';
import 'package:untitled5/features/search/presentation/pages/search_results_screen.dart';
import 'package:untitled5/features/search/presentation/pages/search_screen.dart';
import 'package:untitled5/features/settings/presentation/pages/settings_screen.dart';
import 'package:untitled5/features/subscription/presentation/pages/subscription_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> _shellNavigatorSearchKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
final GlobalKey<NavigatorState> _shellNavigatorFavoritesKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellFavorites');
final GlobalKey<NavigatorState> _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

CustomTransitionPage _buildPageWithTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  if (AppFlags.reduceExpensiveVisualEffects) {
    return NoTransitionPage<T>(key: state.pageKey, child: child);
  }

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.03, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 340),
  );
}

CustomTransitionPage _buildAuthPage<T>({
  required GoRouterState state,
  required Widget child,
  required Offset beginOffset,
}) {
  if (AppFlags.reduceExpensiveVisualEffects) {
    return NoTransitionPage<T>(key: state.pageKey, child: child);
  }

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curve,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: Offset.zero,
          ).animate(curve),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1).animate(curve),
            child: child,
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 380),
  );
}

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  refreshListenable: authGateNotifier,
  redirect: (context, state) {
    final location = state.matchedLocation;
    const publicLocations = <String>{
      '/splash',
      '/onboarding',
      '/login',
      '/register',
    };
    final isPublic = publicLocations.contains(location);
    final authState = authGateNotifier.value;

    if (authState == AuthGateState.checking) {
      return location == '/splash' ? null : '/splash';
    }
    if (authState == AuthGateState.signedIn) {
      return isPublic ? '/home' : null;
    }
    return isPublic ? null : '/login';
  },
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/splash'),
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => _buildAuthPage(
        state: state,
        child: const LoginScreen(),
        beginOffset: const Offset(0.08, 0),
      ),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => _buildAuthPage(
        state: state,
        child: const RegisterScreen(),
        beginOffset: const Offset(-0.08, 0),
      ),
    ),

    // Global Routes
    GoRoute(
      path: '/notifications',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const NotificationsScreen(),
      ),
    ),
    GoRoute(
      path: '/alerts',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const AlertsScreen(),
      ),
    ),
    GoRoute(
      path: '/alerts/history',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const AlertEventsScreen(),
      ),
    ),
    GoRoute(
      path: '/subscription',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const SubscriptionScreen(),
      ),
    ),
    GoRoute(
      path: '/product/:productId',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId'] ?? '';
        return _buildPageWithTransition(
          context: context,
          state: state,
          child: ProductDetailScreen(productId: productId),
        );
      },
    ),
    GoRoute(
      path: '/ai-analysis/:productId',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId'] ?? '';
        return _buildPageWithTransition(
          context: context,
          state: state,
          child: AIAnalysisDashboard(productId: productId),
        );
      },
    ),
    GoRoute(
      path: '/clario-ai-analysis',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const ClarioAIAnalysisScreen(),
      ),
    ),
    GoRoute(
      path: '/image-analysis',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const ImageAnalysisScreen(),
      ),
    ),
    GoRoute(
      path: '/barcode-scan',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => _buildPageWithTransition(
        context: context,
        state: state,
        child: const BarcodeScanScreen(),
      ),
    ),
    GoRoute(
      path: '/search-results',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return _buildPageWithTransition(
          context: context,
          state: state,
          child: const SearchResultsScreen(),
        );
      },
    ),
    GoRoute(
      path: '/product-composition/:productId',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId'] ?? '';
        return _buildPageWithTransition(
          context: context,
          state: state,
          child: ProductCompositionScreen(productId: productId),
        );
      },
    ),
    GoRoute(
      path: '/store-comparison/:productId',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId'] ?? '';
        return _buildPageWithTransition(
          context: context,
          state: state,
          child: StoreComparisonScreen(productId: productId),
        );
      },
    ),
    GoRoute(
      path: '/needs-match-detail/:productId',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId'] ?? '';
        return _buildPageWithTransition(
          context: context,
          state: state,
          child: NeedsMatchDetailScreen(productId: productId),
        );
      },
    ),

    // Main App with Tabs
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => _buildPageWithTransition(
                context: context,
                state: state,
                child: const AIRecommendationsScreen(embedded: true),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSearchKey,
          routes: [
            GoRoute(
              path: '/search',
              pageBuilder: (context, state) => _buildPageWithTransition(
                context: context,
                state: state,
                child: const SearchScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavoritesKey,
          routes: [
            GoRoute(
              path: '/favorites',
              pageBuilder: (context, state) => _buildPageWithTransition(
                context: context,
                state: state,
                child: const FavoritesScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => _buildPageWithTransition(
                context: context,
                state: state,
                child: const ProfileScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'settings',
                  pageBuilder: (context, state) => _buildPageWithTransition(
                    context: context,
                    state: state,
                    child: const SettingsScreen(),
                  ),
                ),
                GoRoute(
                  path: 'subscription',
                  pageBuilder: (context, state) => _buildPageWithTransition(
                    context: context,
                    state: state,
                    child: const SubscriptionScreen(),
                  ),
                ),
                GoRoute(
                  path: 'about',
                  pageBuilder: (context, state) => _buildPageWithTransition(
                    context: context,
                    state: state,
                    child: const AboutScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // Global AI Chat
    GoRoute(
      path: '/ai-chat',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final productId = state.uri.queryParameters['productId'];
        return _buildPageWithTransition(
          context: context,
          state: state,
          child: AIRecommendationsScreen(productId: productId),
        );
      },
    ),
  ],
);
