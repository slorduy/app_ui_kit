import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

class AppRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? description;
  final bool isDisabled;

  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.description,
    this.isDisabled = false,
  });

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // 💡 Asignación semántica de colores según el tema
    final primaryTextColor = isDisabled
        ? (isDark ? AppColors.textDisabledDark : AppColors.textDisabledLight)
        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);

    final descriptionTextColor = isDisabled
        ? (isDark ? AppColors.textDisabledDark : AppColors.textDisabledLight)
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    return InkWell(
      onTap: (isDisabled || onChanged == null) ? null : () => onChanged!(value),
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.xs,
        ),
        child: Row(
          crossAxisAlignment: description != null
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Radio<T>(
                value: value,
                groupValue: groupValue,
                onChanged: isDisabled ? null : onChanged,
                activeColor: AppColors.primary500,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            if (label != null || description != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (label != null)
                      Text(
                        label!,
                        style: AppTypography.bodyMedium.copyWith(
                          color: primaryTextColor,
                          fontWeight: _isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    if (description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        description!,
                        style: AppTypography.bodySmall.copyWith(
                          color: descriptionTextColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
