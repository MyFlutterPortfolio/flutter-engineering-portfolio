import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/core/config/app_flags.dart';
import 'package:untitled5/core/theme/app_colors.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadiusGeometry? customRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.blur = 18.0,
    this.padding = const EdgeInsets.all(16.0),
    this.width,
    this.height,
    this.color,
    this.customRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = customRadius ?? BorderRadius.circular(borderRadius);
    final useExpensiveEffects = !AppFlags.reduceExpensiveVisualEffects;
    final shouldBlur = useExpensiveEffects && !kIsWeb && blur > 0;
    final shadows = useExpensiveEffects
        ? AppColors.getAdaptiveShadow(isDark)
        : <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.08),
              blurRadius: isDark ? 16 : 12,
              offset: const Offset(0, 7),
            ),
            BoxShadow(
              color: AppColors.primary.withValues(alpha: isDark ? 0.035 : 0.02),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ];
    final highlight = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withValues(alpha: isDark ? 0.16 : 0.28),
        Colors.white.withValues(alpha: 0.0),
        AppColors.primary.withValues(alpha: isDark ? 0.055 : 0.035),
      ],
      stops: const [0.0, 0.42, 1.0],
    );

    final glassChild = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius,
        border: Border.all(
          color: AppColors.adaptiveBorderColor(isDark),
          width: 0.45,
        ),
        gradient: color == null
            ? AppColors.adaptiveGlassGradient(isDark)
            : null,
      ),
      foregroundDecoration: BoxDecoration(
        gradient: highlight,
        borderRadius: radius,
      ),
      child: child,
    );

    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(borderRadius: radius, boxShadow: shadows),
        child: ClipRRect(
          borderRadius: radius,
          child: shouldBlur
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: glassChild,
                )
              : glassChild,
        ),
      ),
    );
  }
}
