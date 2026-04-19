import 'package:flutter/material.dart';

abstract final class AppPalette {
  const AppPalette._();

  // =========================
  // PRIMARY (Coral / Orange)
  // =========================
  static const int _primaryColorValue = 0xFFF97350;
  static const MaterialColor primary = MaterialColor(
    _primaryColorValue, // Here is primary value color
    <int, Color>{
      50: Color(0xFFFFF3EF), // Shade50
      100: Color(0xFFFFE4DC), // Shade100
      200: Color(0xFFFFCCBC), // Shade200
      300: Color(0xFFFFAB91), // Shade300
      400: Color(0xFFFF8A65), // Shade400
      500: Color(_primaryColorValue), // Shade500 is similar to Primary
      600: Color(0xFFF4511E), // Shade600
      700: Color(0xFFE64A19), // Shade700
      800: Color(0xFFD84315), // Shade800
      900: Color(0xFFBF360C), // Shade900
    },
  );

  static const onPrimary = Colors.white;

  // =========================
  // BACKGROUNDS
  // =========================
  static const backgroundLight = Color(0xFFF6F8FB);
  static const backgroundDark = Color(0xFF1C1C26);

  // =========================
  // SURFACE / CARDS
  // =========================
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF111117);

  static const cardLight = Color(0xFFFFFFFF);
  static const cardDark = Color(0xFF111827);

  // =========================
  // TEXT COLORS
  // =========================
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const textDisabled = Color(0xFF9CA3AF);
  static const textWhite = Colors.white;

  // =========================
  // NEUTRAL SCALE
  // =========================
  static const int _naturalColorValue = 0xFF9CA3AF;
  static const MaterialColor natural = MaterialColor(
    _naturalColorValue, // Here is primary value color
    <int, Color>{
      50: Color(0xFFF9FAFB), // Shade50
      100: Color(0xFFF3F4F6), // Shade100
      200: Color(0xFFE5E7EB), // Shade200
      300: Color(0xFFD1D5DB), // Shade300
      400: Color(_naturalColorValue), // Shade400
      500: Color(0xFF6B7280), // Shade500 is similar to Primary
      600: Color(0xFF4B5563), // Shade600
      700: Color(0xFF374151), // Shade700
      800: Color(0xFF1F2937), // Shade800
      900: Color(0xFF111827), // Shade900
    },
  );

  // =========================
  // STATUS COLORS
  // =========================
  static const success = Color(0xFF22C55E);
  static const successLight = Color(0xFFD1FAE5);

  static const error = Color(0xFFEF4444);
  static const errorLight = Color(0xFFFEE2E2);

  static const warning = Color(0xFFF59E0B);
  static const warningLight = Color(0xFFFEF3C7);

  // =========================
  // UI ELEMENTS
  // =========================
  static const divider = Color(0xFFE5E7EB);
  static const border = Color(0xFFE5E7EB);
  static const disabled = Color(0xFFD1D5DB);

  // =========================
  // OVERLAYS
  // =========================
  static const overlayLight = Color(0x14000000);
  static const overlayDark = Color(0x33FFFFFF);

  // =========================
  // CHART / CATEGORY COLORS
  // =========================
  static const chartBlue = Color(0xFF60A5FA);
  static const chartPurple = Color(0xFFA78BFA);
  static const chartPink = Color(0xFFF472B6);
  static const chartTeal = Color(0xFF2DD4BF);
  static const chartYellow = Color(0xFFFBBF24);
  static const chartGreen = Color(0xFF34D399);

  // =========================
// CATEGORY COLORS
// =========================

  static const orange = Color(0xFFFF8A65);
  static const deepOrange = Color(0xFFFF7043);
  static const coral = Color(0xFFFF6F61);

  static const red = Color(0xFFEF5350);
  static const rose = Color(0xFFE57373);

  static const pink = Color(0xFFEC407A);
  static const hotPink = Color(0xFFD81B60);

  static const purple = Color(0xFFAB47BC);
  static const deepPurple = Color(0xFF7E57C2);
  static const violet = Color(0xFF8E24AA);

  static const indigo = Color(0xFF5C6BC0);

  static const blue = Color(0xFF42A5F5);
  static const lightBlue = Color(0xFF29B6F6);
  static const skyBlue = Color(0xFF4FC3F7);

  static const cyan = Color(0xFF26C6DA);
  static const aqua = Color(0xFF00ACC1);

  static const teal = Color(0xFF26A69A);
  static const mint = Color(0xFF2DD4BF);

  static const green = Color(0xFF66BB6A);
  static const emerald = Color(0xFF10B981);

  static const lightGreen = Color(0xFF9CCC65);
  static const lime = Color(0xFFD4E157);

  static const yellow = Color(0xFFFFEB3B);
  static const amber = Color(0xFFFFB300);
  static const gold = Color(0xFFFFC107);

  static const brown = Color(0xFF8D6E63);
  static const chocolate = Color(0xFF6D4C41);

  static const gray = Color(0xFF90A4AE);
  static const slate = Color(0xFF64748B);
}
