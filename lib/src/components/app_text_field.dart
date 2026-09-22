import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isPassword;
  final bool isDisabled;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
    this.isDisabled = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.focusNode,
  });

  factory AppTextField.password({
    Key? key,
    String? label = 'Contraseña',
    String? hintText = '••••••••',
    String? errorText,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    TextInputAction textInputAction = TextInputAction.done,
    bool isDisabled = false,
  }) {
    return AppTextField(
      key: key,
      label: label,
      hintText: hintText,
      errorText: errorText,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      isPassword: true,
      isDisabled: isDisabled,
      maxLines: 1,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // 💡 Asignación de colores semánticos desde AppColors
    final primaryTextColor = widget.isDisabled
        ? (isDark ? AppColors.textDisabledDark : AppColors.textDisabledLight)
        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);

    final hintTextColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    final secondaryIconColor = widget.isDisabled
        ? (isDark ? AppColors.textDisabledDark : AppColors.textDisabledLight)
        : hintTextColor;

    final backgroundColor = widget.isDisabled
        ? (isDark
              ? AppColors.inputDisabledFillDark
              : AppColors.inputDisabledFillLight)
        : (isDark ? AppColors.inputFillDark : AppColors.inputFillLight);

    // Botón para alternar visibilidad en contraseñas
    Widget? suffix;
    if (widget.isPassword) {
      suffix = IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: secondaryIconColor,
        ),
        onPressed: widget.isDisabled ? null : _toggleObscure,
      );
    } else {
      suffix = widget.suffixIcon;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label superior
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTypography.labelMedium.copyWith(color: primaryTextColor),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],

        // Input principal
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          enabled: !widget.isDisabled,
          readOnly: widget.readOnly,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          style: AppTypography.bodyMedium.copyWith(color: primaryTextColor),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTypography.bodyMedium.copyWith(color: hintTextColor),
            helperText: widget.helperText,
            helperStyle: AppTypography.bodySmall.copyWith(color: hintTextColor),
            errorText: widget.errorText,
            errorStyle: AppTypography.bodySmall.copyWith(
              color: AppColors.error,
            ),
            prefixIcon: widget.prefixIcon != null
                ? IconTheme(
                    data: IconThemeData(color: secondaryIconColor, size: 20),
                    child: widget.prefixIcon!,
                  )
                : null,
            suffixIcon: suffix != null
                ? IconTheme(
                    data: IconThemeData(color: secondaryIconColor, size: 20),
                    child: suffix,
                  )
                : null,
            filled: true,
            fillColor: backgroundColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),

            // Bordes adaptativos
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: AppColors.error, width: 1.0),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
