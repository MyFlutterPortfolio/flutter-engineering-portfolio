import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/config/app_flags.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/auth/presentation/providers/auth_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _loadingController;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    unawaited(_bootstrap());
  }

  Future<void> _bootstrap() async {
    final startedAt = DateTime.now();
    final authNotifier = ref.read(authProvider.notifier);
    final bootstrap = Future.wait<Object?>([
      authNotifier.checkAuth(),
      SharedPreferences.getInstance(),
    ]);

    final values = await bootstrap;
    final prefs = values[1]! as SharedPreferences;
    final authStatus = ref.read(authProvider).status;
    final seenOnboarding = prefs.getBool('onboarding_seen') ?? false;

    const minimumSplash = Duration(milliseconds: 1000);
    final remaining = minimumSplash - DateTime.now().difference(startedAt);
    if (remaining > Duration.zero) {
      await Future<void>.delayed(remaining);
    }
    if (!mounted) return;

    if (authStatus == AuthStatus.authenticated) {
      context.go('/home');
      return;
    }

    context.go(seenOnboarding ? '/login' : '/onboarding');
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final reduceEffects = AppFlags.reduceExpensiveVisualEffects;

    return Scaffold(
      body: BlueGlassBackground(
        child: Stack(
          children: [
            // Background Animation: Floating particles
            if (!reduceEffects)
              ...List.generate(15, (index) {
                final random = math.Random(index);
                return Positioned(
                  top: random.nextDouble() * MediaQuery.of(context).size.height,
                  left: random.nextDouble() * MediaQuery.of(context).size.width,
                  child:
                      Container(
                            width: 4 + random.nextDouble() * 8,
                            height: 4 + random.nextDouble() * 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withValues(alpha: 0.2),
                            ),
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .moveY(
                            begin: 0,
                            end: -50 - random.nextDouble() * 100,
                            duration: (2000 + random.nextInt(3000)).ms,
                            curve: Curves.easeInOut,
                          )
                          .fadeOut(duration: 2000.ms),
                );
              }),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with Glassmorphism Glow
                  Stack(
                        alignment: Alignment.center,
                        children: [
                          // Glow effect
                          Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              )
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(
                                begin: const Offset(0.8, 0.8),
                                end: const Offset(1.2, 1.2),
                                duration: 2.seconds,
                              ),

                          GlassContainer(
                            width: 100,
                            height: 100,
                            borderRadius: 30,
                            blur: reduceEffects ? 0 : 20,
                            padding: EdgeInsets.zero,
                            child: const Center(
                              child: Icon(
                                Icons.auto_awesome_rounded,
                                color: AppColors.primary,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .fadeIn(duration: reduceEffects ? 260.ms : 800.ms)
                      .scale(
                        begin: reduceEffects
                            ? const Offset(0.96, 0.96)
                            : const Offset(0.8, 0.8),
                      ),

                  const SizedBox(height: 32),

                  // App Name
                  Text(
                        'DEALIO',
                        style: GoogleFonts.poppins(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 8,
                          color: textColor,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: reduceEffects ? 120.ms : 400.ms)
                      .slideY(begin: reduceEffects ? 0.04 : 0.2, end: 0),

                  const SizedBox(height: 8),

                  // Animated Tagline
                  Text(
                        l10n.splashTagline,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: reduceEffects ? 180.ms : 800.ms)
                      .shimmer(
                        duration: reduceEffects ? 500.ms : 2.seconds,
                        color: AppColors.neon,
                      ),

                  const SizedBox(height: 60),

                  // Rotating Gradient Ring Loading Animation
                  AnimatedBuilder(
                    animation: _loadingController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _loadingController.value * 2 * math.pi,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.transparent,
                              width: 3,
                            ),
                            gradient: SweepGradient(
                              colors: [
                                Colors.transparent,
                                AppColors.primary,
                                AppColors.accent,
                                AppColors.neon,
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                            ),
                          ),
                        ),
                      );
                    },
                  ).animate().fadeIn(delay: reduceEffects ? 240.ms : 1200.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
