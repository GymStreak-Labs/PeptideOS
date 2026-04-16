import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen 10: Feature Showcase — 3 horizontal swipeable cards.
class FeatureShowcasePage extends StatefulWidget {
  const FeatureShowcasePage({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<FeatureShowcasePage> createState() => _FeatureShowcasePageState();
}

class _FeatureShowcasePageState extends State<FeatureShowcasePage> {
  final _controller = PageController(viewportFraction: 0.85);
  int _currentCard = 0;

  static const _features = [
    _Feature(
      'AI.INSIGHT',
      'Accumulating\nIntelligence',
      'The longer you use PeptideOS, the smarter it gets. Your AI mentor correlates protocol changes with outcomes — surfacing patterns you\'d never spot yourself.',
      Icons.auto_awesome_rounded,
      AppColors.aiInsightBright,
    ),
    _Feature(
      'SYS.BODYMAP',
      'Injection Site\nRotation',
      'Interactive body map tracks every injection site. Colour-coded healing status and smart rotation suggestions prevent tissue damage.',
      Icons.accessibility_new_rounded,
      AppColors.primary,
    ),
    _Feature(
      'SYS.INVENTORY',
      'Vial Tracking\n& Expiry Alerts',
      'Track doses remaining per vial. Get alerts before reconstituted peptides expire. Know your cost-per-dose and when to reorder.',
      Icons.inventory_2_rounded,
      AppColors.secondary,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.huge),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SYS.FEATURES // SHOWCASE',
                    style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Built for\npeptide users.',
                  style: AppTypography.h1.copyWith(fontSize: 28),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Swipeable cards
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _features.length,
              onPageChanged: (i) => setState(() => _currentCard = i),
              itemBuilder: (context, index) {
                final feature = _features[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  child: AppCard(
                    borderColor: feature.color.withValues(alpha: 0.3),
                    glowColor: feature.color.withValues(alpha: 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: feature.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: feature.color.withValues(alpha: 0.15),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: Icon(
                            feature.icon,
                            size: 26,
                            color: feature.color,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.lg),

                        Text(
                          feature.tag,
                          style: AppTypography.systemLabel.copyWith(
                            color: feature.color,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),

                        Text(
                          feature.title,
                          style: AppTypography.h1.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: AppSpacing.md),

                        Text(
                          feature.description,
                          style: AppTypography.bodyMedium.copyWith(
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Page indicator dots
          const SizedBox(height: AppSpacing.base),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_features.length, (i) {
              final isActive = i == _currentCard;
              return AnimatedContainer(
                duration: AppDurations.fast,
                width: isActive ? 20 : 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: isActive ? AppColors.primary : AppColors.border,
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.5),
                            blurRadius: 6,
                          ),
                        ]
                      : null,
                ),
              );
            }),
          ),

          const SizedBox(height: AppSpacing.xl),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: PrimaryButton(
              label: 'CONTINUE',
              onPressed: widget.onNext,
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _Feature {
  const _Feature(this.tag, this.title, this.description, this.icon, this.color);
  final String tag;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
}
