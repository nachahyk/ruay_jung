import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.primaryText,
    required this.errorText,
  });

  final Color background;
  final Color primaryText;
  final Color errorText;

  @override
  AppColors copyWith({
    Color? backgroundContainer,
    Color? primaryText,
    Color? errorText,
    Color? primaryButton,
  }) {
    return AppColors(
      background: backgroundContainer ?? this.background,
      primaryText: primaryText ?? this.primaryText,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(
        background,
        other.background,
        t,
      )!,
      primaryText: Color.lerp(
        primaryText,
        other.primaryText,
        t,
      )!,
      errorText: Color.lerp(
        errorText,
        other.errorText,
        t,
      )!,
    );
  }
}