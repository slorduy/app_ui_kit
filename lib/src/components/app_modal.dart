import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

class AppModal extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? content;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final bool isPrimaryLoading;

  const AppModal({
    super.key,
    this.title,
    this.description,
    this.content,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.isPrimaryLoading = false,
  });

  /// Método helper estático para desplegar el modal adaptable al tema activo
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? description,
    Widget? content,
    String? primaryActionLabel,
    VoidCallback? onPrimaryAction,
    String? secondaryActionLabel,
    VoidCallback? onSecondaryAction,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      // 💡 Fondo semántico adaptable al tema
      backgroundColor: isDark ? AppColors.neutral800 : AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AppModal(
          title: title,
          description: description,
          content: content,
          primaryActionLabel: primaryActionLabel,
          onPrimaryAction: onPrimaryAction,
          secondaryActionLabel: secondaryActionLabel,
          onSecondaryAction: onSecondaryAction,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primaryTextColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final secondaryTextColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final dragHandleColor = isDark
        ? AppColors.neutral700
        : AppColors.neutral300;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Indicador de arrastre (Drag Handle)
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: dragHandleColor,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Título
            if (title != null) ...[
              Text(
                title!,
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
            ],

            // Descripción corta
            if (description != null) ...[
              Text(
                description!,
                style: AppTypography.bodyMedium.copyWith(
                  color: secondaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
            ],

            // Contenido personalizado opcional
            if (content != null) ...[
              Flexible(child: content!),
              const SizedBox(height: AppSpacing.md),
            ],

            // Acciones/Botones
            // En lib/src/components/modals/app_modal.dart:

            // Acciones/Botones
            if (primaryActionLabel != null || secondaryActionLabel != null) ...[
              const SizedBox(height: AppSpacing.sm),
              if (primaryActionLabel != null)
                AppButton.primary(
                  label: primaryActionLabel!,
                  isFullWidth: true,
                  isLoading: isPrimaryLoading,
                  onPressed:
                      onPrimaryAction ?? () => Navigator.of(context).pop(),
                ),
              if (secondaryActionLabel != null) ...[
                const SizedBox(height: AppSpacing.xs),
                AppButton.ghost(
                  label: secondaryActionLabel!,
                  isFullWidth: true,
                  onPressed:
                      onSecondaryAction ?? () => Navigator.of(context).pop(),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
