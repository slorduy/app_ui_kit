// lib/src/components/buttons/app_button.dart
import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  });

  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.outline({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : variant = AppButtonVariant.outline;

  const AppButton.ghost({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : variant = AppButtonVariant.ghost;

  const AppButton.danger({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  }) : variant = AppButtonVariant.danger;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDisabled = onPressed == null || isLoading;

    // 💡 Colores de fondo por variante
    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case AppButtonVariant.primary:
        backgroundColor = AppColors.primary500;
        foregroundColor = AppColors.white;
        break;
      case AppButtonVariant.secondary:
        backgroundColor = isDark ? AppColors.neutral700 : AppColors.neutral200;
        foregroundColor = isDark ? AppColors.white : AppColors.neutral900;
        break;
      case AppButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = isDark ? AppColors.white : AppColors.primary500;
        borderSide = BorderSide(
          color: isDark ? AppColors.cardBorderDark : AppColors.primary500,
          width: 1.5,
        );
        break;
      case AppButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        // 💡 En Dark Mode el texto pasa a ser blanco/claro
        foregroundColor = isDark
            ? AppColors.textPrimaryDark
            : AppColors.primary500;
        break;
      case AppButtonVariant.danger:
        backgroundColor = AppColors.error;
        foregroundColor = AppColors.white;
        break;
    }

    if (isDisabled) {
      backgroundColor = isDark ? AppColors.neutral800 : AppColors.neutral200;
      foregroundColor = isDark
          ? AppColors.textDisabledDark
          : AppColors.textDisabledLight;
      borderSide = BorderSide.none;
    }

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          AppLoader.small(color: foregroundColor),
          const SizedBox(width: AppSpacing.sm),
        ] else if (icon != null) ...[
          IconTheme(
            data: IconThemeData(color: foregroundColor, size: 18),
            child: icon!,
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 48.0, // Altura táctil estándar para mobile
      child: OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        child: content,
      ),
    );
  }
}
