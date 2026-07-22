import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/theme.dart';
import '../../../core/constants/legal_links.dart';

/// Hard paywall — premium conversion design adapted to PepMod cyberpunk.
///
/// Layout: hero, product proof, feature rows, pricing cards, fixed CTA.
class PaywallPage extends StatefulWidget {
  const PaywallPage({
    super.key,
    required this.onSubscribe,
    required this.onRestore,
    required this.onReviewerBypass,
    this.showSpecialOffer = true,
  });

  final Future<void> Function(int selectedPlan) onSubscribe;
  final VoidCallback onRestore;
  final Future<void> Function() onReviewerBypass;
  final bool showSpecialOffer;

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage>
    with SingleTickerProviderStateMixin {
  late int _selectedPlan; // 0=special annual, 1=annual, 2=weekly
  int _secretTapCount = 0;
  bool _isSubmitting = false;

  // Staggered entrance
  bool _showHero = false;
  bool _showPlans = false;
  bool _showCta = false;
  bool _showBenefits = false;

  // Countdown timer (15 min = 900s)
  int _countdownSeconds = 900;
  Timer? _countdownTimer;

  // Shimmer
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _selectedPlan = widget.showSpecialOffer ? 0 : 1;
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    // Staggered entrance animations
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _showHero = true);
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _showPlans = true);
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _showCta = true);
    });
    Future.delayed(const Duration(milliseconds: 1100), () {
      if (mounted) setState(() => _showBenefits = true);
    });

    // Countdown timer
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_countdownSeconds > 0) {
        setState(() => _countdownSeconds--);
      }
    });
  }

  @override
  void didUpdateWidget(covariant PaywallPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.showSpecialOffer && _selectedPlan == 0) {
      _selectedPlan = 1;
    } else if (widget.showSpecialOffer &&
        !oldWidget.showSpecialOffer &&
        _selectedPlan == 1) {
      _selectedPlan = 0;
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  String get _countdownFormatted {
    final m = (_countdownSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_countdownSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _submitSelectedPlan() async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);
    try {
      await widget.onSubscribe(_selectedPlan);
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Stack(
      children: [
        // Background radial glow
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.5),
                radius: 1.2,
                colors: [
                  AppColors.primary.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Scrollable content
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHero(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: _buildProductPreview(),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: _buildFeatureShowcases(),
              ),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: _buildValueNote(),
              ),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: _buildPricingCards(),
              ),
              const SizedBox(height: AppSpacing.xl),
              _buildFooter(),
              SizedBox(height: 90 + bottomPadding),
            ],
          ),
        ),

        // Fixed CTA at bottom
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildFixedCta(bottomPadding),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════
  // HERO
  // ═══════════════════════════════════════════════════════

  Widget _buildHero() {
    return AnimatedOpacity(
      opacity: _showHero ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + AppSpacing.xxl,
          left: AppSpacing.screenHorizontal,
          right: AppSpacing.screenHorizontal,
          bottom: AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with glow
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.biotech_rounded,
                size: 28,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            Text('SYS.ACCESS // PROTOCOL', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.sm),

            GestureDetector(
              onTap: () {
                _secretTapCount++;
                if (_secretTapCount >= 7) {
                  _secretTapCount = 0;
                  HapticFeedback.heavyImpact();
                  unawaited(widget.onReviewerBypass());
                }
              },
              child: Text(
                'Everything to run\nyour protocol right.',
                style: AppTypography.h1.copyWith(
                  fontSize: 30,
                  height: 1.1,
                  shadows: [
                    Shadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Dose math, site rotation, reminders, and protocol history - all in one record.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary.withValues(alpha: 0.65),
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPreview() {
    return AnimatedOpacity(
      opacity: _showPlans ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.borderCyan),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.12),
              blurRadius: 22,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  gradient: RadialGradient(
                    center: const Alignment(-0.9, -0.8),
                    radius: 1.3,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.13),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 18,
              top: 18,
              child: _MiniPhonePreview(
                title: 'Dose math',
                primary: '300 mcg',
                secondary: 'Units to draw',
                icon: Icons.calculate_rounded,
              ),
            ),
            const Positioned(
              left: 122,
              top: 4,
              child: _MiniPhonePreview(
                title: 'Site map',
                primary: 'Left abdomen',
                secondary: 'Last: 3 days ago',
                icon: Icons.location_on_outlined,
                featured: true,
              ),
            ),
            const Positioned(
              right: 18,
              top: 22,
              child: _MiniPhonePreview(
                title: 'Progress',
                primary: '87%',
                secondary: '30-day adherence',
                icon: Icons.query_stats_rounded,
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 14,
              child: Row(
                children: [
                  Icon(
                    Icons.verified_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Built for records, reminders, and unit clarity - not medical advice.',
                      style: AppTypography.disclaimer.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // PRICING CARDS
  // ═══════════════════════════════════════════════════════

  Widget _buildPricingCards() {
    return AnimatedOpacity(
      opacity: _showPlans ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: AnimatedSlide(
        offset: _showPlans ? Offset.zero : const Offset(0, 0.03),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        child: Column(
          children: [
            if (widget.showSpecialOffer) ...[
              _buildSpecialOfferCard(),
              const SizedBox(height: 10),
            ],
            _buildPlanCard(
              index: 1,
              label: 'Annual',
              tag: '3-DAY FREE TRIAL',
              price: '\$59.99',
              period: '/year',
              monthly: 'Just \$5.00/mo',
            ),
            const SizedBox(height: 10),
            _buildPlanCard(
              index: 2,
              label: 'Weekly',
              price: '\$9.99',
              period: '/week',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialOfferCard() {
    final isSelected = _selectedPlan == 0;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedPlan = 0);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.8)
                : AppColors.primary.withValues(alpha: 0.35),
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: Column(
          children: [
            // Shimmer header
            AnimatedBuilder(
              animation: _shimmerController,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(11), // card radius - border
                    ),
                    gradient: LinearGradient(
                      begin: Alignment(-1.0 + _shimmerController.value * 3, 0),
                      end: Alignment(
                        -1.0 + _shimmerController.value * 3 + 1,
                        0,
                      ),
                      colors: [
                        AppColors.primary.withValues(alpha: 0.1),
                        AppColors.primary.withValues(alpha: 0.25),
                        AppColors.primary.withValues(alpha: 0.1),
                      ],
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // 3 glowing dots
                      ...List.generate(
                        3,
                        (i) => Container(
                          width: 5,
                          height: 5,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(
                              alpha: 0.6 - (i * 0.15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'SPECIAL OFFER',
                        style: AppTypography.systemLabel.copyWith(
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                      const Spacer(),
                      // Save badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          'SAVE 50%',
                          style: AppTypography.systemLabel.copyWith(
                            fontSize: 8,
                            color: AppColors.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Reservation narrative tie-in
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_clock_rounded,
                    size: 11,
                    color: AppColors.primary.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'YOUR PERSONALISED PROTOCOL IS RESERVED FOR',
                      style: AppTypography.systemLabel.copyWith(
                        fontSize: 9,
                        letterSpacing: 1.4,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  // Countdown timer
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 10,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _countdownFormatted,
                          style: AppTypography.tabular.copyWith(
                            fontSize: 10,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  _buildCheckIndicator(isSelected),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Best Value',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.primary,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Just \$2.50/mo',
                          style: AppTypography.bodySmall.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Strikethrough original price
                      Text(
                        '\$59.99',
                        style: AppTypography.tabular.copyWith(
                          fontSize: 12,
                          color: AppColors.textDisabled,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.textDisabled,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '\$29.99',
                            style: AppTypography.heroSmall.copyWith(
                              fontSize: 20,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '/year',
                            style: AppTypography.disclaimer.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required int index,
    required String label,
    required String price,
    required String period,
    String? tag,
    String? monthly,
  }) {
    final isSelected = _selectedPlan == index;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedPlan = index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.6)
                : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 16,
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            // Trial banner
            if (tag != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(11),
                  ),
                  color: AppColors.primary.withValues(alpha: 0.08),
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.card_giftcard_rounded,
                      size: 12,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tag,
                      style: AppTypography.systemLabel.copyWith(
                        fontSize: 9,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  _buildCheckIndicator(isSelected),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label, style: AppTypography.labelLarge),
                        if (monthly != null)
                          Text(
                            monthly,
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        price,
                        style: AppTypography.heroSmall.copyWith(
                          fontSize: 18,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        period,
                        style: AppTypography.disclaimer.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckIndicator(bool isSelected) {
    return AnimatedContainer(
      duration: AppDurations.fast,
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.15)
            : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 2 : 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: isSelected
          ? const Icon(Icons.check_rounded, size: 14, color: AppColors.primary)
          : null,
    );
  }

  // ═══════════════════════════════════════════════════════
  // FEATURE SHOWCASES
  // ═══════════════════════════════════════════════════════

  Widget _buildFeatureShowcases() {
    return AnimatedOpacity(
      opacity: _showBenefits ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: Column(
        children: [
          _FeatureRow(
            icon: Icons.calculate_rounded,
            title: 'GET THE DOSE MATH RIGHT',
            description:
                'Keep vial, water, dose, and units-to-draw together so each log is easier to check.',
          ),
          const SizedBox(height: AppSpacing.md),
          _FeatureRow(
            icon: Icons.location_on_outlined,
            title: 'NEVER LOSE YOUR ROTATION',
            description:
                'Every site, cycle, and reminder stays attached to the protocol record.',
          ),
          const SizedBox(height: AppSpacing.md),
          _FeatureRow(
            icon: Icons.timeline_rounded,
            title: 'WATCH THE ARC OVER TIME',
            description:
                'See what was planned, what was logged, and what needs a cleaner record next.',
          ),
        ],
      ),
    );
  }

  Widget _buildValueNote() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.24)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: AppColors.secondary,
            size: AppSpacing.iconMedium,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'A confusing vial calculation can waste time and product. PepMod keeps the math beside the log so you can re-check your records before you act on old notes.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openLegalUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not open legal URL: $url');
    }
  }

  // ═══════════════════════════════════════════════════════
  // FOOTER
  // ═══════════════════════════════════════════════════════

  Widget _buildFooter() {
    return Column(
      children: [
        TextButton(
          onPressed: widget.onRestore,
          child: Text(
            'Restore Purchase',
            style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Text(
            'Subscription auto-renews unless cancelled at least 24 hours before the end of the current period. '
            'Manage in Settings > Apple ID > Subscriptions.',
            style: AppTypography.disclaimer,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => _openLegalUrl(LegalLinks.termsOfService),
              child: Text(
                'Terms',
                style: AppTypography.disclaimer.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            Text('·', style: AppTypography.disclaimer),
            TextButton(
              onPressed: () => _openLegalUrl(LegalLinks.privacyPolicy),
              child: Text(
                'Privacy',
                style: AppTypography.disclaimer.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════
  // FIXED CTA
  // ═══════════════════════════════════════════════════════

  Widget _buildFixedCta(double bottomPadding) {
    final label = switch (_selectedPlan) {
      0 => 'ACTIVATE PRO - \$29.99/year',
      1 => 'START FREE TRIAL',
      2 => 'SUBSCRIBE - \$9.99/week',
      _ => 'START FREE TRIAL',
    };

    return AnimatedOpacity(
      opacity: _showCta ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 400),
      child: AnimatedScale(
        scale: _showCta ? 1.0 : 0.95,
        duration: const Duration(milliseconds: 500),
        curve: Curves.elasticOut,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.background.withValues(alpha: 0.78),
                AppColors.background.withValues(alpha: 0.95),
                AppColors.background,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
          padding: EdgeInsets.only(
            left: AppSpacing.screenHorizontal,
            right: AppSpacing.screenHorizontal,
            top: AppSpacing.xl,
            bottom: bottomPadding + AppSpacing.md,
          ),
          child: GestureDetector(
            onTap: () {
              if (_isSubmitting) return;
              HapticFeedback.mediumImpact();
              unawaited(_submitSelectedPlan());
            },
            child: Container(
              height: AppSpacing.buttonHeight + 4,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                border: Border.all(color: AppColors.primary, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 15,
                  ),
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isSubmitting)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      )
                    else
                      Icon(
                        Icons.bolt_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      _isSubmitting ? 'CONNECTING TO STORE...' : label,
                      style: AppTypography.button.copyWith(
                        color: AppColors.textPrimary,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Product Proof Widgets ─────────────────────────────────────────────────

class _MiniPhonePreview extends StatelessWidget {
  const _MiniPhonePreview({
    required this.title,
    required this.primary,
    required this.secondary,
    required this.icon,
    this.featured = false,
  });

  final String title;
  final String primary;
  final String secondary;
  final IconData icon;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final width = featured ? 92.0 : 78.0;
    final height = featured ? 132.0 : 118.0;

    return Transform.rotate(
      angle: featured ? 0.02 : -0.035,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: featured
                ? AppColors.primary.withValues(alpha: 0.55)
                : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: featured ? 20 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(icon, size: 10, color: AppColors.primary),
                ),
                const Spacer(),
                Container(
                  width: 18,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: AppTypography.systemLabel.copyWith(
                fontSize: 7,
                color: AppColors.textTertiary,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              primary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.labelMedium.copyWith(
                fontSize: featured ? 13 : 11,
                color: featured ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            _TinyMetricBar(widthFactor: featured ? 0.82 : 0.62),
            const SizedBox(height: 4),
            _TinyMetricBar(widthFactor: featured ? 0.55 : 0.75),
            const SizedBox(height: AppSpacing.sm),
            Text(
              secondary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.disclaimer.copyWith(
                fontSize: 7,
                color: AppColors.textSecondary,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TinyMetricBar extends StatelessWidget {
  const _TinyMetricBar({required this.widthFactor});

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

// ── Feature Row Widget ────────────────────────────────────────────────────

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.systemLabel.copyWith(
                  fontSize: 10,
                  color: AppColors.primary,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary.withValues(alpha: 0.6),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
