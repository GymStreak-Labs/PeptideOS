import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Screen 11: Building Your Protocol — processing / compile animation.
/// Auto-advances when progress reaches 100%.
class ProcessingPage extends StatefulWidget {
  const ProcessingPage({
    super.key,
    required this.onNext,
    required this.selectedPeptides,
    required this.selectedGoals,
  });

  final VoidCallback onNext;
  final Set<String> selectedPeptides;
  final Set<String> selectedGoals;

  @override
  State<ProcessingPage> createState() => _ProcessingPageState();
}

class _ProcessingPageState extends State<ProcessingPage>
    with TickerProviderStateMixin {
  late final AnimationController _progressController;
  late final AnimationController _pulseController;
  late final AnimationController _rotateController;
  late final AnimationController _dataController;

  bool _protocolReadyFlash = false;
  bool _advanced = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    _dataController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4500),
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_advanced) {
          _advanced = true;
          setState(() => _protocolReadyFlash = true);
          Future.delayed(const Duration(milliseconds: 400), () {
            if (mounted) widget.onNext();
          });
        }
      });

    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  String _statusLabel(double progress) {
    final peptideCount = widget.selectedPeptides.isEmpty
        ? 2
        : widget.selectedPeptides.length;
    final goalCount =
        widget.selectedGoals.isEmpty ? 3 : widget.selectedGoals.length;

    if (progress < 0.25) {
      return 'ANALYSING $goalCount GOALS...';
    } else if (progress < 0.55) {
      return 'CALCULATING OPTIMAL SCHEDULE...';
    } else if (progress < 0.80) {
      return 'MAPPING $peptideCount PEPTIDE INTERACTIONS...';
    } else {
      return 'BUILDING YOUR PROTOCOL...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Faint scrolling background data lines
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _dataController,
                builder: (context, _) => CustomPaint(
                  painter: _DataStreamPainter(
                    progress: _dataController.value,
                    peptides: widget.selectedPeptides,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.huge),

                Text('SYS.ENGINE // COMPILING',
                    style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Building your\nprotocol',
                  style: AppTypography.h1.copyWith(fontSize: 30),
                ),
                const SizedBox(height: AppSpacing.sm),
                AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, _) => Text(
                    _statusLabel(_progressController.value),
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),

                // Centerpiece — radar / pulsing rings
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 220,
                      height: 220,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Pulsing outer rings
                          AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, _) => CustomPaint(
                              size: const Size(220, 220),
                              painter: _PulseRingsPainter(
                                t: _pulseController.value,
                              ),
                            ),
                          ),

                          // Rotating arc
                          AnimatedBuilder(
                            animation: _rotateController,
                            builder: (context, _) => Transform.rotate(
                              angle: _rotateController.value * 2 * math.pi,
                              child: CustomPaint(
                                size: const Size(160, 160),
                                painter: _RotatingArcPainter(),
                              ),
                            ),
                          ),

                          // Static cross-hair inner ring
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 24,
                                ),
                              ],
                            ),
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _progressController,
                                builder: (context, _) {
                                  final pct =
                                      (_progressController.value * 100).round();
                                  return Text(
                                    '$pct%',
                                    style: AppTypography.heroSmall.copyWith(
                                      fontSize: 22,
                                      color: AppColors.primary,
                                      shadows: [
                                        Shadow(
                                          color: AppColors.primary
                                              .withValues(alpha: 0.6),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Progress bar
                AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, _) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Container(
                        height: 3,
                        color: AppColors.border,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: _progressController.value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.6),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                // Cycling status label (mono)
                AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, _) => Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.primary.withValues(alpha: 0.7),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          _statusLabel(_progressController.value),
                          style: AppTypography.systemLabel.copyWith(
                            color: AppColors.primary,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.base),

                // "PROTOCOL READY //" flash
                AnimatedOpacity(
                  opacity: _protocolReadyFlash ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Text(
                      'PROTOCOL READY //',
                      style: AppTypography.systemLabel.copyWith(
                        color: AppColors.primary,
                        fontSize: 13,
                        letterSpacing: 3,
                        shadows: [
                          Shadow(
                            color: AppColors.primary.withValues(alpha: 0.7),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Painters ────────────────────────────────────────────────────────────────

class _PulseRingsPainter extends CustomPainter {
  _PulseRingsPainter({required this.t});
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxR = size.width / 2;

    for (int i = 0; i < 2; i++) {
      final localT = (t + i * 0.5) % 1.0;
      final radius = 40 + (maxR - 40) * localT;
      final alpha = (1.0 - localT) * 0.5;
      final paint = Paint()
        ..color = AppColors.primary.withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PulseRingsPainter old) => old.t != t;
}

class _RotatingArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = SweepGradient(
        colors: [
          AppColors.primary.withValues(alpha: 0.0),
          AppColors.primary.withValues(alpha: 0.9),
        ],
        stops: const [0.5, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawArc(rect, 0, math.pi * 1.4, false, paint);

    // Head dot
    final head = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;
    final angle = math.pi * 1.4;
    final center = size.center(Offset.zero);
    final r = size.width / 2;
    final pos = Offset(
      center.dx + r * math.cos(angle),
      center.dy + r * math.sin(angle),
    );
    canvas.drawCircle(pos, 3, head);
    canvas.drawCircle(
      pos,
      8,
      Paint()..color = AppColors.primary.withValues(alpha: 0.25),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

class _DataStreamPainter extends CustomPainter {
  _DataStreamPainter({required this.progress, required this.peptides});
  final double progress;
  final Set<String> peptides;

  static const _lines = [
    '0x4A2F :: peptide.binding.affinity = 0.87',
    '0x5B0C :: half_life.hours = 6.2',
    '0x6D1E :: route.subcutaneous OK',
    '0x7E8A :: dosage.vector[0..n] resolved',
    '0x8F9B :: schedule.interval = 12h',
    '0x9A3D :: synergy.matrix compiled',
    '0xAB4E :: reconstitution.bac_water',
    '0xBC5F :: injection.site.rotation',
    '0xCD60 :: receptor.downregulation = 0',
    '0xDE71 :: cycle.phase = loading',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(textDirection: TextDirection.ltr);
    final scrollOffset = progress * size.height;
    const lineHeight = 22.0;
    final style = TextStyle(
      fontFamily: 'JetBrainsMono',
      fontSize: 10,
      color: AppColors.primary.withValues(alpha: 0.08),
      letterSpacing: 1.0,
    );

    final totalLines = (size.height / lineHeight).ceil() + 2;
    for (int i = 0; i < totalLines; i++) {
      final y = (i * lineHeight) - (scrollOffset % lineHeight);
      final lineIdx = (i + (scrollOffset ~/ lineHeight)) % _lines.length;
      tp.text = TextSpan(text: _lines[lineIdx], style: style);
      tp.layout();
      tp.paint(canvas, Offset(size.width - tp.width - 8, y));
    }
  }

  @override
  bool shouldRepaint(covariant _DataStreamPainter old) =>
      old.progress != progress;
}
