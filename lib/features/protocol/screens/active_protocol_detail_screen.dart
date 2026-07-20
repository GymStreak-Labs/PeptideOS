import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/dose_log.dart';
import '../../../models/protocol.dart';
import '../providers/dose_log_provider.dart';
import '../providers/protocol_provider.dart';
import '../widgets/peptide_label_color.dart';
import 'create_protocol_screen.dart';

/// Shows all peptides in an active (or paused) protocol with adherence stats,
/// pause / resume / end controls, and per-peptide edit/remove.
class ActiveProtocolDetailScreen extends StatefulWidget {
  const ActiveProtocolDetailScreen({super.key, required this.protocol});

  final Protocol protocol;

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
                            label: 'LAST 7 DAYS',
                            value: '${last7.toStringAsFixed(0)}%',
                            hint: 'adherence',
                          ),
                        ),
                        const SizedBox(width: AppSpacing.cardGap),
                        Expanded(
                          child: _StatTile(
                            label: 'ALL TIME',
                            value: '${allTime.toStringAsFixed(0)}%',
                            hint: 'adherence',
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
                                  'STARTED',
                                  style: AppTypography.systemLabel,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  _formatDate(_protocol.startDate),
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
                                    'ENDED',
                                    style: AppTypography.systemLabel,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    _formatDate(_protocol.endDate!),
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
                    _CycleStatusCard(protocol: _protocol),
                    const SizedBox(height: AppSpacing.cardGap),
                    _ProtocolHistoryList(protocols: protocolHistory),
                    const SizedBox(height: AppSpacing.xl),

                    // Peptides
                    Text(
                      'STACK (${_protocol.peptides.length})',
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
                        label: 'EDIT PROTOCOL',
                        icon: Icons.edit_rounded,
                        onPressed: _editProtocol,
                      ),
                      const SizedBox(height: AppSpacing.cardGap),
                      PrimaryButton(
                        label: 'PAUSE PROTOCOL',
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
                        label: 'END PROTOCOL',
                        icon: Icons.stop_rounded,
                        isDestructive: true,
                        onPressed: () => _confirmEnd(provider),
                      ),
                    ] else if (_protocol.status == ProtocolStatus.paused) ...[
                      PrimaryButton(
                        label: 'EDIT PROTOCOL',
                        icon: Icons.edit_rounded,
                        onPressed: _editProtocol,
                      ),
                      const SizedBox(height: AppSpacing.cardGap),
                      PrimaryButton(
                        label: 'RESUME PROTOCOL',
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
                        label: 'END PROTOCOL',
                        icon: Icons.stop_rounded,
                        isDestructive: true,
                        onPressed: () => _confirmEnd(provider),
                      ),
                    ] else ...[
                      PrimaryButton(
                        label: 'DELETE PROTOCOL',
                        icon: Icons.delete_outline_rounded,
                        isDestructive: true,
                        onPressed: () => _confirmDelete(provider),
                      ),
                    ],

                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Educational tracking only. Consult a qualified healthcare provider before making changes.',
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
    final ok = await _confirmDialog(
      title: 'End protocol?',
      body:
          'Future doses will be removed. Past logs stay in your history. This cannot be undone.',
      confirmLabel: 'END',
    );
    if (!ok) return;
    await provider.endProtocol(_protocol);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _confirmDelete(ProtocolProvider provider) async {
    final ok = await _confirmDialog(
      title: 'Delete protocol?',
      body:
          'This permanently removes the protocol and all its dose logs. This cannot be undone.',
      confirmLabel: 'DELETE',
    );
    if (!ok) return;
    await provider.deleteProtocol(_protocol);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<bool> _confirmDialog({
    required String title,
    required String body,
    required String confirmLabel,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Text(title, style: AppTypography.h3),
        content: Text(body, style: AppTypography.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancel',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              confirmLabel,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
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

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  String _formatDate(DateTime d) =>
      '${_months[d.month - 1]} ${d.day}, ${d.year}';
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});
  final ProtocolStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      ProtocolStatus.active => (AppColors.primary, 'ACTIVE'),
      ProtocolStatus.paused => (AppColors.danger, 'PAUSED'),
      ProtocolStatus.ended => (AppColors.textTertiary, 'ENDED'),
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
    final (label, detail, color) = _state();
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

  (String, String, Color) _state() {
    final today = DateTime(now.year, now.month, now.day);
    final cycleEnd = peptide.cycleEndDate(protocolStart);
    if (cycleEnd == null) {
      return (
        'Continuous tracking',
        'No fixed cycle window',
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
        'Week ${week.clamp(1, peptide.cycleWeeks)} of ${peptide.cycleWeeks}',
        'Cycle ends ${_formatDate(cycleEnd)}',
        AppColors.primary,
      );
    }

    if (peptide.isInWashout(protocolStart: protocolStart, date: today)) {
      final washoutEnd = peptide.washoutEndDate(protocolStart)!;
      final restDay = today.difference(cycleEnd).inDays;
      final restWeek = (restDay ~/ 7) + 1;
      return (
        'Rest week ${restWeek.clamp(1, peptide.washoutWeeks)} of ${peptide.washoutWeeks}',
        'Rest window ends ${_formatDate(washoutEnd)}',
        AppColors.danger,
      );
    }

    final washoutEnd = peptide.washoutEndDate(protocolStart);
    return (
      'Cycle complete',
      washoutEnd == null || washoutEnd == cycleEnd
          ? 'Completed ${_formatDate(cycleEnd)}'
          : 'Rest window ended ${_formatDate(washoutEnd)}',
      AppColors.textTertiary,
    );
  }

  static String _formatDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}';
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
              'No paused or ended protocols yet.',
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
                              '${p.status.label} · ${_formatDate(p.startDate)}',
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

  String _formatDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }
}

class _PeptideRowCard extends StatelessWidget {
  const _PeptideRowCard({required this.peptide});
  final ProtocolPeptide peptide;

  String _formatAmount(double d) =>
      d == d.roundToDouble() ? d.toStringAsFixed(0) : d.toStringAsFixed(1);

  String _freqLabel(String key) {
    for (final f in kFrequencies) {
      if (f.key == key) return f.label;
    }
    return key;
  }

  String _weekdayLabel(int weekday) => switch (weekday) {
    DateTime.monday => 'Mon',
    DateTime.tuesday => 'Tue',
    DateTime.wednesday => 'Wed',
    DateTime.thursday => 'Thu',
    DateTime.friday => 'Fri',
    DateTime.saturday => 'Sat',
    DateTime.sunday => 'Sun',
    _ => 'Day',
  };

  String _scheduleSummary() {
    if (!peptide.usesCustomWeekdays) {
      return '${_formatAmount(peptide.dosePerInjection)} ${peptide.doseUnit} · '
          '${_freqLabel(peptide.frequency)}${_syringeSummary(peptide.syringeUnits)}';
    }
    final days = [...peptide.weekdayDoses]
      ..sort((a, b) => a.weekday.compareTo(b.weekday));
    return days
        .map(
          (d) =>
              '${_weekdayLabel(d.weekday)} ${_formatAmount(d.dosePerInjection)} ${d.doseUnit}${_syringeSummary(d.syringeUnits)}',
        )
        .join(', ');
  }

  String _syringeSummary(double value) {
    if (value <= 0) return '';
    return ' · ${_formatAmount(value)} syringe units';
  }

  String _routeLabel(String key) {
    for (final r in kRoutes) {
      if (r.key == key) return r.label;
    }
    return key;
  }

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
                      _scheduleSummary(),
                      style: AppTypography.bodySmall.copyWith(
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              _Tag(label: _routeLabel(peptide.route)),
              if (peptide.cycleWeeks > 0)
                _Tag(label: '${peptide.cycleWeeks}wk cycle'),
              if (peptide.washoutWeeks > 0)
                _Tag(label: '${peptide.washoutWeeks}wk rest'),
              if (peptide.syringeUnits > 0)
                _Tag(
                  label: '${_formatAmount(peptide.syringeUnits)} syringe units',
                ),
              if (peptide.usesCustomWeekdays)
                for (final d in ([
                  ...peptide.weekdayDoses,
                ]..sort((a, b) => a.weekday.compareTo(b.weekday))))
                  _Tag(
                    label:
                        '${_weekdayLabel(d.weekday)} ${_formatAmount(d.dosePerInjection)} ${d.doseUnit}${_syringeSummary(d.syringeUnits)}',
                  ),
              for (final t in peptide.scheduledTimes) _Tag(label: t),
            ],
          ),
        ],
      ),
    );
  }
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
