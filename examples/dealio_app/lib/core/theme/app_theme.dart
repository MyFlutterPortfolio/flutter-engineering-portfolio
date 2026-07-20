import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled5/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
      ),
    );
    return _build(base, isDark: true);
  }

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextPrimary,
      ),
    );
    return _build(base, isDark: false);
  }

  static ThemeData _build(ThemeData base, {required bool isDark}) {
    final textTheme = _textTheme(isDark: isDark);
    final primary = base.colorScheme.primary;
    const onPrimary = Colors.white;

    return base.copyWith(
      textTheme: textTheme,
      primaryColor: primary,
      dividerColor: isDark
          ? Colors.white.withValues(alpha: 0.07)
          : Colors.black.withValues(alpha: 0.05),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? AppColors.text : AppColors.lightTextPrimary,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: isDark
            ? AppColors.card.withValues(alpha: 0.72)
            : Colors.white.withValues(alpha: 0.92),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? AppColors.card.withValues(alpha: 0.64)
            : Colors.white.withValues(alpha: 0.88),
        hintStyle: TextStyle(
          color: isDark
              ? AppColors.muted.withValues(alpha: 0.92)
              : AppColors.lightTextSecondary.withValues(alpha: 0.95),
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: -0.1,
        ),
        labelStyle: TextStyle(
          color: isDark
              ? AppColors.muted.withValues(alpha: 0.9)
              : AppColors.lightTextSecondary.withValues(alpha: 0.9),
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: -0.05,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: primary.withValues(alpha: 0.44),
            width: 0.9,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(46),
          backgroundColor: primary,
          foregroundColor: onPrimary,
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            fontSize: 15,
            letterSpacing: -0.25,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(46),
          side: BorderSide(color: primary.withValues(alpha: 0.1), width: 0.8),
          foregroundColor: isDark ? AppColors.text : AppColors.lightTextPrimary,
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: -0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark
            ? AppColors.card.withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.95),
        contentTextStyle: TextStyle(
          color: isDark ? AppColors.text : AppColors.lightTextPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          letterSpacing: -0.1,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  static TextTheme _textTheme({required bool isDark}) {
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final secondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          color: textColor,
          height: 1.08,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          color: textColor,
          height: 1.1,
          letterSpacing: -0.8,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: textColor,
          height: 1.12,
          letterSpacing: -0.7,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: textColor,
          height: 1.14,
          letterSpacing: -0.55,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 21,
          fontWeight: FontWeight.w800,
          color: textColor,
          height: 1.16,
          letterSpacing: -0.45,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: textColor,
          height: 1.2,
          letterSpacing: -0.35,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: textColor,
          height: 1.28,
          letterSpacing: -0.2,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: textColor,
          height: 1.24,
          letterSpacing: -0.15,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
          height: 1.42,
          letterSpacing: -0.12,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: secondary,
          height: 1.42,
          letterSpacing: -0.08,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: secondary,
          height: 1.35,
          letterSpacing: -0.05,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: textColor,
          letterSpacing: -0.15,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: secondary,
          letterSpacing: -0.05,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: secondary,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
