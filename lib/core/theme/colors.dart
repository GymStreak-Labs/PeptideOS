import 'dart:ui';

/// PeptideOS unified colour system.
/// Dark-mode-first, de-saturated accents, identical on iOS and Android.
abstract final class AppColors {
  // ── Backgrounds ──────────────────────────────────────────────────────
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceContainer = Color(0xFF1E1E1E);
  static const Color surfaceElevated = Color(0xFF2A2A2A);
  static const Color surfaceOverlay = Color(0xFF2D2D2D);
  static const Color inputFill = Color(0xFF252525);

  // ── Text ─────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFE0E0E0);
  static const Color textTertiary = Color(0xFFB0B0B0);
  static const Color textDisabled = Color(0xFF666666);
  static const Color textInverse = Color(0xFF121212);

  // ── Accent ───────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF64B5F6); // soft blue
  static const Color primaryDim = Color(0xFF3D8BC9); // darker blue for pressed
  static const Color primaryGlow = Color(0x3364B5F6); // 20% opacity for glows

  // ── Semantic ─────────────────────────────────────────────────────────
  static const Color success = Color(0xFF81C784); // soft green — on-track
  static const Color successDim = Color(0xFF5A9E5D);
  static const Color successGlow = Color(0x3381C784);

  static const Color warning = Color(0xFFFFB74D); // soft amber — approaching
  static const Color warningDim = Color(0xFFD99636);
  static const Color warningGlow = Color(0x33FFB74D);

  static const Color danger = Color(0xFFE57373); // soft red — missed/expired
  static const Color dangerDim = Color(0xFFC05050);
  static const Color dangerGlow = Color(0x33E57373);

  // ── Feature Accents ──────────────────────────────────────────────────
  static const Color aiInsight = Color(0xFFCE93D8); // soft purple — AI
  static const Color aiInsightGlow = Color(0x33CE93D8);
  static const Color peptide = Color(0xFF4DD0E1); // soft cyan — peptide data
  static const Color peptideGlow = Color(0x334DD0E1);

  // ── Borders & Dividers ───────────────────────────────────────────────
  static const Color border = Color(0x14FFFFFF); // 8% white
  static const Color borderSubtle = Color(0x0AFFFFFF); // 4% white
  static const Color divider = Color(0x1FFFFFFF); // 12% white

  // ── Chart / Data Viz ─────────────────────────────────────────────────
  static const Color gridLine = Color(0xFF3A3A3A);
  static const Color axisLine = Color(0xFF5A5A5A);
  static const Color axisLabel = Color(0xFFC0C0C0);

  // ── Glass ────────────────────────────────────────────────────────────
  static const Color glass = Color(0x1AFFFFFF); // 10% white for glass surfaces
  static const Color glassBorder = Color(0x14FFFFFF); // 8% white for glass edges

  // ── Misc ─────────────────────────────────────────────────────────────
  static const Color shimmer = Color(0xFF2A2A2A);
  static const Color scrim = Color(0x99000000); // 60% black overlay
}
