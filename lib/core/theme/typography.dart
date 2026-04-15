import 'package:flutter/material.dart';
import 'colors.dart';

/// PeptideOS "Clinical Cyberpunk" type system.
///
/// Dual-font strategy:
/// - **Space Grotesk** — geometric sans-serif for headings & body. Modern, slightly technical.
/// - **JetBrains Mono** — monospace for data numbers, doses, timers. Signals "tech/system readout".
///
/// Cross-platform via google_fonts.
abstract final class AppTypography {
  static const String _display = 'SpaceGrotesk';
  static const String _mono = 'JetBrainsMono';

  // ── Hero (large data numbers — monospace for that HUD feel) ──────────
  static const TextStyle heroLarge = TextStyle(
    fontFamily: _mono,
    fontSize: 44,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.0,
    letterSpacing: -1.0,
  );

  static const TextStyle heroMedium = TextStyle(
    fontFamily: _mono,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static const TextStyle heroSmall = TextStyle(
    fontFamily: _mono,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.15,
  );

  // ── Headings (Space Grotesk — geometric, slightly techy) ─────────────
  static const TextStyle h1 = TextStyle(
    fontFamily: _display,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: _display,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: _display,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // ── Body (Space Grotesk — clean, readable) ───────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _display,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _display,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _display,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.45,
  );

  // ── Labels ───────────────────────────────────────────────────────────
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _display,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _display,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _display,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    height: 1.3,
    letterSpacing: 1.5, // wider tracking for small caps / system labels
  );

  // ── System labels (monospace, uppercase — the "HUD" voice) ───────────
  static const TextStyle systemLabel = TextStyle(
    fontFamily: _mono,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    height: 1.3,
    letterSpacing: 1.8,
  );

  // ── Specialised ──────────────────────────────────────────────────────

  /// Units displayed next to dose numbers (mcg, ml, IU) — monospace.
  static const TextStyle unit = TextStyle(
    fontFamily: _mono,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.2,
  );

  /// Tabular figures for countdowns, timers, and aligned numbers.
  static const TextStyle tabular = TextStyle(
    fontFamily: _mono,
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Disclaimer / legal text.
  static const TextStyle disclaimer = TextStyle(
    fontFamily: _display,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textDisabled,
    height: 1.4,
  );

  /// Tab bar labels.
  static const TextStyle tabLabel = TextStyle(
    fontFamily: _mono,
    fontSize: 9,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    height: 1.2,
    letterSpacing: 1.0,
  );

  /// Button text.
  static const TextStyle button = TextStyle(
    fontFamily: _display,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: 0.5,
  );
}
