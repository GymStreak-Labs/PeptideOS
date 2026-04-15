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
                Text('Progress', style: AppTypography.h1),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Track your journey over time',
                  style: AppTypography.bodyMedium,
                ),
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
              child: Row(
                children: [
                  // Ring placeholder
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CustomPaint(
                      painter: _AdherenceRingPainter(progress: 0.85),
                      child: Center(
                        child: Text('85%', style: AppTypography.heroSmall),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.base),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Weekly Adherence', style: AppTypography.labelLarge),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '12 of 14 doses taken on time',
                          style: AppTypography.bodySmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '🔥 7 day streak',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.warning,
                          ),
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
            child: Text('How are you feeling today?', style: AppTypography.h3),
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
              _WellnessMetric(label: 'Energy', value: 4, icon: Icons.bolt_rounded),
              _WellnessMetric(label: 'Sleep', value: 3, icon: Icons.bedtime_rounded),
              _WellnessMetric(label: 'Pain', value: 2, icon: Icons.healing_rounded),
              _WellnessMetric(label: 'Mood', value: 4, icon: Icons.emoji_emotions_rounded),
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
                  Text('Pain Trend', style: AppTypography.labelLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Last 30 days',
                    style: AppTypography.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.base),
                  // Chart placeholder
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                      color: AppColors.inputFill,
                    ),
                    child: Center(
                      child: Text(
                        'Chart coming soon',
                        style: AppTypography.bodySmall,
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
              Text('$value/5', style: AppTypography.heroSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: AppTypography.labelMedium),
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
    const strokeWidth = 6.0;

    // Background ring
    final bgPaint = Paint()
      ..color = AppColors.inputFill
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress ring
    final progressPaint = Paint()
      ..color = AppColors.success
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -1.5708; // -π/2 (top)
    final sweepAngle = 2 * 3.14159 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _AdherenceRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
