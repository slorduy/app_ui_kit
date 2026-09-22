// lib/src/components/loaders/app_loader.dart
import 'package:app_ui_kit/app_ui_kit.dart'
    show AppLoaderSize, AppColors, AppLoaderVariant;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final AppLoaderSize size;
  final AppLoaderVariant variant;
  final Color? color;
  final Color? backgroundColor;
  final double? value;
  final double? strokeWidth;

  const AppLoader({
    super.key,
    this.size = AppLoaderSize.medium,
    this.variant = AppLoaderVariant.primary,
    this.color,
    this.backgroundColor,
    this.value,
    this.strokeWidth,
  });

  const AppLoader.small({
    super.key,
    this.variant = AppLoaderVariant.primary,
    this.color,
    this.backgroundColor,
    this.value,
    this.strokeWidth,
  }) : size = AppLoaderSize.small;

  const AppLoader.large({
    super.key,
    this.variant = AppLoaderVariant.primary,
    this.color,
    this.backgroundColor,
    this.value,
    this.strokeWidth,
  }) : size = AppLoaderSize.large;

  const AppLoader.onPrimary({
    super.key,
    this.size = AppLoaderSize.medium,
    this.value,
    this.strokeWidth,
  }) : variant = AppLoaderVariant.onPrimary,
       color = null,
       backgroundColor = null;

  const AppLoader.neutral({
    super.key,
    this.size = AppLoaderSize.medium,
    this.value,
    this.strokeWidth,
  }) : variant = AppLoaderVariant.neutral,
       color = null,
       backgroundColor = null;

  double get _dimension {
    switch (size) {
      case AppLoaderSize.small:
        return 16.0;
      case AppLoaderSize.medium:
        return 28.0;
      case AppLoaderSize.large:
        return 44.0;
    }
  }

  double get _defaultStrokeWidth {
    switch (size) {
      case AppLoaderSize.small:
        return 2.0;
      case AppLoaderSize.medium:
        return 3.0;
      case AppLoaderSize.large:
        return 4.0;
    }
  }

  Color _resolveColor(bool isDark) {
    if (color != null) return color!;

    switch (variant) {
      case AppLoaderVariant.primary:
        // En Dark Mode, si el color primario es muy oscuro, usamos una versión más clara/vibrante
        return isDark ? const Color(0xFFBB86FC) : AppColors.primary500;
      case AppLoaderVariant.secondary:
        return isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight;
      case AppLoaderVariant.onPrimary:
        return AppColors.white;
      case AppLoaderVariant.neutral:
        return isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveColor = _resolveColor(isDark);
    final isIos = theme.platform == TargetPlatform.iOS;

    return SizedBox(
      width: _dimension,
      height: _dimension,
      child: isIos && value == null
          ? CupertinoTheme(
              data: CupertinoTheme.of(context)
                  .copyWith(primaryColor: effectiveColor),
              child: CupertinoActivityIndicator(
                radius: _dimension / 2,
                color: effectiveColor, // Force color en iOS
              ),
            )
          : CircularProgressIndicator(
              value: value,
              strokeWidth: strokeWidth ?? _defaultStrokeWidth,
              backgroundColor: backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            ),
    );
  }
}
