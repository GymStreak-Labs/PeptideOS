/// PeptideOS spacing & sizing tokens.
/// 4pt base grid system.
abstract final class AppSpacing {
  // ── Base grid (4pt) ──────────────────────────────────────────────────
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double base = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;
  static const double huge = 48;
  static const double massive = 64;

  // ── Screen padding ───────────────────────────────────────────────────
  static const double screenHorizontal = 20;
  static const double screenTop = 16;
  static const double screenBottom = 100; // room for floating tab bar

  // ── Card ──────────────────────────────────────────────────────────────
  static const double cardPadding = 16;
  static const double cardGap = 12; // gap between cards in a list
  static const double cardRadius = 16;

  // ── Button ────────────────────────────────────────────────────────────
  static const double buttonHeight = 52;
  static const double buttonSmallHeight = 40;
  static const double buttonRadius = 14;
  static const double buttonHorizontalPadding = 24;

  // ── Input ─────────────────────────────────────────────────────────────
  static const double inputHeight = 52;
  static const double inputRadius = 12;
  static const double inputPadding = 16;

  // ── Bottom sheet ──────────────────────────────────────────────────────
  static const double sheetRadius = 24;
  static const double sheetHandleWidth = 36;
  static const double sheetHandleHeight = 4;

  // ── Tab bar ───────────────────────────────────────────────────────────
  static const double tabBarHeight = 72;
  static const double tabBarBottomPadding = 28; // safe area + extra
  static const double tabBarBlur = 24;

  // ── Icons ─────────────────────────────────────────────────────────────
  static const double iconSmall = 16;
  static const double iconMedium = 20;
  static const double iconDefault = 24;
  static const double iconLarge = 28;
  static const double iconXLarge = 32;
}
