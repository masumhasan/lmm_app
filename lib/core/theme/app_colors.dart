import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color bg = Color(0xFFF8F9FA);
  static const Color ink = Color(0xFF121212);
  static const Color accent = Color(0xFF1A1F36); // Deep navy
  static const Color neutral = Color(0xFF64748B);
  static const Color line = Color(0xFFE2E8F0);
  static const Color error = Color(0xFF991B1B);
  static const Color surface = Color(0xFFFFFFFF);
  
  // Opacity variations
  static Color inkWithOpacity(double opacity) => ink.withOpacity(opacity);
  static Color accentWithOpacity(double opacity) => accent.withOpacity(opacity);
}
