import 'package:flutter/material.dart';

abstract class AppColors {
  // ==========================================
  // 1. PRIMARIOS & MARCA
  // ==========================================
  static const Color primary500 = Color(0xFF6200EE);
  static const Color primary700 = Color(0xFF3700B3);

  // ==========================================
  // 2. NEUTROS
  // ==========================================
  static const Color white = Color(0xFFFFFFFF);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF424242);
  static const Color neutral800 = Color(0xFF2C2C2C);
  static const Color neutral850 = Color(0xFF242424);
  static const Color neutral900 = Color(0xFF121212);
  static const Color black = Color(0xFF000000);

  // ==========================================
  // 3. FEEDBACK BASE
  // ==========================================
  static const Color error = Color(0xFFB00020);
  static const Color warning = Color(0xFFFFFBEB);
  static const Color success = Color(0xFFECFDF5);
  static const Color info = Color(0xFFE3F2FD);

  // ==========================================
  // 4. BANNERS & ALERTS - LIGHT MODE
  // ==========================================
  static const Color bannerInfoBgLight = Color(0xFFE3F2FD);
  static const Color bannerInfoContentLight = Color(0xFF1565C0);

  static const Color bannerSuccessBgLight = Color(0xFFE8F5E9);
  static const Color bannerSuccessContentLight = Color(0xFF2E7D32);

  static const Color bannerWarningBgLight = Color(0xFFFFF3E0);
  static const Color bannerWarningContentLight = Color(0xFFE65100);

  static const Color bannerErrorBgLight = Color(0xFFFFEBEE);
  static const Color bannerErrorContentLight = error;

  // ==========================================
  // 5. BANNERS & ALERTS - DARK MODE
  // ==========================================
  static const Color bannerInfoBgDark = Color(0xFF0D253F);
  static const Color bannerInfoContentDark = Color(0xFF64B5F6);

  static const Color bannerSuccessBgDark = Color(0xFF0B2E1B);
  static const Color bannerSuccessContentDark = Color(0xFF81C784);

  static const Color bannerWarningBgDark = Color(0xFF331E00);
  static const Color bannerWarningContentDark = Color(0xFFFFB74D);

  static const Color bannerErrorBgDark = Color(0xFF3B0B11);
  static const Color bannerErrorContentDark = Color(0xFFE57373);

  // ==========================================
  // 6. TOKENS SEMÁNTICOS DE COMPONENTES
  // ==========================================
  static const Color cardFlatLight = neutral100;
  static const Color cardFlatDark = neutral850;

  static const Color cardElevatedLight = white;
  static const Color cardElevatedDark = neutral800;

  static const Color cardBorderLight = neutral300;
  static const Color cardBorderDark = Color(0x3DFFFFFF);

  static const Color inputFillLight = neutral100;
  static const Color inputFillDark = neutral800;

  static const Color inputDisabledFillLight = neutral200;
  static const Color inputDisabledFillDark = Color(0xFF1A1A1A);

  static const Color textPrimaryLight = neutral900;
  static const Color textPrimaryDark = white;

  static const Color textSecondaryLight = neutral600;
  static const Color textSecondaryDark = neutral400;

  static const Color textDisabledLight = neutral400;
  static const Color textDisabledDark = neutral600;
}
