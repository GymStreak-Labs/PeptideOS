import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Hard paywall — displayed after onboarding.
/// Three-tier pricing with annual anchor.
class PaywallPage extends StatefulWidget {
  const PaywallPage({
    super.key,
    required this.onSubscribe,
    required this.onRestore,
  });

  final VoidCallback onSubscribe;
  final VoidCallback onRestore;

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  int _selectedPlan = 1; // 0=weekly, 1=annual (default), 2=lifetime

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xxl),

            // ── Header ───────────────────────────────────────────────
            Text('SYS.ACCESS // UPGRADE', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),

            Text(
              'Unlock\nPeptideOS',
              style: AppTypography.h1.copyWith(fontSize: 32),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Feature list ─────────────────────────────────────────
            ...[
              'AI-powered protocol insights',
              'Reconstitution calculator',
              'Vial tracking & expiry alerts',
              'Injection site rotation map',
              'Weekly progress reports',
              'Unlimited peptide profiles',
            ].map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(feature, style: AppTypography.bodyMedium),
                    ],
                  ),
                )),

            const SizedBox(height: AppSpacing.xl),

            // ── Pricing tiers ────────────────────────────────────────
            _PriceTier(
              index: 0,
              label: 'WEEKLY',
              price: '\$9.99',
              period: '/week',
              isSelected: _selectedPlan == 0,
              onTap: () => setState(() => _selectedPlan = 0),
            ),
            const SizedBox(height: AppSpacing.cardGap),

            _PriceTier(
              index: 1,
              label: 'ANNUAL',
              price: '\$59.99',
              period: '/year',
              savings: 'Save 88%',
              badge: 'BEST VALUE',
              isSelected: _selectedPlan == 1,
              onTap: () => setState(() => _selectedPlan = 1),
            ),
            const SizedBox(height: AppSpacing.cardGap),

            _PriceTier(
              index: 2,
              label: 'LIFETIME',
              price: '\$149.99',
              period: 'one-time',
              isSelected: _selectedPlan == 2,
              onTap: () => setState(() => _selectedPlan = 2),
            ),

            const SizedBox(height: AppSpacing.xl),

            // ── Subscribe button ─────────────────────────────────────
            PrimaryButton(
              label: _selectedPlan == 2 ? 'PURCHASE' : 'SUBSCRIBE',
              onPressed: widget.onSubscribe,
            ),

            const SizedBox(height: AppSpacing.md),

            // ── Restore + Terms ──────────────────────────────────────
            TextButton(
              onPressed: widget.onRestore,
              child: Text(
                'Restore Purchase',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              'Subscription auto-renews unless cancelled at least 24 hours before the end of the current period. '
              'Manage in Settings > Apple ID > Subscriptions.',
              style: AppTypography.disclaimer,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.base),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: open terms
                  },
                  child: Text(
                    'Terms',
                    style: AppTypography.disclaimer.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
                Text('·', style: AppTypography.disclaimer),
                TextButton(
                  onPressed: () {
                    // TODO: open privacy
                  },
                  child: Text(
                    'Privacy',
                    style: AppTypography.disclaimer.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _PriceTier extends StatelessWidget {
  const _PriceTier({
    required this.index,
    required this.label,
    required this.price,
    required this.period,
    required this.isSelected,
    required this.onTap,
    this.savings,
    this.badge,
  });

  final int index;
  final String label;
  final String price;
  final String period;
  final bool isSelected;
  final VoidCallback onTap;
  final String? savings;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    blurRadius: 16,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Radio indicator
            AnimatedContainer(
              duration: AppDurations.fast,
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 6,
                        ),
                      ]
                    : null,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.circle, size: 8, color: AppColors.primary),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.md),

            // Plan label
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: AppTypography.systemLabel.copyWith(
                          color: isSelected ? AppColors.primary : AppColors.textTertiary,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.secondary.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            badge!,
                            style: AppTypography.systemLabel.copyWith(
                              fontSize: 8,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (savings != null)
                    Text(
                      savings!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.success,
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ),

            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: AppTypography.heroSmall.copyWith(
                    fontSize: 20,
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
                Text(
                  period,
                  style: AppTypography.disclaimer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
