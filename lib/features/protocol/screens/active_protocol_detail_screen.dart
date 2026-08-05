import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/dose_log.dart';
import '../../../models/protocol.dart';
import '../providers/dose_log_provider.dart';
import '../providers/protocol_provider.dart';
import '../widgets/peptide_label_color.dart';
import '../widgets/protocol_localizations.dart';
import 'create_protocol_screen.dart';

/// Shows all peptides in an active (or paused) protocol with adherence stats,
/// pause / resume / end controls, and per-peptide edit/remove.
class ActiveProtocolDetailScreen extends StatefulWidget {
  const ActiveProtocolDetailScreen({
    super.key,
    required this.protocol,
    this.timelineDate,
  });

  final Protocol protocol;
  final DateTime? timelineDate;

  @override
  State<ActiveProtocolDetailScreen> createState() =>
      _ActiveProtocolDetailScreenState();
}

class _ActiveProtocolDetailScreenState
    extends State<ActiveProtocolDetailScreen> {
  late Protocol _protocol;

  @override
  void initState() {
    super.initState();
    _protocol = widget.protocol;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProtocolProvider>();
    final doseProvider = context.watch<DoseLogProvider>();

    // Refresh local reference from provider (status may have changed).
    final fresh = provider.all.where((p) => p.uuid == _protocol.uuid).toList();
    if (fresh.isNotEmpty) _protocol = fresh.first;

    final last7 = _adherenceLastNDays(doseProvider.recent30, 7);
    final allTime = _adherenceAllTime(doseProvider.recent30);
    final numberFormat = NumberFormat.decimalPattern(
      context.protocolL10n.localeName,
    )..maximumFractionDigits = 0;
    final protocolHistory = provider.history
        .where((p) => p.uuid != _protocol.uuid)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.screenHorizontal,
                0,
              ),
              child: Row(
                children: [
                  IconButton(
                    tooltip: context.protocolL10n.back,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SYS.PROTOCOL // MANAGE',
                          style: AppTypography.systemLabel,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _protocol.name,
                          style: AppTypography.h2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  _StatusPill(status: _protocol.status),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                  AppSpacing.screenHorizontal,
                  AppSpacing.screenBottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Adherence stats
                    Row(
                      children: [
                        Expanded(
                          child: _StatTile(
                            label: context.protocolL10n.activeLastSevenDays,
                            value: '${numberFormat.format(last7)}%',
                            hint: context.protocolL10n.activeAdherence,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.cardGap),
                        Expanded(
                          child: _StatTile(
                            label: context.protocolL10n.activeAllTime,
                            value: '${numberFormat.format(allTime)}%',
                            hint: context.protocolL10n.activeAdherence,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.cardGap),

                    // Start / end dates
                    AppCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.protocolL10n.activeStarted,
                                  style: AppTypography.systemLabel,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  _formatDate(context, _protocol.startDate),
                                  style: AppTypography.tabular.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_protocol.endDate != null)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.protocolL10n.activeEnded,
                                    style: AppTypography.systemLabel,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    _formatDate(context, _protocol.endDate!),
                                    style: AppTypography.tabular.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.cardGap),
                    if (_protocol.notes.trim().isNotEmpty) ...[
                      _ProtocolNotesCard(notes: _protocol.notes),
                      const SizedBox(height: AppSpacing.cardGap),
                    ],
                    _CycleStatusCard(protocol: _protocol),
                    if (_protocol.peptides.any((p) => p.phases.isNotEmpty)) ...[
                      const SizedBox(height: AppSpacing.cardGap),
                      _PhaseTimelineCard(
                        protocol: _protocol,
                        today: widget.timelineDate,
                      ),
                      if (_hasUpcomingPhaseChange(
                        _protocol,
                        widget.timelineDate ?? DateTime.now(),
                      )) ...[
                        const SizedBox(height: AppSpacing.cardGap),
                        _UpcomingChangeRemindersCard(
                          protocol: _protocol,
                          today: widget.timelineDate,
                        ),
                      ],
                    ],
                    const SizedBox(height: AppSpacing.cardGap),
                    _ProtocolHistoryList(protocols: protocolHistory),
                    const SizedBox(height: AppSpacing.xl),

                    // Peptides
                    Text(
                      context.protocolL10n.activeStackCount(
                        _protocol.peptides.length,
                      ),
                      style: AppTypography.systemLabel,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final p in _protocol.peptides) ...[
                      _PeptideRowCard(peptide: p),
                      const SizedBox(height: AppSpacing.cardGap),
                    ],

                    const SizedBox(height: AppSpacing.lg),

                    // Actions
                    if (_protocol.status == ProtocolStatus.active) ...[
                      PrimaryButton(
                        label: context.protocolL10n.activeEditProtocol,
                        icon: Icons.edit_rounded,
                        onPressed: _editProtocol,
                      ),
                      const SizedBox(height: AppSpacing.cardGap),
                      PrimaryButton(
                        label: context.protocolL10n.activePauseProtocol,
                        icon: Icons.pause_rounded,
                        onPressed: () async {
                          HapticFeedback.mediumImpact();
                          await provider.pauseProtocol(_protocol);
                          if (!context.mounted) return;
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: AppSpacing.cardGap),
                      PrimaryButton(
                        label: context.protocolL10n.activeEndProtocol,
                        icon: Icons.stop_rounded,
                        isDestructive: true,
                        onPressed: () => _confirmEnd(provider),
                      ),
                    ] else if (_protocol.status == ProtocolStatus.paused) ...[
                      PrimaryButton(
                        label: context.protocolL10n.activeEditProtocol,
                        icon: Icons.edit_rounded,
                        onPressed: _editProtocol,
                      ),
                      const SizedBox(height: AppSpacing.cardGap),
                      PrimaryButton(
                        label: context.protocolL10n.activeResumeProtocol,
                        icon: Icons.play_arrow_rounded,
                        onPressed: () async {
                          HapticFeedback.mediumImpact();
                          await provider.resumeProtocol(_protocol);
                          if (!context.mounted) return;
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: AppSpacing.cardGap),
                      PrimaryButton(
                        label: context.protocolL10n.activeEndProtocol,
                        icon: Icons.stop_rounded,
                        isDestructive: true,
                        onPressed: () => _confirmEnd(provider),
                      ),
                    ] else ...[
                      PrimaryButton(
                        label: context.protocolL10n.activeDeleteProtocol,
                        icon: Icons.delete_outline_rounded,
                        isDestructive: true,
                        onPressed: () => _confirmDelete(provider),
                      ),
                    ],

                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      context.protocolL10n.activeTrackingDisclaimer,
                      style: AppTypography.disclaimer,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static bool _hasUpcomingPhaseChange(Protocol protocol, DateTime today) {
    final day = DateTime(today.year, today.month, today.day);
    return protocol.peptides.any(
      (peptide) => peptide.phases.any(
        (phase) => phase.startsOn(protocol.startDate).isAfter(day),
      ),
    );
  }

  Future<void> _editProtocol() async {
    HapticFeedback.lightImpact();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateProtocolScreen(initialProtocol: _protocol),
      ),
    );
    if (!mounted) return;
    await context.read<ProtocolProvider>().refresh();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _confirmEnd(ProtocolProvider provider) async {
    final ok = await _confirmDialog(isDelete: false);
    if (!ok) return;
    await provider.endProtocol(_protocol);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _confirmDelete(ProtocolProvider provider) async {
    final ok = await _confirmDialog(isDelete: true);
    if (!ok) return;
    await provider.deleteProtocol(_protocol);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<bool> _confirmDialog({required bool isDelete}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final l10n = ctx.protocolL10n;
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            side: const BorderSide(color: AppColors.border),
          ),
          title: Text(
            isDelete ? l10n.activeDeleteQuestion : l10n.activeEndQuestion,
            style: AppTypography.h3,
          ),
          content: Text(
            isDelete ? l10n.activeDeleteBody : l10n.activeEndBody,
            style: AppTypography.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                l10n.cancel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(
                isDelete ? l10n.activeDeleteAction : l10n.activeEndAction,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.warning,
                ),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  double _adherenceLastNDays(List<DoseLog> recent, int days) {
    final now = DateTime.now();
    final cutoff = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: days - 1));
    final scoped = recent
        .where(
          (d) =>
              d.protocolUuid == _protocol.uuid &&
              d.scheduledAt.isAfter(cutoff) &&
              d.scheduledAt.isBefore(now),
        )
        .where((d) => !d.skipped)
        .toList();
    if (scoped.isEmpty) return 0;
    final taken = scoped.where((d) => d.isTaken).length;
    return (taken / scoped.length) * 100;
  }

  double _adherenceAllTime(List<DoseLog> recent) {
    final now = DateTime.now();
    final scoped = recent
        .where(
          (d) =>
              d.protocolUuid == _protocol.uuid &&
              d.scheduledAt.isBefore(now) &&
              !d.skipped,
        )
        .toList();
    if (scoped.isEmpty) return 0;
    final taken = scoped.where((d) => d.isTaken).length;
    return (taken / scoped.length) * 100;
  }

  String _formatDate(BuildContext context, DateTime d) =>
      MaterialLocalizations.of(context).formatMediumDate(d);
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});
  final ProtocolStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      ProtocolStatus.active => (
        AppColors.primary,
        context.protocolL10n.activeStatusActive,
      ),
      ProtocolStatus.paused => (
        AppColors.danger,
        context.protocolL10n.activeStatusPaused,
      ),
      ProtocolStatus.ended => (
        AppColors.textTertiary,
        context.protocolL10n.activeStatusEnded,
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: AppTypography.systemLabel.copyWith(color: color, fontSize: 9),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.hint,
  });
  final String label;
  final String value;
  final String hint;

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
            style: AppTypography.heroMedium.copyWith(
              color: AppColors.primary,
              fontSize: 28,
            ),
          ),
          Text(hint, style: AppTypography.bodySmall),
        ],
      ),
    );
  }
}

class _ProtocolNotesCard extends StatelessWidget {
  const _ProtocolNotesCard({required this.notes});

  final String notes;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: AppColors.borderCyan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.notes_rounded,
                size: AppSpacing.iconMedium,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                context.protocolL10n.activeNotesLabel,
                style: AppTypography.systemLabel,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            notes.trim(),
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingChangeRemindersCard extends StatelessWidget {
  const _UpcomingChangeRemindersCard({required this.protocol, this.today});

  final Protocol protocol;
  final DateTime? today;

  @override
  Widget build(BuildContext context) {
    final effectiveToday = today ?? DateTime.now();
    final day = DateTime(
      effectiveToday.year,
      effectiveToday.month,
      effectiveToday.day,
    );
    final changes = <({String peptide, ProtocolPhase phase, DateTime date})>[];
    for (final peptide in protocol.peptides) {
      for (final phase in peptide.phases) {
        final date = phase.startsOn(protocol.startDate);
        if (date.isAfter(day)) {
          changes.add((peptide: peptide.peptideName, phase: phase, date: date));
        }
      }
    }
    changes.sort((a, b) => a.date.compareTo(b.date));

    return AppCard(
      borderColor: AppColors.aiInsightBright.withValues(alpha: 0.45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.notifications_active_outlined,
                size: AppSpacing.iconMedium,
                color: AppColors.aiInsightBright,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  context.protocolL10n.activeChangeReminders,
                  style: AppTypography.systemLabel.copyWith(
                    color: AppColors.aiInsightBright,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            context.protocolL10n.activeChangeRemindersBody,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.base),
          for (var index = 0; index < changes.length; index++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: const BoxDecoration(
                    color: AppColors.aiInsightBright,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${changes[index].peptide} · ${changes[index].phase.name}',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${MaterialLocalizations.of(context).formatShortDate(changes[index].date)} · ${const TimeOfDay(hour: 9, minute: 0).format(context)}',
                        style: AppTypography.tabular.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (index != changes.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _CycleStatusCard extends StatelessWidget {
  const _CycleStatusCard({required this.protocol});
  final Protocol protocol;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CYCLE.STATUS', style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.sm),
          for (final peptide in protocol.peptides) ...[
            _CycleStatusRow(
              peptide: peptide,
              protocolStart: protocol.startDate,
              now: now,
            ),
            if (peptide != protocol.peptides.last)
              const SizedBox(height: AppSpacing.base),
          ],
        ],
      ),
    );
  }
}

class _PhaseTimelineCard extends StatelessWidget {
  const _PhaseTimelineCard({required this.protocol, this.today});

  final Protocol protocol;
  final DateTime? today;

  @override
  Widget build(BuildContext context) {
    final effectiveToday = today ?? DateTime.now();
    return AppCard(
      borderColor: AppColors.borderCyan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PHASE.TIMELINE', style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.xs),
          Text(
            context.protocolL10n.activePhaseAnchor(
              MaterialLocalizations.of(
                context,
              ).formatShortDate(protocol.startDate),
            ),
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: AppSpacing.base),
          for (final peptide in protocol.peptides.where(
            (p) => p.phases.isNotEmpty,
          )) ...[
            Text(peptide.peptideName, style: AppTypography.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            for (final phase in peptide.phases) ...[
              _PhaseTimelineRow(
                phase: phase,
                protocolStart: protocol.startDate,
                active:
                    peptide
                        .phaseForDate(
                          protocolStart: protocol.startDate,
                          date: effectiveToday,
                        )
                        ?.uuid ==
                    phase.uuid,
              ),
              if (phase != peptide.phases.last)
                const SizedBox(height: AppSpacing.sm),
            ],
            if (peptide !=
                protocol.peptides.where((p) => p.phases.isNotEmpty).last)
              const SizedBox(height: AppSpacing.base),
          ],
        ],
      ),
    );
  }
}

class _PhaseTimelineRow extends StatelessWidget {
  const _PhaseTimelineRow({
    required this.phase,
    required this.protocolStart,
    required this.active,
  });

  final ProtocolPhase phase;
  final DateTime protocolStart;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final start = phase.startsOn(protocolStart);
    final inclusiveEnd = phase
        .endsOn(protocolStart)
        .subtract(const Duration(days: 1));
    final l10n = context.protocolL10n;
    final range = phase.startWeek == phase.endWeek
        ? l10n.activeWeek(phase.startWeek)
        : l10n.activeWeeks(phase.startWeek, phase.endWeek);
    final amount =
        phase.frequency == kCustomWeekdayFrequency &&
            phase.weekdayDoses.isNotEmpty
        ? l10n.activePerDayAmounts
        : phase.dosePerInjection == null
        ? l10n.activeBaseAmount
        : '${_amount(l10n, phase.dosePerInjection!)} ${phase.doseUnit ?? ''}';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.surfaceElevated,
            shape: BoxShape.circle,
            border: Border.all(
              color: active ? AppColors.primary : AppColors.border,
            ),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 6,
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(phase.name, style: AppTypography.labelMedium),
                  ),
                  if (active)
                    Text(
                      l10n.activeCurrent,
                      style: AppTypography.systemLabel.copyWith(fontSize: 8),
                    ),
                ],
              ),
              Text(
                '$range · ${MaterialLocalizations.of(context).formatShortDate(start)}–${MaterialLocalizations.of(context).formatShortDate(inclusiveEnd)}',
                style: AppTypography.tabular.copyWith(
                  fontSize: 11,
                  color: AppColors.textTertiary,
                ),
              ),
              Text(
                '$amount · ${_frequency(l10n, phase.frequency)}',
                style: AppTypography.bodySmall,
              ),
              if (phase.note.trim().isNotEmpty)
                Text(
                  phase.note.trim(),
                  style: AppTypography.disclaimer,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }

  static String _amount(AppLocalizations l10n, double value) {
    final format = NumberFormat.decimalPattern(l10n.localeName)
      ..maximumFractionDigits = 1;
    return format.format(value);
  }

  static String _frequency(AppLocalizations l10n, String? key) => switch (key) {
    null => l10n.activeBaseSchedule,
    'daily' => l10n.frequencyDaily,
    'eod' => l10n.frequencyEveryOtherDay,
    'twice_weekly' => l10n.frequencyTwiceWeekly,
    'weekly' => l10n.frequencyWeekly,
    'as_needed' => l10n.frequencyAsNeeded,
    'custom_weekdays' => l10n.activeCustomDays,
    _ => l10n.activeBaseSchedule,
  };
}

class _CycleStatusRow extends StatelessWidget {
  const _CycleStatusRow({
    required this.peptide,
    required this.protocolStart,
    required this.now,
  });

  final ProtocolPeptide peptide;
  final DateTime protocolStart;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final (label, detail, color) = _state(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 6),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(peptide.peptideName, style: AppTypography.labelLarge),
              const SizedBox(height: 2),
              Text(label, style: AppTypography.bodySmall),
              Text(
                detail,
                style: AppTypography.tabular.copyWith(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  (String, String, Color) _state(BuildContext context) {
    final l10n = context.protocolL10n;
    final material = MaterialLocalizations.of(context);
    final today = DateTime(now.year, now.month, now.day);
    final cycleEnd = peptide.cycleEndDate(protocolStart);
    if (cycleEnd == null) {
      return (
        l10n.activeContinuousTracking,
        l10n.activeNoFixedCycle,
        AppColors.primary,
      );
    }

    if (peptide.isInActiveCycle(protocolStart: protocolStart, date: today)) {
      final day = today
          .difference(
            DateTime(
              protocolStart.year,
              protocolStart.month,
              protocolStart.day,
            ),
          )
          .inDays;
      final week = (day ~/ 7) + 1;
      return (
        l10n.activeCycleProgress(
          week.clamp(1, peptide.cycleWeeks),
          peptide.cycleWeeks,
        ),
        l10n.activeCycleEnds(material.formatShortDate(cycleEnd)),
        AppColors.primary,
      );
    }

    if (peptide.isInWashout(protocolStart: protocolStart, date: today)) {
      final washoutEnd = peptide.washoutEndDate(protocolStart)!;
      final restDay = today.difference(cycleEnd).inDays;
      final restWeek = (restDay ~/ 7) + 1;
      return (
        l10n.activeRestProgress(
          restWeek.clamp(1, peptide.washoutWeeks),
          peptide.washoutWeeks,
        ),
        l10n.activeRestEnds(material.formatShortDate(washoutEnd)),
        AppColors.danger,
      );
    }

    final washoutEnd = peptide.washoutEndDate(protocolStart);
    return (
      l10n.activeCycleComplete,
      washoutEnd == null || washoutEnd == cycleEnd
          ? l10n.activeCompletedDate(material.formatShortDate(cycleEnd))
          : l10n.activeRestEnded(material.formatShortDate(washoutEnd)),
      AppColors.textTertiary,
    );
  }
}

class _ProtocolHistoryList extends StatelessWidget {
  const _ProtocolHistoryList({required this.protocols});
  final List<Protocol> protocols;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PROTOCOL.HISTORY', style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.sm),
          if (protocols.isEmpty)
            Text(
              context.protocolL10n.activeNoHistory,
              style: AppTypography.bodySmall,
            )
          else
            for (final p in protocols) ...[
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ActiveProtocolDetailScreen(protocol: p),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.name, style: AppTypography.labelLarge),
                            Text(
                              '${_statusLabel(context, p.status)} · ${MaterialLocalizations.of(context).formatMediumDate(p.startDate)}',
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textTertiary,
                        size: AppSpacing.iconMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
        ],
      ),
    );
  }

  String _statusLabel(BuildContext context, ProtocolStatus status) =>
      switch (status) {
        ProtocolStatus.active => context.protocolL10n.activeStatusActive,
        ProtocolStatus.paused => context.protocolL10n.activeStatusPaused,
        ProtocolStatus.ended => context.protocolL10n.activeStatusEnded,
      };
}

class _PeptideRowCard extends StatelessWidget {
  const _PeptideRowCard({required this.peptide});
  final ProtocolPeptide peptide;

  String _formatAmount(AppLocalizations l10n, double value) {
    final format = NumberFormat.decimalPattern(l10n.localeName)
      ..maximumFractionDigits = 1;
    return format.format(value);
  }

  String _freqLabel(AppLocalizations l10n, String key) => switch (key) {
    'daily' => l10n.frequencyDaily,
    'eod' => l10n.frequencyEveryOtherDay,
    'twice_weekly' => l10n.frequencyTwiceWeekly,
    'weekly' => l10n.frequencyWeekly,
    'as_needed' => l10n.frequencyAsNeeded,
    _ => key,
  };

  String _weekdayLabel(BuildContext context, int weekday) =>
      MaterialLocalizations.of(context).narrowWeekdays[weekday % 7];

  String _scheduleSummary(BuildContext context) {
    final l10n = context.protocolL10n;
    if (peptide.isBlend) {
      return '${l10n.activeSyringeUnits(_formatAmount(l10n, peptide.syringeUnits))} · '
          '${_freqLabel(l10n, peptide.frequency)} · '
          '${l10n.activeCompoundsCount(peptide.blendVial!.constituents.length)}';
    }
    if (!peptide.usesCustomWeekdays) {
      return '${_formatAmount(l10n, peptide.dosePerInjection)} ${peptide.doseUnit} · '
          '${_freqLabel(l10n, peptide.frequency)}${_syringeSummary(l10n, peptide.syringeUnits)}';
    }
    final days = [...peptide.weekdayDoses]
      ..sort((a, b) => a.weekday.compareTo(b.weekday));
    return days
        .map(
          (d) =>
              '${_weekdayLabel(context, d.weekday)} ${_formatAmount(l10n, d.dosePerInjection)} ${d.doseUnit}${_syringeSummary(l10n, d.syringeUnits)}',
        )
        .join(', ');
  }

  String _syringeSummary(AppLocalizations l10n, double value) {
    if (value <= 0) return '';
    return l10n.protocolSyringeUnitsSuffix(_formatAmount(l10n, value));
  }

  String _routeLabel(AppLocalizations l10n, String key) => switch (key) {
    'subcutaneous' => l10n.routeSubcutaneous,
    'intramuscular' => l10n.routeIntramuscular,
    'oral' => l10n.routeOral,
    'nasal' => l10n.routeNasal,
    _ => key,
  };

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PeptideLabelAvatar(hex: peptide.labelColorHex),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(peptide.peptideName, style: AppTypography.labelLarge),
                    Text(
                      _scheduleSummary(context),
                      style: AppTypography.bodySmall.copyWith(
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (peptide.isBlend) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                border: Border.all(color: AppColors.borderCyan),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.protocolL10n.activePerDraw,
                    style: AppTypography.systemLabel,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  for (final item in peptide.blendVial!.constituents)
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: AppTypography.bodySmall,
                            ),
                          ),
                          Text(
                            '${_formatAmount(context.protocolL10n, peptide.blendVial!.amountPerDraw(item))} ${item.unit}',
                            style: AppTypography.tabular.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    context.protocolL10n.activeVialSummary(
                      _formatAmount(
                        context.protocolL10n,
                        peptide.blendVial!.diluentMl,
                      ),
                    ),
                    style: AppTypography.disclaimer,
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              _Tag(label: _routeLabel(context.protocolL10n, peptide.route)),
              if (peptide.cycleWeeks > 0)
                _Tag(
                  label: context.protocolL10n.activeCycleWeeks(
                    peptide.cycleWeeks,
                  ),
                ),
              if (peptide.washoutWeeks > 0)
                _Tag(
                  label: context.protocolL10n.activeRestWeeks(
                    peptide.washoutWeeks,
                  ),
                ),
              if (peptide.syringeUnits > 0)
                _Tag(
                  label: context.protocolL10n.activeSyringeUnits(
                    _formatAmount(context.protocolL10n, peptide.syringeUnits),
                  ),
                ),
              if (peptide.usesCustomWeekdays)
                for (final d in ([
                  ...peptide.weekdayDoses,
                ]..sort((a, b) => a.weekday.compareTo(b.weekday))))
                  _Tag(
                    label:
                        '${_weekdayLabel(context, d.weekday)} ${_formatAmount(context.protocolL10n, d.dosePerInjection)} ${d.doseUnit}${_syringeSummary(context.protocolL10n, d.syringeUnits)}',
                  ),
              for (final t in peptide.scheduledTimes)
                _Tag(label: _localizedStoredTime(context, t)),
            ],
          ),
        ],
      ),
    );
  }
}

String _localizedStoredTime(BuildContext context, String value) {
  final parts = value.split(':');
  final hour = parts.isNotEmpty ? int.tryParse(parts.first) : null;
  final minute = parts.length > 1 ? int.tryParse(parts[1]) : null;
  if (hour == null || minute == null) return value;
  return TimeOfDay(hour: hour, minute: minute).format(context);
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: AppTypography.labelMedium.copyWith(
          fontSize: 11,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
