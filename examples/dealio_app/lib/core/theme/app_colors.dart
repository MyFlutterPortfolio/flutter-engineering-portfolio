import 'package:flutter/material.dart';

class AppColors {
  // Dark-first glass system with controlled blue accents
  static const Color background = Color(0xFF05070C);
  static const Color surface = Color(0xFF0B1018);
  static const Color card = Color(0xFF111827);

  static const Color primary = Color(0xFF4F8CFF);
  static const Color accent = Color(0xFF79A8FF);
  static const Color neon = Color(0xFFD3E3FF);
  static const Color info = Color(0xFF5F98FF);

  static const Color text = Color(0xFFF5F8FF);
  static const Color muted = Color(0xFFABB6C8);
  static const Color danger = Color(0xFFFF6D7A);

  static const Color darkBackground = background;
  static const Color darkSurface = surface;
  static const Color darkTextPrimary = text;
  static const Color darkTextSecondary = muted;

  // Light mode
  static const Color lightBackground = Color(0xFFF6F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF5F6C80);

  static const Color success = Color(0xFF32C9B8);
  static const Color warning = Color(0xFFFFB457);
  static const Color error = Color(0xFFFF6D7A);

  // Legacy aliases
  static const Color cobalt = primary;
  static const Color teal = neon;
  static const Color purple = accent;
  static const Color textPrimary = text;
  static const Color textSecondary = muted;
  static const Color textTertiary = Color(0xFF8C8C8C);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3E7FFF), Color(0xFF5B90FF), Color(0xFF7AA8FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFF141A24), Color(0xFF0A0E15)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient glassGradient() {
    return LinearGradient(
      colors: [
        Colors.white.withValues(alpha: 0.14),
        const Color(0xFFC6D9FF).withValues(alpha: 0.05),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.24),
      blurRadius: 22,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> getAdaptiveShadow(bool isDark) {
    return isDark
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 32,
              offset: const Offset(0, 14),
              spreadRadius: 0.8,
            ),
            BoxShadow(
              color: primary.withValues(alpha: 0.09),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ]
        : [
            BoxShadow(
              color: const Color(0xFF2D3A52).withValues(alpha: 0.12),
              blurRadius: 20,
              offset: const Offset(0, 10),
              spreadRadius: 0.2,
            ),
          ];
  }

  static Color adaptiveBorderColor(bool isDark) {
    return isDark
        ? const Color(0xFFDCE7FF).withValues(alpha: 0.045)
        : const Color(0xFF3C4A5F).withValues(alpha: 0.052);
  }

  static LinearGradient adaptiveGlassGradient(bool isDark) {
    return isDark
        ? LinearGradient(
            colors: [
              const Color(0xFF1E2A3B).withValues(alpha: 0.68),
              const Color(0xFF101926).withValues(alpha: 0.52),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.96),
              const Color(0xFFF1F6FF).withValues(alpha: 0.92),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static Color onSurface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightTextPrimary;
  }

  static Color onMuted(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : lightTextSecondary;
  }

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color adaptiveCardColor(
    BuildContext context, {
    double darkAlpha = 0.72,
    double lightAlpha = 0.94,
  }) {
    return isDark(context)
        ? card.withValues(alpha: darkAlpha)
        : lightSurface.withValues(alpha: lightAlpha);
  }

  static Color adaptiveSurfaceColor(
    BuildContext context, {
    double darkAlpha = 0.88,
    double lightAlpha = 0.98,
  }) {
    return isDark(context)
        ? surface.withValues(alpha: darkAlpha)
        : lightSurface.withValues(alpha: lightAlpha);
  }
}
