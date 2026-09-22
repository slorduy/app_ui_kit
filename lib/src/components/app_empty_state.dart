import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String? description;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  const AppEmptyState.noData({
    super.key,
    this.title = 'No hay información',
    this.description = 'Aún no se han registrado datos en esta sección.',
    this.icon = Icons.folder_open_outlined,
    this.actionLabel,
    this.onAction,
  });

  const AppEmptyState.noResults({
    super.key,
    this.title = 'Sin resultados',
    this.description = 'No encontramos coincidencias para tu búsqueda.',
    this.icon = Icons.search_off_outlined,
    this.actionLabel = 'Limpiar búsqueda',
    this.onAction,
  });

  const AppEmptyState.error({
    super.key,
    this.title = 'Ocurrió un problema',
    this.description = 'No pudimos cargar la información. Inténtalo de nuevo.',
    this.icon = Icons.wifi_off_outlined,
    this.actionLabel = 'Reintentar',
    this.onAction,
  });

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
    final iconBgColor = isDark ? AppColors.neutral800 : AppColors.neutral100;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Contenedor circular con icono
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: secondaryTextColor),
            ),
            const SizedBox(height: AppSpacing.md),

            // Título
            Text(
              title,
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),

            // Descripción
            if (description != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                description!,
                style: AppTypography.bodyMedium.copyWith(
                  color: secondaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Botón de acción opcional
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton.secondary(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
