import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:app_ui_kit/src/enums/App_text_variant.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  });

  // --- Constructores nombrados convenientes ---
  const AppText.displayLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.displayLarge;

  const AppText.headlineLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.headlineLarge;

  const AppText.headlineMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.headlineMedium;

  const AppText.titleLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.titleLarge;

  const AppText.titleMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.titleMedium;

  const AppText.bodyLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.bodyLarge;

  const AppText.bodyMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.bodyMedium;

  const AppText.bodySmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.bodySmall;

  const AppText.labelLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.labelLarge;

  const AppText.labelSmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  }) : variant = AppTextVariant.labelSmall;

  TextStyle _getStyle() {
    switch (variant) {
      case AppTextVariant.displayLarge:
        return AppTypography.displayLarge;
      case AppTextVariant.displayMedium:
        return AppTypography.displayMedium;
      case AppTextVariant.headlineLarge:
        return AppTypography.headlineLarge;
      case AppTextVariant.headlineMedium:
        return AppTypography.headlineMedium;
      case AppTextVariant.headlineSmall:
        return AppTypography.headlineSmall;
      case AppTextVariant.titleLarge:
        return AppTypography.titleLarge;
      case AppTextVariant.titleMedium:
        return AppTypography.titleMedium;
      case AppTextVariant.titleSmall:
        return AppTypography.titleSmall;
      case AppTextVariant.bodyLarge:
        return AppTypography.bodyLarge;
      case AppTextVariant.bodyMedium:
        return AppTypography.bodyMedium;
      case AppTextVariant.bodySmall:
        return AppTypography.bodySmall;
      case AppTextVariant.labelLarge:
        return AppTypography.labelLarge;
      case AppTextVariant.labelMedium:
        return AppTypography.labelMedium;
      case AppTextVariant.labelSmall:
        return AppTypography.labelSmall;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _getStyle().copyWith(color: color, fontWeight: fontWeight);

    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
