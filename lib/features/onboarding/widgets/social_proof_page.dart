import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen 3: Social Proof — testimonials + stats.
/// Sophisticated, not cheesy. Biohackers, not bros.
class SocialProofPage extends StatelessWidget {
  const SocialProofPage({super.key, required this.onNext});

  final VoidCallback onNext;

  static const _testimonials = [
    _Testimonial(
      quote:
          'Finally stopped missing doses. The reconstitution calculator alone saved me hours of spreadsheet maths.',
      name: 'Marcus R.',
      protocol: 'BPC-157 protocol',
    ),
    _Testimonial(
      quote:
          'The weekly insights caught a timing issue I didn\'t notice for months. Game-changer.',
      name: 'Sarah K.',
      protocol: 'GHK-Cu + TB-500',
    ),
    _Testimonial(
      quote:
          'Cleanest peptide tracker I\'ve used. Looks like it was built for serious users, because it was.',
      name: 'James L.',
      protocol: 'stack of 4',
    ),
  ];

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

            Text('SYS.COMMUNITY // TRUSTED',
                style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Trusted by\nbiohackers worldwide',
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Join thousands tracking real progress.',
              style: AppTypography.bodyMedium,
            ),

            const SizedBox(height: AppSpacing.xl),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final t in _testimonials) ...[
                      _TestimonialCard(testimonial: t),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    const SizedBox(height: AppSpacing.sm),

                    // Stats row
                    Row(
                      children: const [
                        _StatTile(value: '10K+', label: 'USERS'),
                        SizedBox(width: AppSpacing.md),
                        _StatTile(value: '47K+', label: 'DOSES LOGGED'),
                        SizedBox(width: AppSpacing.md),
                        _StatTile(value: '4.8', label: 'AVG RATING'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.base),

            PrimaryButton(
              label: 'CONTINUE',
              onPressed: onNext,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _Testimonial {
  const _Testimonial({
    required this.quote,
    required this.name,
    required this.protocol,
  });
  final String quote;
  final String name;
  final String protocol;
}

class _TestimonialCard extends StatelessWidget {
  const _TestimonialCard({required this.testimonial});
  final _Testimonial testimonial;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: AppColors.border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Star row
          Row(
            children: List.generate(
              5,
              (i) => Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          Text(
            testimonial.quote,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              height: 1.55,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Name + protocol
          Text(
            testimonial.name,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            testimonial.protocol,
            style: AppTypography.systemLabel.copyWith(
              fontSize: 10,
              color: AppColors.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});
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
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.25),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.heroSmall.copyWith(
                fontSize: 20,
                color: AppColors.primary,
                shadows: [
                  Shadow(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.systemLabel.copyWith(
                fontSize: 9,
                color: AppColors.textTertiary,
                letterSpacing: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
