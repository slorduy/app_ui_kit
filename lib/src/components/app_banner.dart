import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

enum AppBannerType { info, success, warning, error }

class AppBanner extends StatelessWidget {
  final String title;
  final String? description;
  final AppBannerType type;
  final VoidCallback? onClose;
  final Widget? action;

  const AppBanner({
    super.key,
    required this.title,
    this.description,
    this.type = AppBannerType.info,
    this.onClose,
    this.action,
  });

  const AppBanner.info({
    super.key,
    required this.title,
    this.description,
    this.onClose,
    this.action,
  }) : type = AppBannerType.info;

  const AppBanner.success({
    super.key,
    required this.title,
    this.description,
    this.onClose,
    this.action,
  }) : type = AppBannerType.success;

  const AppBanner.warning({
    super.key,
    required this.title,
    this.description,
    this.onClose,
    this.action,
  }) : type = AppBannerType.warning;

  const AppBanner.error({
    super.key,
    required this.title,
    this.description,
    this.onClose,
    this.action,
  }) : type = AppBannerType.error;

  Color _getBackgroundColor(bool isDark) {
    if (isDark) {
      switch (type) {
        case AppBannerType.info:
          return AppColors.bannerInfoBgDark;
        case AppBannerType.success:
          return AppColors.bannerSuccessBgDark;
        case AppBannerType.warning:
          return AppColors.bannerWarningBgDark;
        case AppBannerType.error:
          return AppColors.bannerErrorBgDark;
      }
    } else {
      switch (type) {
        case AppBannerType.info:
          return AppColors.bannerInfoBgLight;
        case AppBannerType.success:
          return AppColors.bannerSuccessBgLight;
        case AppBannerType.warning:
          return AppColors.bannerWarningBgLight;
        case AppBannerType.error:
          return AppColors.bannerErrorBgLight;
      }
    }
  }

  Color _getContentColor(bool isDark) {
    if (isDark) {
      switch (type) {
        case AppBannerType.info:
          return AppColors.bannerInfoContentDark;
        case AppBannerType.success:
          return AppColors.bannerSuccessContentDark;
        case AppBannerType.warning:
          return AppColors.bannerWarningContentDark;
        case AppBannerType.error:
          return AppColors.bannerErrorContentDark;
      }
    } else {
      switch (type) {
        case AppBannerType.info:
          return AppColors.bannerInfoContentLight;
        case AppBannerType.success:
          return AppColors.bannerSuccessContentLight;
        case AppBannerType.warning:
          return AppColors.bannerWarningContentLight;
        case AppBannerType.error:
          return AppColors.bannerErrorContentLight;
      }
    }
  }

  IconData get _icon {
    switch (type) {
      case AppBannerType.info:
        return Icons.info_outline;
      case AppBannerType.success:
        return Icons.check_circle_outline;
      case AppBannerType.warning:
        return Icons.warning_amber_outlined;
      case AppBannerType.error:
        return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = _getBackgroundColor(isDark);
    final contentColor = _getContentColor(isDark);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: contentColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_icon, color: contentColor, size: 22),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.titleMedium.copyWith(
                        color: contentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        description!,
                        style: AppTypography.bodyMedium.copyWith(
                          color: contentColor.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onClose != null)
                GestureDetector(
                  onTap: onClose,
                  child: Icon(Icons.close, size: 20, color: contentColor),
                ),
            ],
          ),
          if (action != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Align(alignment: Alignment.centerRight, child: action!),
          ],
        ],
      ),
    );
  }
}
