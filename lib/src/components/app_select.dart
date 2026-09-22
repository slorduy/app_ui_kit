import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

/// Estructura de cada opción dentro del Select
class AppSelectItem<T> {
  final T value;
  final String label;
  final Widget? icon;

  const AppSelectItem({required this.value, required this.label, this.icon});
}

class AppSelect<T> extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? errorText;
  final T? value;
  final List<AppSelectItem<T>> items;
  final ValueChanged<T>? onChanged;
  final bool isDisabled;
  final Widget? prefixIcon;

  const AppSelect({
    super.key,
    this.label,
    this.hintText,
    this.errorText,
    this.value,
    required this.items,
    this.onChanged,
    this.isDisabled = false,
    this.prefixIcon,
  });

  // Muestra el selector modal optimizado para Mobile
  void _showBottomSheet(BuildContext context) {
    if (isDisabled) return;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final optionTextColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final dividerColor = isDark ? AppColors.neutral700 : AppColors.neutral300;

    AppModal.show(
      context: context,
      title: label ?? 'Seleccionar opción',
      content: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => Divider(height: 1, color: dividerColor),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = item.value == value;

          return ListTile(
            leading: item.icon != null
                ? IconTheme(
                    data: IconThemeData(
                      color: isSelected
                          ? AppColors.primary500
                          : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                      size: 20,
                    ),
                    child: item.icon!,
                  )
                : null,
            title: Text(
              item.label,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                color: isSelected ? AppColors.primary500 : optionTextColor,
              ),
            ),
            trailing: isSelected
                ? const Icon(Icons.check, color: AppColors.primary500)
                : null,
            onTap: () {
              Navigator.of(context).pop();
              if (onChanged != null) {
                onChanged!(item.value);
              }
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Asignación de colores semánticos desde AppColors
    final primaryTextColor = isDisabled
        ? (isDark ? AppColors.textDisabledDark : AppColors.textDisabledLight)
        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);

    final hintTextColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    final iconColor = isDisabled
        ? (isDark ? AppColors.textDisabledDark : AppColors.textDisabledLight)
        : hintTextColor;

    final backgroundColor = isDisabled
        ? (isDark
              ? AppColors.inputDisabledFillDark
              : AppColors.inputDisabledFillLight)
        : (isDark ? AppColors.inputFillDark : AppColors.inputFillLight);

    // Busca la etiqueta correspondiente al valor seleccionado
    final selectedItem = items.cast<AppSelectItem<T>?>().firstWhere(
      (item) => item?.value == value,
      orElse: () => null,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label superior
        if (label != null) ...[
          Text(
            label!,
            style: AppTypography.labelMedium.copyWith(color: primaryTextColor),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],

        // Campo Táctil que simula un Input
        InkWell(
          onTap: isDisabled ? null : () => _showBottomSheet(context),
          borderRadius: BorderRadius.circular(8.0),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTypography.bodyMedium.copyWith(
                color: hintTextColor,
              ),
              errorText: errorText,
              errorStyle: AppTypography.bodySmall.copyWith(
                color: AppColors.error,
              ),
              prefixIcon: prefixIcon != null
                  ? IconTheme(
                      data: IconThemeData(color: iconColor, size: 20),
                      child: prefixIcon!,
                    )
                  : null,
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: iconColor,
              ),
              filled: true,
              fillColor: backgroundColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: AppColors.error, width: 1.0),
              ),
            ),
            child: Text(
              selectedItem?.label ?? hintText ?? '',
              style: AppTypography.bodyMedium.copyWith(
                color: selectedItem != null ? primaryTextColor : hintTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
