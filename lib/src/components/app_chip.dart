import 'package:app_ui_kit/src/tokens/app_colors.dart';
import 'package:app_ui_kit/src/tokens/app_spacing.dart';
import 'package:app_ui_kit/src/tokens/app_typography.dart';
import 'package:flutter/material.dart';

enum AppChipVariant { filter, action, deletable, status }

class AppChip extends StatelessWidget {
  final String label;
  final AppChipVariant variant;
  final bool isSelected;
  final VoidCallback? onPressed;
  final VoidCallback? onDeleted;
  final Widget? avatar;
  final Color? backgroundColor;
  final Color? labelColor;

  const AppChip({
    super.key,
    required this.label,
    this.variant = AppChipVariant.action,
    this.isSelected = false,
    this.onPressed,
    this.onDeleted,
    this.avatar,
    this.backgroundColor,
    this.labelColor,
  });

  // Constructores nombrados convenientes
  const AppChip.filter({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    this.avatar,
  }) : variant = AppChipVariant.filter,
       onDeleted = null,
       backgroundColor = null,
       labelColor = null;

  const AppChip.action({
    super.key,
    required this.label,
    required this.onPressed,
    this.avatar,
  }) : variant = AppChipVariant.action,
       isSelected = false,
       onDeleted = null,
       backgroundColor = null,
       labelColor = null;

  const AppChip.deletable({
    super.key,
    required this.label,
    required this.onDeleted,
    this.avatar,
  }) : variant = AppChipVariant.deletable,
       isSelected = false,
       onPressed = null,
       backgroundColor = null,
       labelColor = null;

  const AppChip.status({
    super.key,
    required this.label,
    this.backgroundColor,
    this.labelColor,
    this.avatar,
  }) : variant = AppChipVariant.status,
       isSelected = false,
       onPressed = null,
       onDeleted = null;

  @override
  Widget build(BuildContext context) {
    // Definición de colores dinámicos
    final Color effectiveBgColor;
    final Color effectiveLabelColor;

    if (variant == AppChipVariant.status) {
      effectiveBgColor = backgroundColor ?? AppColors.neutral100;
      effectiveLabelColor = labelColor ?? AppColors.neutral900;
    } else if (isSelected) {
      effectiveBgColor = AppColors.primary500;
      effectiveLabelColor = Colors.white;
    } else {
      effectiveBgColor = AppColors.neutral100;
      effectiveLabelColor = AppColors.neutral900;
    }

    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(16.0),
        border: (variant == AppChipVariant.filter && !isSelected)
            ? Border.all(color: Colors.grey.shade300)
            : Border.all(color: Colors.transparent),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap:
              (variant == AppChipVariant.filter ||
                  variant == AppChipVariant.action)
              ? onPressed
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 4.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (avatar != null) ...[
                  avatar!,
                  const SizedBox(width: AppSpacing.xs),
                ],
                if (variant == AppChipVariant.filter && isSelected) ...[
                  Icon(Icons.check, size: 16, color: effectiveLabelColor),
                  const SizedBox(width: 4),
                ],
                Text(
                  label,
                  style: AppTypography.labelSmall.copyWith(
                    color: effectiveLabelColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                if (variant == AppChipVariant.deletable &&
                    onDeleted != null) ...[
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: onDeleted,
                    child: Icon(
                      Icons.cancel,
                      size: 16,
                      color: effectiveLabelColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
