import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/dose_log.dart';
import '../../../models/protocol.dart';
import '../../subscription/providers/subscription_provider.dart';
import '../../subscription/screens/soft_paywall_sheet.dart';
import '../providers/dose_log_provider.dart';
import '../providers/protocol_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/log_dose_sheet.dart';
import '../widgets/reminders_blocked_banner.dart';
import '../widgets/peptide_label_color.dart';
import '../widgets/protocol_localizations.dart';
import 'active_protocol_detail_screen.dart';
import 'create_protocol_screen.dart';
import 'weekly_planner_screen.dart';

/// Today-focused home screen. Surfaces today's schedule, adherence, and
/// the next dose countdown for whichever active protocol is running.
class ProtocolHomeScreen extends StatelessWidget {
  const ProtocolHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final protocolProvider = context.watch<ProtocolProvider>();
    final doseProvider = context.watch<DoseLogProvider>();

    if (protocolProvider.isLoading || doseProvider.isLoading) {
      return const _LoadingView();
    }

    if (!protocolProvider.hasActive) {
      return const _NoProtocolView();
    }

    final today = doseProvider.today;
    final now = DateTime.now();
    final upcoming = today
        .where((d) => d.isPending && d.scheduledAt.isAfter(now))
        .toList();
    final nextDose = upcoming.isEmpty ? null : upcoming.first;
    final labelColors = _labelColorsByPeptideUuid(protocolProvider.active);

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surfaceContainer,
      onRefresh: () async {
        await doseProvider.refresh();
        await protocolProvider.regenerateSchedules();
        await doseProvider.refresh();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // ── Header ───────────────────────────────────────────────────
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
                        Text(
                          'SYS.PROTOCOL // TODAY',
                          style: AppTypography.systemLabel,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(_dayLabel(context, now), style: AppTypography.h1),
                      ],
                    ),
                  ),
                  _HeaderIconButton(
                    tooltip: context.protocolL10n.protocolWeeklyPlanner,
                    icon: Icons.calendar_view_week_rounded,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WeeklyPlannerScreen(
                            protocols: protocolProvider.active,
                            doseLogs: <DoseLog>[
                              ...doseProvider.recent30,
                              ...doseProvider.today,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _HeaderIconButton(
                    tooltip: context.protocolL10n.protocolDoseHistory,
                    icon: Icons.history_rounded,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _openDoseHistorySheet(context, protocolProvider.active);
                    },
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _HeaderIconButton(
                    tooltip: context.protocolL10n.protocolCreate,
                    icon: Icons.add_rounded,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _onCreateProtocol(context);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Reminders-blocked recovery — renders only when the user wants
          // reminders but the OS permission is denied.
          const SliverToBoxAdapter(
            child: RemindersBlockedBanner(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                0,
                AppSpacing.screenHorizontal,
                AppSpacing.base,
              ),
            ),
          ),

          // ── Today hero card: adherence for today ─────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: _TodayHeroCard(
                taken: doseProvider.takenToday,
                total: doseProvider.totalToday,
                adherencePct: doseProvider.adherenceTodayPct,
              ),
            ),
          ),

          // ── Next dose countdown ──────────────────────────────────────
          if (nextDose != null) ...[
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.cardGap),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: _NextDoseCard(
                  dose: nextDose,
                  labelColorHex: _labelColorForDose(nextDose, labelColors),
                  onLog: () => _openLogSheet(context, nextDose),
                ),
              ),
            ),
          ],

          // ── Today's schedule header ──────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.xl,
                AppSpacing.screenHorizontal,
                AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Text(
                    context.protocolL10n.protocolScheduleTodaySystemLabel,
                    style: AppTypography.systemLabel,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ActiveProtocolDetailScreen(
                            protocol: protocolProvider.active.first,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      context.protocolL10n.protocolManage,
                      style: AppTypography.systemLabel.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Today's doses list ───────────────────────────────────────
          if (today.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: _EmptyTodayCard(),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              sliver: SliverList.separated(
                itemCount: today.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.cardGap),
                itemBuilder: (context, index) {
                  final dose = today[index];
                  return _DoseCard(
                    dose: dose,
                    labelColorHex: _labelColorForDose(dose, labelColors),
                    onTap: () => _openLogSheet(context, dose),
                  );
                },
              ),
            ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.screenBottom),
          ),
        ],
      ),
    );
  }

  Future<void> _openLogSheet(BuildContext context, DoseLog dose) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LogDoseSheet(dose: dose),
    );
  }

  Future<void> _openDoseHistorySheet(
    BuildContext context,
    List<Protocol> protocols,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DoseHistorySheet(protocols: protocols),
    );
  }

  String _dayLabel(BuildContext context, DateTime d) =>
      MaterialLocalizations.of(context).formatFullDate(d);

  Map<String, String> _labelColorsByPeptideUuid(List<Protocol> protocols) {
    return <String, String>{
      for (final protocol in protocols)
        for (final peptide in protocol.peptides)
          peptide.uuid: peptide.labelColorHex,
    };
  }

  String _labelColorForDose(DoseLog dose, Map<String, String> labelColors) {
    return labelColors[dose.protocolPeptideUuid] ?? '';
  }
}

// ── Header icon button ──────────────────────────────────────────────────────
class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
  });
  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: tooltip,
      child: GestureDetector(
        onTap: onTap,
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
          child: Icon(
            icon,
            color: AppColors.primary,
            size: AppSpacing.iconLarge,
          ),
        ),
      ),
    );
  }
}

// ── Loading ──────────────────────────────────────────────────────────────────
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}

// ── No active protocol ──────────────────────────────────────────────────────
class _NoProtocolView extends StatelessWidget {
  const _NoProtocolView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xxl),
            Text('SYS.PROTOCOL // IDLE', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.protocolL10n.protocolYourProtocol,
              style: AppTypography.h1,
            ),
            const SizedBox(height: AppSpacing.huge),
            Expanded(
              child: Center(
                child: EmptyState(
                  icon: Icons.medical_services_rounded,
                  title: context.protocolL10n.protocolNoActive,
                  description: context.protocolL10n.protocolNoActiveBody,
                  actionLabel: context.protocolL10n.protocolStartFirst,
                  onAction: () => _onCreateProtocol(context),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.screenBottom),
          ],
        ),
      ),
    );
  }
}

/// Free-tier gate before pushing CreateProtocolScreen. Shows the soft paywall
/// if the user already has a protocol and is still on the free plan.
Future<void> _onCreateProtocol(BuildContext context) async {
  final sub = context.read<SubscriptionProvider>();
  final protocols = context.read<ProtocolProvider>();
  if (!sub.canAddProtocol(protocols.all.length)) {
    final purchased = await showSoftPaywall(
      context,
      source: 'protocol_limit',
      reason: context.protocolL10n.protocolFreeLimit,
    );
    if (!purchased) return;
    if (!context.mounted) return;
  }
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const CreateProtocolScreen()));
}

// ── Today hero card ──────────────────────────────────────────────────────────
class _TodayHeroCard extends StatelessWidget {
  const _TodayHeroCard({
    required this.taken,
    required this.total,
    required this.adherencePct,
  });

  final int taken;
  final int total;
  final double adherencePct;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: AppColors.borderCyan,
      glowColor: AppColors.primaryGlow,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.protocolL10n.protocolAdherenceTodaySystemLabel,
                  style: AppTypography.systemLabel,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      NumberFormat(
                        '0',
                        context.protocolL10n.localeName,
                      ).format(total == 0 ? 0 : adherencePct),
                      style: AppTypography.heroLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text('%', style: AppTypography.unit),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  total == 0
                      ? context.protocolL10n.protocolNoDosesScheduledToday
                      : context.protocolL10n.protocolDosesTaken(taken, total),
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.base),
          SizedBox(
            width: 72,
            height: 72,
            child: CustomPaint(
              painter: _AdherenceRingPainter(
                progress: total == 0 ? 0 : (taken / total).clamp(0.0, 1.0),
              ),
              child: Center(
                child: Icon(
                  Icons.bolt_rounded,
                  color: AppColors.primary,
                  size: AppSpacing.iconLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Next dose card ──────────────────────────────────────────────────────────
class _NextDoseCard extends StatelessWidget {
  const _NextDoseCard({
    required this.dose,
    required this.labelColorHex,
    required this.onLog,
  });

  final DoseLog dose;
  final String labelColorHex;
  final VoidCallback onLog;

  @override
  Widget build(BuildContext context) {
    final remaining = dose.scheduledAt.difference(DateTime.now());
    return AppCard(
      borderColor: AppColors.border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PeptideLabelSwatch(hex: labelColorHex, size: 8),
              const SizedBox(width: AppSpacing.sm),
              Text(
                context.protocolL10n.protocolNextDose,
                style: AppTypography.systemLabel,
              ),
              const Spacer(),
              Text(
                TimeOfDay.fromDateTime(dose.scheduledAt).format(context),
                style: AppTypography.tabular,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _localizedAmount(context, dose.amountTaken),
                style: AppTypography.heroLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(dose.units, style: AppTypography.unit),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            dose.peptideName +
                (dose.injectionSite.isEmpty
                    ? ''
                    : ' · ${_siteLabel(context, dose.injectionSite)}') +
                _syringeLabel(context, dose.syringeUnits),
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: AppSpacing.base),
          Text(
            context.protocolL10n.protocolInTime(
              _formatDuration(context, remaining),
            ),
            style: AppTypography.tabular.copyWith(
              fontSize: 13,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: context.protocolL10n.protocolLogDose,
            icon: Icons.check_rounded,
            onPressed: onLog,
          ),
        ],
      ),
    );
  }

  String _formatDuration(BuildContext context, Duration d) {
    if (d.isNegative) return context.protocolL10n.protocolNow;
    if (d.inHours > 0) {
      return context.protocolL10n.protocolDurationHoursMinutes(
        d.inHours,
        d.inMinutes.remainder(60),
      );
    }
    return context.protocolL10n.protocolDurationMinutes(d.inMinutes);
  }

  String _siteLabel(BuildContext context, String key) =>
      localizedInjectionSiteLabel(context.protocolL10n, key);

  String _syringeLabel(BuildContext context, double value) {
    if (value <= 0) return '';
    return context.protocolL10n.protocolSyringeUnitsSuffix(
      _localizedAmount(context, value),
    );
  }
}

// ── Dose card for today's list ──────────────────────────────────────────────
class _DoseCard extends StatelessWidget {
  const _DoseCard({
    required this.dose,
    required this.labelColorHex,
    required this.onTap,
  });

  final DoseLog dose;
  final String labelColorHex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isMissed = dose.isMissed(now);
    final taken = dose.isTaken;
    final skipped = dose.skipped;

    Color border;
    Color statusColor;
    IconData? icon;

    if (taken) {
      border = AppColors.borderCyan;
      statusColor = AppColors.primary;
      icon = Icons.check_rounded;
    } else if (skipped) {
      border = AppColors.border;
      statusColor = AppColors.textTertiary;
      icon = Icons.remove_rounded;
    } else if (isMissed) {
      border = AppColors.danger.withValues(alpha: 0.4);
      statusColor = AppColors.danger;
      icon = Icons.priority_high_rounded;
    } else {
      border = AppColors.border;
      statusColor = AppColors.textTertiary;
      icon = null;
    }

    return AppCard(
      onTap: onTap,
      borderColor: border,
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: taken
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.transparent,
              border: Border.all(color: statusColor, width: taken ? 1.5 : 1),
              boxShadow: taken
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
            child: icon == null
                ? null
                : Icon(icon, size: 16, color: statusColor),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    PeptideLabelSwatch(hex: labelColorHex, size: 8),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        dose.peptideName,
                        style: AppTypography.labelLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${_localizedAmount(context, dose.amountTaken)} ${dose.units}'
                  '${_syringeLabel(context, dose.syringeUnits)}'
                  '${dose.injectionSite.isEmpty ? '' : ' · ${_siteLabel(context, dose.injectionSite)}'}',
                  style: AppTypography.bodySmall.copyWith(
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                TimeOfDay.fromDateTime(dose.scheduledAt).format(context),
                style: AppTypography.tabular,
              ),
              if (isMissed && !taken && !skipped)
                Text(
                  context.protocolL10n.protocolMissed,
                  style: AppTypography.systemLabel.copyWith(
                    color: AppColors.danger,
                    fontSize: 9,
                  ),
                ),
              if (skipped)
                Text(
                  context.protocolL10n.protocolSkipped,
                  style: AppTypography.systemLabel.copyWith(
                    color: AppColors.textTertiary,
                    fontSize: 9,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _siteLabel(BuildContext context, String key) =>
      localizedInjectionSiteLabel(context.protocolL10n, key);

  String _syringeLabel(BuildContext context, double value) {
    if (value <= 0) return '';
    return context.protocolL10n.protocolSyringeUnitsSuffix(
      _localizedAmount(context, value),
    );
  }
}

String _localizedAmount(BuildContext context, double value) => NumberFormat(
  value == value.roundToDouble() ? '0' : '0.#',
  context.protocolL10n.localeName,
).format(value);

// ── Empty today state ───────────────────────────────────────────────────────
class _EmptyTodayCard extends StatelessWidget {
  const _EmptyTodayCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.base),
        child: Row(
          children: [
            Icon(
              Icons.event_available_rounded,
              color: AppColors.primary,
              size: AppSpacing.iconLarge,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.protocolL10n.protocolNoDosesToday,
                    style: AppTypography.labelLarge,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    context.protocolL10n.protocolNoDosesTodayBody,
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Adherence ring painter ──────────────────────────────────────────────────
class _AdherenceRingPainter extends CustomPainter {
  _AdherenceRingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 4.0;

    final bgPaint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final progressPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    const startAngle = -1.5708;
    final sweepAngle = 2 * 3.14159 * progress;
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(rect, startAngle, sweepAngle, false, glowPaint);
    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _AdherenceRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
