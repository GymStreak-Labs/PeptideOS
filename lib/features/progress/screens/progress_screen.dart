import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Progress tab — symptom logging, AI insights, charts, trends.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.huge,
              AppSpacing.screenHorizontal,
              AppSpacing.base,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SYS.PROGRESS // BIOMETRICS', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Text('Progress', style: AppTypography.h1),
              ],
            ),
          ),
        ),

        // ── Adherence Ring ───────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: AppCard(
              borderColor: AppColors.borderCyan,
              child: Row(
                children: [
                  // Ring with cyan glow
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CustomPaint(
                      painter: _AdherenceRingPainter(progress: 0.85),
                      child: Center(
                        child: Text(
                          '85',
                          style: AppTypography.heroSmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.base),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ADHERENCE', style: AppTypography.systemLabel),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '12 of 14 doses on schedule',
                          style: AppTypography.bodySmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.secondary.withValues(alpha: 0.5),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              '7 DAY STREAK',
                              style: AppTypography.systemLabel.copyWith(
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Daily Wellness Log ───────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: Text('BIOMETRICS // LOG', style: AppTypography.systemLabel),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.cardGap,
            mainAxisSpacing: AppSpacing.cardGap,
            childAspectRatio: 1.8,
            children: const [
              _WellnessMetric(label: 'ENERGY', value: 4, icon: Icons.bolt_rounded),
              _WellnessMetric(label: 'SLEEP', value: 3, icon: Icons.bedtime_rounded),
              _WellnessMetric(label: 'PAIN', value: 2, icon: Icons.healing_rounded),
              _WellnessMetric(label: 'MOOD', value: 4, icon: Icons.emoji_emotions_rounded),
            ],
          ),
        ),

        // ── Trend Chart Placeholder ──────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('PAIN.TREND', style: AppTypography.systemLabel),
                      const Spacer(),
                      Text('30D', style: AppTypography.tabular.copyWith(
                        fontSize: 12,
                        color: AppColors.textTertiary,
                      )),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.base),
                  // Chart placeholder with scan-line effect
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                      color: AppColors.inputFill,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Center(
                      child: Text(
                        '[ AWAITING DATA ]',
                        style: AppTypography.systemLabel.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: AppSpacing.screenBottom),
        ),
      ],
    );
  }
}

class _WellnessMetric extends StatelessWidget {
  const _WellnessMetric({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final int value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () {
        // TODO: open wellness logger
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: AppSpacing.iconMedium, color: AppColors.primary),
              const Spacer(),
              Text(
                '$value',
                style: AppTypography.heroSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                '/5',
                style: AppTypography.unit,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: AppTypography.systemLabel.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 1.2,
            fontSize: 10,
          )),
        ],
      ),
    );
  }
}

class _AdherenceRingPainter extends CustomPainter {
  _AdherenceRingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 4.0;

    // Background ring
    final bgPaint = Paint()
      ..color = const Color(0xFF1E2740)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress ring — cyan with glow
    final progressPaint = Paint()
      ..color = const Color(0xFF05D9E8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Glow ring
    final glowPaint = Paint()
      ..color = const Color(0xFF05D9E8).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    const startAngle = -1.5708; // -π/2 (top)
    final sweepAngle = 2 * 3.14159 * progress;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Draw glow first, then solid
    canvas.drawArc(rect, startAngle, sweepAngle, false, glowPaint);
    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _AdherenceRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
