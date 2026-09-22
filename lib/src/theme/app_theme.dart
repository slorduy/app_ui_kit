// lib/src/theme/ds_theme.dart
import 'package:app_ui_kit/src/tokens/app_colors.dart';
import 'package:app_ui_kit/src/tokens/app_typography.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static TextTheme get textTheme {
    return const TextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      headlineSmall: AppTypography.headlineSmall,
      titleLarge: AppTypography.titleLarge,
      titleMedium: AppTypography.titleMedium,
      titleSmall: AppTypography.titleSmall,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.labelLarge,
      labelMedium: AppTypography.labelMedium,
      labelSmall: AppTypography.labelSmall,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary500,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary500,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.neutral900,
    );
  }
}
