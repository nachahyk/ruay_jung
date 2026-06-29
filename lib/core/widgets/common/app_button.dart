import 'package:flutter/material.dart';
import '../../constants/app_dimens.dart';
import '../../theme/theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isPrimary;
  final double? width;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isPrimary = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: width ?? double.infinity,
      height: AppDimens.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppPalette.primary : AppPalette.surfaceLight,
          foregroundColor: isPrimary ? AppPalette.onPrimary : AppPalette.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            side: isPrimary ? BorderSide.none : const BorderSide(color: AppPalette.primary),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: AppTextStyles.labelL.copyWith(
                  color: isPrimary ? AppPalette.onPrimary : AppPalette.primary,
                ),
              ),
      ),
    );
  }
}
