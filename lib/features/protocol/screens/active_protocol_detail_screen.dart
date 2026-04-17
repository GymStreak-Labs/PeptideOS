import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/dose_log.dart';
import '../../../models/protocol.dart';
import '../providers/dose_log_provider.dart';
import '../providers/protocol_provider.dart';

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
    final fresh =
        provider.all.where((p) => p.uuid == _protocol.uuid).toList();
    if (fresh.isNotEmpty) _protocol = fresh.first;

    final last7 = _adherenceLastNDays(doseProvider.recent30, 7);
    final allTime = _adherenceAllTime(doseProvider.recent30);

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
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: AppColors.textPrimary),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SYS.PROTOCOL // MANAGE',
                            style: AppTypography.systemLabel),
                        const SizedBox(height: 2),
                        Text(_protocol.name,
                            style: AppTypography.h2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
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
                                Text('STARTED',
                                    style: AppTypography.systemLabel),
                                const SizedBox(height: AppSpacing.xs),
                                Text(_formatDate(_protocol.startDate),
                                    style: AppTypography.tabular
                                        .copyWith(fontSize: 16)),
                              ],
                            ),
                          ),
                          if (_protocol.endDate != null)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ENDED',
                                      style: AppTypography.systemLabel),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(_formatDate(_protocol.endDate!),
                                      style: AppTypography.tabular
                                          .copyWith(fontSize: 16)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Peptides
                    Text('PEPTIDES (${_protocol.peptides.length})',
                        style: AppTypography.systemLabel),
                    const SizedBox(height: AppSpacing.sm),
                    for (final p in _protocol.peptides) ...[
                      _PeptideRowCard(peptide: p),
                      const SizedBox(height: AppSpacing.cardGap),
                    ],

                    const SizedBox(height: AppSpacing.lg),

                    // Actions
                    if (_protocol.status == ProtocolStatus.active) ...[
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
            child: Text('Cancel',
                style: AppTypography.labelMedium
                    .copyWith(color: AppColors.textTertiary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(confirmLabel,
                style: AppTypography.labelMedium
                    .copyWith(color: AppColors.warning)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  double _adherenceLastNDays(List<DoseLog> recent, int days) {
    final now = DateTime.now();
    final cutoff = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: days - 1));
    final scoped = recent
        .where((d) =>
            d.protocolUuid == _protocol.uuid &&
            d.scheduledAt.isAfter(cutoff) &&
            d.scheduledAt.isBefore(now))
        .where((d) => !d.skipped)
        .toList();
    if (scoped.isEmpty) return 0;
    final taken = scoped.where((d) => d.isTaken).length;
    return (taken / scoped.length) * 100;
  }

  double _adherenceAllTime(List<DoseLog> recent) {
    final now = DateTime.now();
    final scoped = recent
        .where((d) =>
            d.protocolUuid == _protocol.uuid &&
            d.scheduledAt.isBefore(now) &&
            !d.skipped)
        .toList();
    if (scoped.isEmpty) return 0;
    final taken = scoped.where((d) => d.isTaken).length;
    return (taken / scoped.length) * 100;
  }

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
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
          horizontal: AppSpacing.sm, vertical: 4),
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
          Text(value,
              style: AppTypography.heroMedium
                  .copyWith(color: AppColors.primary, fontSize: 28)),
          Text(hint, style: AppTypography.bodySmall),
        ],
      ),
    );
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.biotech_rounded,
                    color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(peptide.peptideName,
                        style: AppTypography.labelLarge),
                    Text(
                      '${_formatAmount(peptide.dosePerInjection)} ${peptide.doseUnit} · ${_freqLabel(peptide.frequency)}',
                      style: AppTypography.bodySmall
                          .copyWith(fontFamily: 'JetBrainsMono'),
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
              for (final t in peptide.scheduledTimes)
                _Tag(label: t),
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
          horizontal: AppSpacing.sm, vertical: 4),
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
