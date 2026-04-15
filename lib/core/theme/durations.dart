/// PeptideOS animation duration tokens.
/// Purposeful animation — every motion serves a function.
abstract final class AppDurations {
  // ── Interaction feedback ──────────────────────────────────────────────
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration emphasis = Duration(milliseconds: 800);

  // ── Feature-specific ─────────────────────────────────────────────────
  static const Duration doseLogged = Duration(milliseconds: 300);
  static const Duration vialLevel = Duration(milliseconds: 500);
  static const Duration syringeFill = Duration(milliseconds: 400);
  static const Duration injectionRipple = Duration(milliseconds: 250);
  static const Duration cardSlideUp = Duration(milliseconds: 350);
  static const Duration aiInsightReveal = Duration(milliseconds: 400);
  static const Duration phaseTransition = Duration(milliseconds: 600);
  static const Duration celebration = Duration(milliseconds: 800);

  // ── Page transitions ─────────────────────────────────────────────────
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration sheetTransition = Duration(milliseconds: 350);
  static const Duration tabFade = Duration(milliseconds: 200);
}
