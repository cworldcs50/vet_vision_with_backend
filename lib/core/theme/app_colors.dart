import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF009689);
  static const Color primaryLight = Color(0xFFE0F2F1);
  static const Color primaryDark = Color(0xFF00796B);
  static const Color accent = Color(0xFF00BBA7);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color authBackground = Color(0xFFEFFEFD);
  static const Color surface = Color(0xFFF8F9FA);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1C1E);
  static const Color textSecondary = Color(0xFF6A7282);
  static const Color textTertiary = Color(0xFF9EA5AD);
  static const Color textLight = Color(0xFFFFFFFF);

  // Semantic Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color info = Color(0xFF0288D1);

  // Neutral / Border
  static const Color border = Color(0xFFE1E2E5);
  static const Color divider = Color(0xFFF1F3F4);
  static const Color shadow = Color(0x1A000000);

  // Legacy (Keeping for compatibility during refactor if needed)
  static const Color primaryColor = primary;
  static const Color textColor = textLight;
  static const Color backgroundColor = background;
  static const Color authBackgroundColor = authBackground;
}

