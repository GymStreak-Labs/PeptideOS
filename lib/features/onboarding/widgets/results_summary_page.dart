import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen 13: Personalised Results Summary — "Your protocol is ready."
/// Echoes the user's inputs back at them. The sunk-cost payoff.
class ResultsSummaryPage extends StatelessWidget {
  const ResultsSummaryPage({
    super.key,
    required this.selectedGoals,
    required this.experienceLevel,
    required this.frustration,
    required this.selectedPeptides,
    required this.onNext,
  });

  final Set<String> selectedGoals;
  final String experienceLevel;
  final String frustration;
  final Set<String> selectedPeptides;
  final VoidCallback onNext;

  String get _goalsDisplay {
    if (selectedGoals.isEmpty) return 'Recovery · Longevity';
    return selectedGoals.join(' · ');
  }

  String get _experienceDisplay =>
      experienceLevel.isEmpty ? 'Intermediate' : experienceLevel;

  String get _frustrationDisplay =>
      frustration.isEmpty ? 'Missing doses' : frustration;

  String get _peptidesDisplay {
    if (selectedPeptides.isEmpty) return 'BPC-157, TB-500';
    final list = selectedPeptides.toList();
    if (list.length <= 3) return list.join(', ');
    final shown = list.take(3).join(', ');
    final more = list.length - 3;
    return '$shown +$more more';
  }

  int get _peptideCount =>
      selectedPeptides.isEmpty ? 2 : selectedPeptides.length;

  int get _dosesPerDay {
    if (selectedPeptides.isEmpty) return 2;
    return selectedPeptides.length;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.huge),

            Text('SYS.PROFILE // COMPILED',
                style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Your protocol\nis ready',
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Based on your inputs //',
              style: AppTypography.systemLabel.copyWith(
                color: AppColors.primary,
                fontSize: 11,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Card 1 — user inputs
                    AppCard(
                      borderColor: AppColors.border,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SummaryRow(
                            label: 'GOALS',
                            value: _goalsDisplay,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _SummaryRow(
                            label: 'EXPERIENCE',
                            value: _experienceDisplay,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _SummaryRow(
                            label: 'FRUSTRATION',
                            value: _frustrationDisplay,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _SummaryRow(
                            label: 'PEPTIDES',
                            value: _peptidesDisplay,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.base),

                    // Card 2 — protocol includes
                    AppCard(
                      borderColor: AppColors.borderCyan,
                      glowColor: AppColors.primaryGlow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'YOUR PROTOCOL INCLUDES //',
                            style: AppTypography.systemLabel.copyWith(
                              fontSize: 10,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            children: [
                              _DataTile(
                                value: '$_dosesPerDay',
                                label: 'DOSES/DAY',
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _DataTile(
                                value: '$_peptideCount',
                                label: 'PEPTIDES\nTRACKED',
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _DataTile(
                                value: '12',
                                label: 'WEEK\nDURATION',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    Text(
                      'We\'ll track every dose, compute exact reconstitution, and surface insights as your data builds.',
                      style: AppTypography.bodyMedium.copyWith(
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.base),

            PrimaryButton(
              label: 'SEE WHAT\'S INSIDE',
              onPressed: onNext,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: AppTypography.systemLabel.copyWith(
              fontSize: 10,
              color: AppColors.textTertiary,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _DataTile extends StatelessWidget {
  const _DataTile({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.heroSmall.copyWith(
                fontSize: 24,
                color: AppColors.primary,
                shadows: [
                  Shadow(
                    color: AppColors.primary.withValues(alpha: 0.6),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.systemLabel.copyWith(
                fontSize: 8,
                color: AppColors.textTertiary,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
