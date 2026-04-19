import 'package:flutter/material.dart';

import '../core.dart';

abstract final class AppTheme {
  AppTheme._();

  static final AppColors _lightColors = AppColors(
    background: AppPalette.backgroundLight,
    primaryText: AppPalette.textPrimary,
    errorText: AppPalette.error,
  );

  static final AppColors _darkColors = AppColors(
    background: AppPalette.backgroundDark,
    primaryText: AppPalette.textWhite,
    errorText: AppPalette.error,
  );

  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    extensions: <ThemeExtension<AppColors>>[_lightColors],
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.primary,
      primary: AppPalette.primary,
      onPrimary: AppPalette.onPrimary,
      primaryContainer: AppPalette.surfaceLight,
      onPrimaryContainer: AppPalette.primary,
      secondary: AppPalette.primary.shade200,
    ),
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    extensions: <ThemeExtension<AppColors>>[_darkColors],
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.primary,
      brightness: Brightness.dark,
      primary: AppPalette.primary,
      onPrimary: AppPalette.onPrimary,
      primaryContainer: AppPalette.surfaceDark,
      onPrimaryContainer: AppPalette.primary,
      secondary: AppPalette.natural.shade200,
    ),
  );
}
