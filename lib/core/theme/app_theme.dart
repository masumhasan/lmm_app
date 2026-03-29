import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        background: AppColors.bg,
        onBackground: AppColors.ink,
        surface: AppColors.surface,
        onSurface: AppColors.ink,
        primary: AppColors.accent,
        onPrimary: AppColors.surface,
        secondary: AppColors.neutral,
        onSecondary: AppColors.surface,
        error: AppColors.error,
        onError: AppColors.surface,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.h1,
        headlineMedium: AppTypography.h2,
        titleSmall: AppTypography.h3,
        bodyLarge: AppTypography.p,
        bodyMedium: AppTypography.p.copyWith(fontSize: 14),
        labelSmall: AppTypography.columnHeader,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.surface,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.btnText,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.line,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
