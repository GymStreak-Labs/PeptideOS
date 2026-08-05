import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';

/// Screen 9: Protocol Preview — "Your protocol is ready."
/// Shows a personalised mock protocol based on their selections.
/// This is THEIR data — can't get it without subscribing.
class ProtocolPreviewPage extends StatelessWidget {
  const ProtocolPreviewPage({
    super.key,
    required this.peptides,
    required this.onNext,
  });

  final Set<String> peptides;
  final VoidCallback onNext;

  List<String> get _displayPeptides =>
      peptides.isEmpty ? ['BPC-157', 'TB-500'] : peptides.toList();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.huge),

            Text('SYS.PROTOCOL // GENERATED', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.protocolPreviewTitle,
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Protocol card
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppCard(
                      borderColor: AppColors.borderCyan,
                      glowColor: AppColors.primaryGlow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.6,
                                      ),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'PROTOCOL.ACTIVE',
                                style: AppTypography.systemLabel,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.base),

                          Text(l10n.customProtocol, style: AppTypography.h3),
                          const SizedBox(height: AppSpacing.sm),

                          // Peptide list
                          ..._displayPeptides.map(
                            (p) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.biotech_rounded,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Text(
                                      p,
                                      style: AppTypography.labelLarge,
                                    ),
                                  ),
                                  Text(
                                    l10n.trackedLabel,
                                    style: AppTypography.tabular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Divider(height: AppSpacing.xl),

                          // Schedule preview
                          Text(
                            l10n.schedulePreview,
                            style: AppTypography.systemLabel.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),

                          _ScheduleRow(
                            time: '08:00',
                            peptides: _displayPeptides,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _ScheduleRow(
                            time: '20:00',
                            peptides: _displayPeptides.take(1).toList(),
                          ),

                          const Divider(height: AppSpacing.xl),

                          // Stats
                          Row(
                            children: [
                              _StatBlock(
                                label: l10n.dosesPerDay,
                                value: '${_displayPeptides.length + 1}',
                              ),
                              _StatBlock(
                                label: l10n.durationLabel,
                                value: l10n.weeksCount(8),
                              ),
                              _StatBlock(
                                label: l10n.viewLabel,
                                value: l10n.timelineLabel,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.base),

                    // Blurred teaser — shows there's more behind the paywall
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.cardRadius,
                        ),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock_outline_rounded,
                              size: 20,
                              color: AppColors.textDisabled,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              l10n.subscribeToActivate,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textDisabled,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.base),

            PrimaryButton(label: l10n.unlockPepMod, onPressed: onNext),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  const _ScheduleRow({required this.time, required this.peptides});
  final String time;
  final List<String> peptides;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time, style: AppTypography.tabular.copyWith(fontSize: 14)),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: peptides
                .map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(p, style: AppTypography.bodySmall),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppTypography.heroSmall.copyWith(
              fontSize: 18,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.systemLabel.copyWith(
              fontSize: 8,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
