import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get h1 => GoogleFonts.cormorantGaramond(
        fontSize: 40,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        letterSpacing: -0.5,
        color: AppColors.ink,
        height: 1.1,
      );

  static TextStyle get h2 => GoogleFonts.cormorantGaramond(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        letterSpacing: -0.3,
        color: AppColors.ink,
        height: 1.2,
      );

  static TextStyle get h3 => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        color: AppColors.inkWithOpacity(0.8),
      );

  static TextStyle get p => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.inkWithOpacity(0.7),
        height: 1.6,
      );

  static TextStyle get mono => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral,
      );

  static TextStyle get columnHeader => GoogleFonts.jetBrainsMono(
        fontSize: 9,
        fontWeight: FontWeight.w400,
        letterSpacing: 2.5,
        color: AppColors.inkWithOpacity(0.4),
      );

  static TextStyle get btnText => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.1,
        color: AppColors.surface,
      );
}
