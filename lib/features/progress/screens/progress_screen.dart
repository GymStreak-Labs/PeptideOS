import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/body_metric.dart';
import '../../../models/dose_log.dart';
import '../../../models/protocol.dart';
import '../../protocol/providers/dose_log_provider.dart';
import '../../protocol/providers/protocol_provider.dart';
import '../../protocol/screens/active_protocol_detail_screen.dart';
import '../../protocol/widgets/empty_state.dart';
import '../providers/body_metric_provider.dart';
import '../widgets/log_metric_sheet.dart';

/// Progress tab — adherence stats, 30-day adherence bars, weight line chart,
/// and protocol history list.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doseProvider = context.watch<DoseLogProvider>();
    final metricProvider = context.watch<BodyMetricProvider>();
    final protocolProvider = context.watch<ProtocolProvider>();

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surfaceContainer,
      onRefresh: () async {
        await doseProvider.refresh();
        await metricProvider.refresh();
        await protocolProvider.refresh();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.huge,
                AppSpacing.screenHorizontal,
                AppSpacing.base,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SYS.PROGRESS // BIOMETRICS',
                            style: AppTypography.systemLabel),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Progress', style: AppTypography.h1),
                      ],
                    ),
                  ),
                  _HeaderIconButton(
                    icon: Icons.add_rounded,
                    onTap: () => _openLogSheet(context),
                  ),
                ],
              ),
            ),
          ),

          // Stat tiles
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal),
              child: Row(
                children: [
                  Expanded(
                    child: _StatTile(
                      label: '30-DAY',
                      value:
                          '${doseProvider.adherence30dPct.toStringAsFixed(0)}%',
                      hint: 'adherence',
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.cardGap),
                  Expanded(
                    child: _StatTile(
                      label: 'STREAK',
                      value: '${doseProvider.currentStreak}',
                      hint: 'days',
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.cardGap),
                  Expanded(
                    child: _StatTile(
                      label: 'TOTAL',
                      value: '${doseProvider.totalLogged}',
                      hint: 'doses',
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),

          // Adherence chart
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal),
              child: _AdherenceChartCard(logs: doseProvider.recent30),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),

          // Weight chart
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal),
              child: _WeightChartCard(
                entries: metricProvider.all,
                latestKg: metricProvider.latestWeightKg,
                onLog: () => _openLogSheet(context),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),

          // Protocol history
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal),
              child: Text('PROTOCOL.HISTORY',
                  style: AppTypography.systemLabel),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          if (protocolProvider.all.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal),
                child: AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      'No protocols yet. Create one from the Protocol tab.',
                      style: AppTypography.bodySmall,
                    ),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal),
              sliver: SliverList.separated(
                itemCount: protocolProvider.all.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.cardGap),
                itemBuilder: (_, i) {
                  final p = protocolProvider.all[i];
                  return _ProtocolHistoryCard(
                    protocol: p,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              ActiveProtocolDetailScreen(protocol: p),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

          const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.screenBottom)),
        ],
      ),
    );
  }

  Future<void> _openLogSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const LogMetricSheet(),
    );
  }
}

// ── Header button ─────────────────────────────────────────────────────────
class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          border: Border.all(color: AppColors.borderCyan),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.primary, size: AppSpacing.iconLarge),
      ),
    );
  }
}

// ── Stat tile ─────────────────────────────────────────────────────────────
class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.hint,
    required this.color,
  });
  final String label;
  final String value;
  final String hint;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTypography.heroMedium.copyWith(color: color, fontSize: 24),
          ),
          Text(hint, style: AppTypography.bodySmall),
        ],
      ),
    );
  }
}

// ── Adherence chart ───────────────────────────────────────────────────────
class _AdherenceChartCard extends StatelessWidget {
  const _AdherenceChartCard({required this.logs});
  final List<DoseLog> logs;

  @override
  Widget build(BuildContext context) {
    final byDay = <int, _DayStat>{};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    for (var i = 0; i < 30; i++) {
      final day = today.subtract(Duration(days: 29 - i));
      byDay[i] = _DayStat(date: day, scheduled: 0, taken: 0);
    }

    for (final d in logs) {
      final day = DateTime(d.scheduledAt.year, d.scheduledAt.month,
          d.scheduledAt.day);
      final diff = today.difference(day).inDays;
      final idx = 29 - diff;
      if (idx < 0 || idx > 29) continue;
      if (d.skipped) continue;
      if (day.isAfter(today)) continue;
      final stat = byDay[idx]!;
      byDay[idx] = stat.copyWith(
        scheduled: stat.scheduled + 1,
        taken: stat.taken + (d.isTaken ? 1 : 0),
      );
    }

    final bars = <BarChartGroupData>[];
    for (var i = 0; i < 30; i++) {
      final s = byDay[i]!;
      final pct =
          s.scheduled == 0 ? 0.0 : (s.taken / s.scheduled).clamp(0.0, 1.0);
      bars.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: pct,
              color: pct >= 1.0
                  ? AppColors.primary
                  : pct >= 0.5
                      ? AppColors.primary.withValues(alpha: 0.6)
                      : AppColors.border,
              width: 6,
              borderRadius: BorderRadius.circular(2),
            ),
          ],
        ),
      );
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('ADHERENCE // 30.DAY',
                    style: AppTypography.systemLabel),
              ),
              Text('100%',
                  style: AppTypography.labelSmall
                      .copyWith(color: AppColors.textTertiary)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 120,
            child: BarChart(
              BarChartData(
                maxY: 1.0,
                minY: 0,
                alignment: BarChartAlignment.spaceBetween,
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                barGroups: bars,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('30d ago',
                  style: AppTypography.labelSmall
                      .copyWith(color: AppColors.textTertiary)),
              Text('today',
                  style: AppTypography.labelSmall
                      .copyWith(color: AppColors.textTertiary)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayStat {
  const _DayStat({
    required this.date,
    required this.scheduled,
    required this.taken,
  });
  final DateTime date;
  final int scheduled;
  final int taken;

  _DayStat copyWith({int? scheduled, int? taken}) => _DayStat(
        date: date,
        scheduled: scheduled ?? this.scheduled,
        taken: taken ?? this.taken,
      );
}

// ── Weight chart ──────────────────────────────────────────────────────────
class _WeightChartCard extends StatelessWidget {
  const _WeightChartCard({
    required this.entries,
    required this.latestKg,
    required this.onLog,
  });

  final List<BodyMetric> entries;
  final double? latestKg;
  final VoidCallback onLog;

  @override
  Widget build(BuildContext context) {
    final weighted = entries
        .where((e) => e.weightKg != null)
        .toList()
        .reversed
        .toList(); // chronological

    if (weighted.isEmpty) {
      return AppCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.base),
          child: EmptyState(
            icon: Icons.monitor_weight_rounded,
            title: 'No weight data',
            description: 'Log your first measurement to see trends here.',
            actionLabel: 'LOG MEASUREMENT',
            onAction: onLog,
          ),
        ),
      );
    }

    final spots = <FlSpot>[];
    for (var i = 0; i < weighted.length; i++) {
      spots.add(FlSpot(i.toDouble(), weighted[i].weightKg!));
    }

    final minY = weighted.map((e) => e.weightKg!).reduce((a, b) => a < b ? a : b);
    final maxY = weighted.map((e) => e.weightKg!).reduce((a, b) => a > b ? a : b);
    final padding = ((maxY - minY) * 0.1).clamp(0.5, 5.0);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('WEIGHT // TREND',
                    style: AppTypography.systemLabel),
              ),
              if (latestKg != null)
                Text(
                  '${latestKg!.toStringAsFixed(1)} kg',
                  style: AppTypography.tabular.copyWith(fontSize: 15),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 140,
            child: LineChart(
              LineChartData(
                minY: minY - padding,
                maxY: maxY + padding,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: ((maxY - minY) / 2).clamp(0.5, 50.0),
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: AppColors.gridLine,
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.2,
                    color: AppColors.primary,
                    barWidth: 2,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (s, _, __, ___) => FlDotCirclePainter(
                        radius: 3,
                        color: AppColors.primary,
                        strokeWidth: 0,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.25),
                          AppColors.primary.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Protocol history row ─────────────────────────────────────────────────
class _ProtocolHistoryCard extends StatelessWidget {
  const _ProtocolHistoryCard({required this.protocol, required this.onTap});
  final Protocol protocol;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    switch (protocol.status) {
      case ProtocolStatus.active:
        color = AppColors.primary;
        label = 'ACTIVE';
        break;
      case ProtocolStatus.paused:
        color = AppColors.danger;
        label = 'PAUSED';
        break;
      case ProtocolStatus.ended:
        color = AppColors.textTertiary;
        label = 'ENDED';
        break;
    }

    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: protocol.status == ProtocolStatus.active
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.6),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(protocol.name, style: AppTypography.labelLarge),
                Text(
                  '${protocol.peptides.length} peptides · ${_formatDate(protocol.startDate)}'
                  '${protocol.endDate != null ? ' → ${_formatDate(protocol.endDate!)}' : ''}',
                  style: AppTypography.bodySmall
                      .copyWith(fontFamily: 'JetBrainsMono'),
                ),
              ],
            ),
          ),
          Text(
            label,
            style: AppTypography.systemLabel.copyWith(color: color, fontSize: 9),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(Icons.chevron_right_rounded,
              color: AppColors.textTertiary, size: AppSpacing.iconMedium),
        ],
      ),
    );
  }

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  String _formatDate(DateTime d) => '${_months[d.month - 1]} ${d.day}';
}
