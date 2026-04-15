import 'package:flutter/material.dart';

/// Animated syringe diagram showing fill level and unit markings.
/// Custom-painted in the Clinical Cyberpunk style — cyan fill with glow.
class SyringeVisual extends StatelessWidget {
  const SyringeVisual({
    super.key,
    required this.fillFraction,
    required this.totalUnits,
    required this.fillUnits,
    this.syringeType = SyringeType.insulin100,
    this.height = 280,
  });

  /// 0.0 to 1.0 — how full the syringe is.
  final double fillFraction;

  /// Total capacity in units (e.g., 100 for 1ml insulin syringe).
  final int totalUnits;

  /// How many units are filled.
  final double fillUnits;

  /// Syringe size type.
  final SyringeType syringeType;

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: height,
      child: CustomPaint(
        painter: _SyringePainter(
          fillFraction: fillFraction.clamp(0.0, 1.0),
          totalUnits: totalUnits,
          fillUnits: fillUnits,
        ),
      ),
    );
  }
}

enum SyringeType {
  insulin100, // 1ml / 100 unit
  insulin50, // 0.5ml / 50 unit
  insulin30, // 0.3ml / 30 unit
}

class _SyringePainter extends CustomPainter {
  _SyringePainter({
    required this.fillFraction,
    required this.totalUnits,
    required this.fillUnits,
  });

  final double fillFraction;
  final int totalUnits;
  final double fillUnits;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Syringe dimensions
    final barrelWidth = w * 0.35;
    final barrelLeft = (w - barrelWidth) / 2;
    final barrelRight = barrelLeft + barrelWidth;
    final barrelTop = h * 0.08;
    final barrelBottom = h * 0.82;
    final barrelHeight = barrelBottom - barrelTop;

    // Needle
    final needleWidth = w * 0.04;
    final needleLeft = (w - needleWidth) / 2;
    final needleTop = h * 0.0;
    final needleBottom = barrelTop;

    // Plunger
    final plungerWidth = barrelWidth * 0.7;
    final plungerLeft = (w - plungerWidth) / 2;
    final plungerHandleWidth = barrelWidth * 1.1;
    final plungerHandleLeft = (w - plungerHandleWidth) / 2;
    final plungerBottom = h * 0.98;

    // ── Draw needle ──────────────────────────────────────────────────
    final needlePaint = Paint()
      ..color = const Color(0xFF3A4460)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(needleLeft, needleTop, needleLeft + needleWidth, needleBottom),
      needlePaint,
    );

    // ── Draw barrel outline ──────────────────────────────────────────
    final barrelOutlinePaint = Paint()
      ..color = const Color(0xFF1E2740)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final barrelRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(barrelLeft, barrelTop, barrelRight, barrelBottom),
      const Radius.circular(4),
    );
    canvas.drawRRect(barrelRect, barrelOutlinePaint);

    // ── Draw barrel background ───────────────────────────────────────
    final barrelBgPaint = Paint()
      ..color = const Color(0xFF0D1117)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(barrelRect, barrelBgPaint);

    // ── Draw fill level ──────────────────────────────────────────────
    if (fillFraction > 0) {
      final fillTop = barrelBottom - (barrelHeight * fillFraction);

      // Glow effect
      final glowPaint = Paint()
        ..color = const Color(0xFF05D9E8).withValues(alpha: 0.15)
        ..style = PaintingStyle.fill;

      final glowRect = RRect.fromRectAndCorners(
        Rect.fromLTRB(barrelLeft + 1, fillTop, barrelRight - 1, barrelBottom - 1),
        bottomLeft: const Radius.circular(3),
        bottomRight: const Radius.circular(3),
      );
      canvas.drawRRect(glowRect, glowPaint);

      // Solid fill
      final fillPaint = Paint()
        ..color = const Color(0xFF05D9E8).withValues(alpha: 0.4)
        ..style = PaintingStyle.fill;

      canvas.drawRRect(glowRect, fillPaint);

      // Top meniscus line (bright)
      final meniscusPaint = Paint()
        ..color = const Color(0xFF05D9E8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawLine(
        Offset(barrelLeft + 3, fillTop),
        Offset(barrelRight - 3, fillTop),
        meniscusPaint,
      );

      // Meniscus glow
      final meniscusGlowPaint = Paint()
        ..color = const Color(0xFF05D9E8).withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawLine(
        Offset(barrelLeft + 3, fillTop),
        Offset(barrelRight - 3, fillTop),
        meniscusGlowPaint,
      );
    }

    // ── Draw graduation marks ────────────────────────────────────────
    final majorTickPaint = Paint()
      ..color = const Color(0xFF3A4460)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final minorTickPaint = Paint()
      ..color = const Color(0xFF1E2740)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final tickTextStyle = TextStyle(
      fontFamily: 'JetBrainsMono',
      fontSize: 8,
      color: const Color(0xFF5C6A8A),
    );

    final divisions = 10;
    for (int i = 0; i <= divisions; i++) {
      final y = barrelBottom - (barrelHeight * i / divisions);
      final isMajor = i % 2 == 0;
      final tickLength = isMajor ? barrelWidth * 0.25 : barrelWidth * 0.15;

      canvas.drawLine(
        Offset(barrelLeft, y),
        Offset(barrelLeft + tickLength, y),
        isMajor ? majorTickPaint : minorTickPaint,
      );

      // Labels on major ticks
      if (isMajor && i > 0) {
        final unitValue = (totalUnits * i / divisions).round();
        final textSpan = TextSpan(text: '$unitValue', style: tickTextStyle);
        final tp = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, Offset(barrelLeft - tp.width - 4, y - tp.height / 2));
      }
    }

    // ── Draw plunger ─────────────────────────────────────────────────
    final plungerPaint = Paint()
      ..color = const Color(0xFF1E2740)
      ..style = PaintingStyle.fill;

    // Plunger rod
    canvas.drawRect(
      Rect.fromLTRB(plungerLeft, barrelBottom, plungerLeft + plungerWidth, plungerBottom - 8),
      plungerPaint,
    );

    // Plunger handle
    final handlePaint = Paint()
      ..color = const Color(0xFF3A4460)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          plungerHandleLeft,
          plungerBottom - 10,
          plungerHandleLeft + plungerHandleWidth,
          plungerBottom,
        ),
        const Radius.circular(2),
      ),
      handlePaint,
    );

    // ── Draw barrel outline again on top ─────────────────────────────
    canvas.drawRRect(barrelRect, barrelOutlinePaint);
  }

  @override
  bool shouldRepaint(covariant _SyringePainter oldDelegate) =>
      oldDelegate.fillFraction != fillFraction ||
      oldDelegate.totalUnits != totalUnits;
}
