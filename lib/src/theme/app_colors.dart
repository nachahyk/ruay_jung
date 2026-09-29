import 'package:flutter/material.dart';

/// Ruay Jung's palette — a "passbook" identity: gold as the single accent,
/// with cream "ledger pages" for cards/surfaces sitting on either a deep
/// pine-green cover ([dark]) or a white one ([light]).
///
/// Same [ThemeExtension] shape as Tiaw Jung's `AppColors` — look it up via
/// [AppColors.of] rather than referencing a static field directly, so every
/// widget repaints correctly on a light/dark switch.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.cover,
    required this.coverDeep,
    required this.page,
    required this.pageLine,
    required this.pageCard,
    required this.ink,
    required this.inkMuted,
    required this.inkFaint,
    required this.onCover,
    required this.onCoverMuted,
    required this.gold,
    required this.goldBright,
    required this.goldTint,
    required this.emerald,
    required this.emeraldTint,
    required this.clay,
    required this.clayTint,
  });

  final Color cover;
  final Color coverDeep;
  final Color page;
  final Color pageLine;
  final Color pageCard;

  final Color ink;
  final Color inkMuted;
  final Color inkFaint;
  final Color onCover;
  final Color onCoverMuted;

  final Color gold;
  final Color goldBright;
  final Color goldTint;

  /// Income / positive amounts.
  final Color emerald;
  final Color emeraldTint;

  /// Expense / negative amounts, and destructive actions.
  final Color clay;
  final Color clayTint;

  /// The original passbook world — a deep pine-green cover with cream ledger
  /// pages. Unchanged from Ruay Jung's original single-theme palette.
  static const dark = AppColors(
    cover: Color(0xFF16241E),
    coverDeep: Color(0xFF0E1813),
    page: Color(0xFFF7F1E1),
    pageLine: Color(0xFFE4D9B8),
    pageCard: Color(0xFFFFFCF3),
    ink: Color(0xFF1C2B24),
    inkMuted: Color(0xFF5C6B60),
    inkFaint: Color(0xFF8B9A8E),
    onCover: Color(0xFFF2ECD8),
    onCoverMuted: Color(0xFF9FAFA2),
    gold: Color(0xFFC9A227),
    goldBright: Color(0xFFE0BE49),
    goldTint: Color(0xFF3A331A),
    emerald: Color(0xFF2E8F63),
    emeraldTint: Color(0xFFDCEBE1),
    clay: Color(0xFFB4502E),
    clayTint: Color(0xFFF3DED2),
  );

  /// The daytime passbook — same ledger-cream identity, calibrated to sit
  /// near white instead of near black. Text painted straight onto the cover
  /// ([onCover]/[onCoverMuted]) switches to dark ink since the cover itself
  /// is no longer dark; [goldBright] goes deeper rather than brighter since
  /// contrast against a white cover comes from going darker.
  static const light = AppColors(
    cover: Color(0xFFFFFFFF),
    coverDeep: Color(0xFFF7F4EA),
    page: Color(0xFFFBF8ED),
    pageLine: Color(0xFFE4D9B8),
    pageCard: Color(0xFFFFFFFF),
    ink: Color(0xFF1C2B24),
    inkMuted: Color(0xFF5C6B60),
    inkFaint: Color(0xFF8B9A8E),
    onCover: Color(0xFF1C2B24),
    onCoverMuted: Color(0xFF5C6B60),
    gold: Color(0xFFC9A227),
    goldBright: Color(0xFF9C7D1B),
    goldTint: Color(0xFFF6EAC7),
    emerald: Color(0xFF2E8F63),
    emeraldTint: Color(0xFFDCEBE1),
    clay: Color(0xFFB4502E),
    clayTint: Color(0xFFF3DED2),
  );

  /// Looks up whichever [AppColors] is active for the current theme — every
  /// Ruay Jung widget reads colors through this rather than a hardcoded
  /// static, so it repaints correctly on a light/dark switch.
  static AppColors of(BuildContext context) => Theme.of(context).extension<AppColors>()!;

  @override
  AppColors copyWith({
    Color? cover,
    Color? coverDeep,
    Color? page,
    Color? pageLine,
    Color? pageCard,
    Color? ink,
    Color? inkMuted,
    Color? inkFaint,
    Color? onCover,
    Color? onCoverMuted,
    Color? gold,
    Color? goldBright,
    Color? goldTint,
    Color? emerald,
    Color? emeraldTint,
    Color? clay,
    Color? clayTint,
  }) {
    return AppColors(
      cover: cover ?? this.cover,
      coverDeep: coverDeep ?? this.coverDeep,
      page: page ?? this.page,
      pageLine: pageLine ?? this.pageLine,
      pageCard: pageCard ?? this.pageCard,
      ink: ink ?? this.ink,
      inkMuted: inkMuted ?? this.inkMuted,
      inkFaint: inkFaint ?? this.inkFaint,
      onCover: onCover ?? this.onCover,
      onCoverMuted: onCoverMuted ?? this.onCoverMuted,
      gold: gold ?? this.gold,
      goldBright: goldBright ?? this.goldBright,
      goldTint: goldTint ?? this.goldTint,
      emerald: emerald ?? this.emerald,
      emeraldTint: emeraldTint ?? this.emeraldTint,
      clay: clay ?? this.clay,
      clayTint: clayTint ?? this.clayTint,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      cover: Color.lerp(cover, other.cover, t)!,
      coverDeep: Color.lerp(coverDeep, other.coverDeep, t)!,
      page: Color.lerp(page, other.page, t)!,
      pageLine: Color.lerp(pageLine, other.pageLine, t)!,
      pageCard: Color.lerp(pageCard, other.pageCard, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
      inkFaint: Color.lerp(inkFaint, other.inkFaint, t)!,
      onCover: Color.lerp(onCover, other.onCover, t)!,
      onCoverMuted: Color.lerp(onCoverMuted, other.onCoverMuted, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      goldBright: Color.lerp(goldBright, other.goldBright, t)!,
      goldTint: Color.lerp(goldTint, other.goldTint, t)!,
      emerald: Color.lerp(emerald, other.emerald, t)!,
      emeraldTint: Color.lerp(emeraldTint, other.emeraldTint, t)!,
      clay: Color.lerp(clay, other.clay, t)!,
      clayTint: Color.lerp(clayTint, other.clayTint, t)!,
    );
  }
}
