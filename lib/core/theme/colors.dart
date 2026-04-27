import 'dart:ui';

/// PepMod — "Clinical Cyberpunk" colour system.
/// Deep navy-black base, electric neon accents used surgically.
/// Sophistication over spectacle. Deus Ex, not Saints Row.
abstract final class AppColors {
  // ── Backgrounds (deep navy-black, not pure black) ────────────────────
  static const Color background = Color(0xFF0B0C10);
  static const Color surface = Color(0xFF0D1117);
  static const Color surfaceContainer = Color(0xFF111827);
  static const Color surfaceElevated = Color(0xFF161B2E);
  static const Color surfaceOverlay = Color(0xFF1A2035);
  static const Color inputFill = Color(0xFF0F1522);

  // ── Text ─────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFE8ECF4); // cool white, slight blue tint
  static const Color textSecondary = Color(0xFFA8B2C8); // muted lavender-gray
  static const Color textTertiary = Color(0xFF5C6A8A); // dim blue-gray
  static const Color textDisabled = Color(0xFF3A4460);
  static const Color textInverse = Color(0xFF0B0C10);

  // ── Primary — Electric Cyan ──────────────────────────────────────────
  static const Color primary = Color(0xFF05D9E8); // electric cyan — the signature
  static const Color primaryDim = Color(0xFF049DAA);
  static const Color primaryGlow = Color(0x3305D9E8); // 20% opacity glow
  static const Color primaryFaint = Color(0x1A05D9E8); // 10% for subtle fills

  // ── Secondary — Hot Pink / Magenta ───────────────────────────────────
  static const Color secondary = Color(0xFFFF2A6D); // hot pink — attention signal
  static const Color secondaryDim = Color(0xFFCC2157);
  static const Color secondaryGlow = Color(0x33FF2A6D);

  // ── Semantic ─────────────────────────────────────────────────────────
  static const Color success = Color(0xFF05D9E8); // cyan = on-track / completed
  static const Color successDim = Color(0xFF049DAA);
  static const Color successGlow = Color(0x3305D9E8);

  static const Color warning = Color(0xFFFF2A6D); // hot pink = needs attention
  static const Color warningDim = Color(0xFFCC2157);
  static const Color warningGlow = Color(0x33FF2A6D);

  static const Color danger = Color(0xFFFCEE0A); // acid yellow = danger / expired
  static const Color dangerDim = Color(0xFFCABE08);
  static const Color dangerGlow = Color(0x33FCEE0A);

  // ── Feature Accents ──────────────────────────────────────────────────
  static const Color aiInsight = Color(0xFF7700A6); // deep purple — AI augmentation
  static const Color aiInsightBright = Color(0xFFBB44FF); // brighter purple for text/icons
  static const Color aiInsightGlow = Color(0x337700A6);
  static const Color peptide = Color(0xFF05D9E8); // cyan — unified with primary

  // ── Borders & Dividers ───────────────────────────────────────────────
  static const Color border = Color(0xFF1E2740); // subtle navy border
  static const Color borderSubtle = Color(0xFF151C30);
  static const Color borderCyan = Color(0x4005D9E8); // 25% cyan for active borders
  static const Color divider = Color(0xFF1E2740);

  // ── Chart / Data Viz ─────────────────────────────────────────────────
  static const Color gridLine = Color(0xFF151C30);
  static const Color axisLine = Color(0xFF1E2740);
  static const Color axisLabel = Color(0xFF5C6A8A);

  // ── Glass (cyberpunk glass = darker, more blue-tinted) ───────────────
  static const Color glass = Color(0x1A05D9E8); // 10% cyan tint
  static const Color glassBorder = Color(0x2005D9E8); // 12% cyan border
  static const Color glassNavBar = Color(0xE60B0C10); // 90% opaque for tab bar

  // ── Scan Lines & Effects ─────────────────────────────────────────────
  static const Color scanLine = Color(0x0805D9E8); // very faint cyan scan line
  static const Color glitchAccent = Color(0xFFFF2A6D); // pink for glitch moments

  // ── Misc ─────────────────────────────────────────────────────────────
  static const Color shimmer = Color(0xFF161B2E);
  static const Color scrim = Color(0xCC0B0C10); // 80% scrim, darker
}
