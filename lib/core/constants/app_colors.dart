import 'package:flutter/material.dart';

/// Centralized color palette matching the black + gold design.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF262626);      // text field fill
  static const Color surfaceLight = Color(0xFF333333);

  static const Color primary = Color(0xFFF6B119);       // gold / amber accent
  static const Color primaryDark = Color(0xFFCC8F0E);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textHint = Color(0xFF8A8A8A);

  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF4CAF50);
  static const Color divider = Color(0xFF2E2E2E);
}