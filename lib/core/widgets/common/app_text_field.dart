import 'package:flutter/material.dart';
import '../../constants/app_dimens.dart';
import '../../theme/theme.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isObscure;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final void Function(String)? onChanged;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.labelM.copyWith(color: AppPalette.textSecondary),
          ),
          const SizedBox(height: AppDimens.spacingS),
        ],
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          onChanged: onChanged,
          style: AppTextStyles.bodyM,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodyM.copyWith(color: AppPalette.textDisabled),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppPalette.textSecondary) : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.light 
                ? AppPalette.natural.shade100 
                : AppPalette.surfaceDark,
            contentPadding: const EdgeInsets.all(AppDimens.spacingM),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusM),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusM),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusM),
              borderSide: const BorderSide(color: AppPalette.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusM),
              borderSide: const BorderSide(color: AppPalette.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
