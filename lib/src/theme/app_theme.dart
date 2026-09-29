import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ruay_jung/src/theme/app_colors.dart';

/// Builds Ruay Jung's `ThemeData` for a given [AppColors] set — [light] and
/// [dark] below are the two the app actually switches between.
abstract class AppTheme {
  const AppTheme._();

  static final light = _build(AppColors.light, Brightness.light);
  static final dark = _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors colors, Brightness brightness) {
    final base = GoogleFonts.workSansTextTheme(
      brightness == Brightness.light ? ThemeData.light().textTheme : ThemeData.dark().textTheme,
    ).apply(
      bodyColor: colors.onCover,
      displayColor: colors.onCover,
    );

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: colors.cover,
      canvasColor: colors.cover,
      fontFamily: GoogleFonts.workSans().fontFamily,
      fontFamilyFallback: const ['Noto Sans Thai'],
      textTheme: base,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colors.gold,
        onPrimary: colors.ink,
        secondary: colors.emerald,
        onSecondary: colors.onCover,
        error: colors.clay,
        onError: colors.onCover,
        surface: colors.page,
        onSurface: colors.ink,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.cover,
        foregroundColor: colors.onCover,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: colors.page,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.page,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        titleTextStyle: TextStyle(color: colors.ink, fontSize: 17, fontWeight: FontWeight.w700),
        contentTextStyle: TextStyle(color: colors.inkMuted, fontSize: 14),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.page,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.pageCard,
        labelStyle: TextStyle(color: colors.inkMuted),
        hintStyle: TextStyle(color: colors.inkFaint),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: colors.pageLine)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: colors.pageLine)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: colors.gold, width: 1.5)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.gold,
          foregroundColor: colors.ink,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.goldBright,
          side: BorderSide(color: colors.goldBright, width: 1.5),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12.5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colors.goldBright),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.gold,
        foregroundColor: colors.ink,
        shape: const CircleBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.coverDeep,
        selectedItemColor: colors.goldBright,
        unselectedItemColor: colors.onCoverMuted,
        type: BottomNavigationBarType.fixed,
      ),
      dividerTheme: DividerThemeData(color: colors.pageLine, space: 1),
      extensions: [colors],
    );
  }
}
