import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import 'app_radio_button.dart';

/// Modelo de datos para las opciones dentro del grupo
class AppRadioOption<T> {
  final T value;
  final String label;
  final String? description;
  final bool isDisabled;

  const AppRadioOption({
    required this.value,
    required this.label,
    this.description,
    this.isDisabled = false,
  });
}

class AppRadioGroup<T> extends StatelessWidget {
  final String? title;
  final T? groupValue;
  final List<AppRadioOption<T>> options;
  final ValueChanged<T?>? onChanged;

  const AppRadioGroup({
    super.key,
    this.title,
    required this.groupValue,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final titleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        ...options.map(
          (option) => AppRadioButton<T>(
            value: option.value,
            groupValue: groupValue,
            onChanged: option.isDisabled ? null : onChanged,
            label: option.label,
            description: option.description,
            isDisabled: option.isDisabled,
          ),
        ),
      ],
    );
  }
}
