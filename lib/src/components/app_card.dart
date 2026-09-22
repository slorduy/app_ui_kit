import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:app_ui_kit/src/enums/app_card_variant.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.flat,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.width,
    this.height,
    this.borderRadius,
  });

  // Constructores nombrados para uso rápido
  const AppCard.flat({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.width,
    this.height,
    this.borderRadius,
  }) : variant = AppCardVariant.flat;

  const AppCard.outlined({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.width,
    this.height,
    this.borderRadius,
  }) : variant = AppCardVariant.outlined;

  const AppCard.elevated({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.width,
    this.height,
    this.borderRadius,
  }) : variant = AppCardVariant.elevated;

  // --- Mapeo de Colores de Fondo desde AppColors ---
  Color _getBackgroundColor(ThemeData theme, bool isDark) {
    if (backgroundColor != null) return backgroundColor!;

    switch (variant) {
      case AppCardVariant.flat:
        return isDark ? AppColors.cardFlatDark : AppColors.cardFlatLight;
      case AppCardVariant.outlined:
        return theme.scaffoldBackgroundColor;
      case AppCardVariant.elevated:
        return isDark
            ? AppColors.cardElevatedDark
            : AppColors.cardElevatedLight;
    }
  }

  // --- Mapeo de Bordes desde AppColors ---
  BorderSide _getBorderSide(bool isDark) {
    if (variant == AppCardVariant.outlined) {
      return BorderSide(
        color: isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight,
        width: 1.0,
      );
    }
    return BorderSide.none;
  }

  // --- Mapeo de Sombras ---
  List<BoxShadow>? _getBoxShadow(bool isDark) {
    if (variant == AppCardVariant.elevated && !isDark) {
      return [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.06),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(12.0);
    final effectivePadding = padding ?? const EdgeInsets.all(AppSpacing.md);

    final cardContent = Container(
      width: width,
      height: height,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: _getBackgroundColor(theme, isDark),
        borderRadius: effectiveRadius,
        border: Border.fromBorderSide(_getBorderSide(isDark)),
        boxShadow: _getBoxShadow(isDark),
      ),
      child: child,
    );

    // Si tiene acción de tap, añadimos feedback táctil
    if (onTap != null) {
      return ClipRRect(
        borderRadius: effectiveRadius,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: effectiveRadius as BorderRadius?,
            child: cardContent,
          ),
        ),
      );
    }

    return cardContent;
  }
}
