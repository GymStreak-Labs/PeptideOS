import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/theme.dart';
import '../../../core/constants/legal_links.dart';
import '../../../l10n/app_localizations.dart';
import '../../subscription/paywall_offer_state.dart';

@immutable
class PaywallPlanPrice {
  const PaywallPlanPrice({
    required this.localizedPrice,
    required this.amount,
    required this.currencyCode,
    this.trialOffer,
  });

  final String localizedPrice;
  final double amount;
  final String currencyCode;

  /// Store-derived free trial the current user is eligible for, or null when
  /// no trial may be advertised (no offer, ineligible user, or unknown
  /// eligibility). Trial copy on the paywall renders only from this value —
  /// never from hardcoded durations.
  final StoreTrialOffer? trialOffer;
}

/// Hard paywall — premium conversion design adapted to PepMod cyberpunk.
///
/// Layout: hero, product proof, feature rows, pricing cards, fixed CTA.
class PaywallPage extends StatefulWidget {
  const PaywallPage({
    super.key,
    required this.onSubscribe,
    required this.onRestore,
    this.planPrices = const {},
    this.showSpecialOffer = true,
  });

  final Future<void> Function(int selectedPlan) onSubscribe;
  final VoidCallback onRestore;
  final Map<int, PaywallPlanPrice> planPrices;
  final bool showSpecialOffer;

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage>
    with SingleTickerProviderStateMixin {
  late int _selectedPlan; // 0=special annual, 1=annual, 2=weekly
  bool _isSubmitting = false;

  // Staggered entrance
  bool _showHero = false;
  bool _showPlans = false;
  bool _showCta = false;
  bool _showBenefits = false;

  // Countdown timer (15 min = 900s)
  int _countdownSeconds = 900;
  Timer? _countdownTimer;
  AppLocalizations get _l10n => AppLocalizations.of(context);

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

  PaywallPlanPrice? _priceForPlan(int planIndex) =>
      widget.planPrices[planIndex];

  String _localizedPriceForPlan(int planIndex) =>
      _priceForPlan(planIndex)?.localizedPrice ?? '—';

  StoreTrialOffer? get _annualTrialOffer => _priceForPlan(1)?.trialOffer;

  int? get _specialOfferSavingsPercent {
    final special = _priceForPlan(0);
    final annual = _priceForPlan(1);
    if (special == null ||
        annual == null ||
        special.currencyCode != annual.currencyCode ||
        annual.amount <= 0 ||
        special.amount >= annual.amount) {
      return null;
    }
    return ((1 - (special.amount / annual.amount)) * 100).round();
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

            Text(
              _l10n.paywallTitle,
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
            const SizedBox(height: AppSpacing.sm),
            Text(
              _l10n.paywallBody,
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
            Positioned(
              left: 18,
              top: 18,
              child: _MiniPhonePreview(
                title: _l10n.confidenceDoseMath,
                primary: '300 mcg',
                secondary: _l10n.unitsToDraw,
                icon: Icons.calculate_rounded,
              ),
            ),
            Positioned(
              left: 122,
              top: 4,
              child: _MiniPhonePreview(
                title: _l10n.siteMap,
                primary: _l10n.leftAbdomen,
                secondary: _l10n.lastThreeDaysAgo,
                icon: Icons.location_on_outlined,
                featured: true,
              ),
            ),
            Positioned(
              right: 18,
              top: 22,
              child: _MiniPhonePreview(
                title: _l10n.progressLabel,
                primary: '87%',
                secondary: _l10n.thirtyDayAdherence,
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
                      _l10n.paywallPreviewDisclaimer,
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
              label: _l10n.annualLabel,
              // Trial badge is rendered only when the store offer includes a
              // free trial the current user is eligible for — never as a
              // hardcoded promise.
              tag: switch (_annualTrialOffer) {
                final offer? => freeTrialBadgeLabel(_l10n, offer),
                null => null,
              },
              price: _localizedPriceForPlan(1),
              period: _l10n.perYear,
            ),
            const SizedBox(height: 10),
            _buildPlanCard(
              index: 2,
              label: _l10n.weeklyLabel,
              price: _localizedPriceForPlan(2),
              period: _l10n.perWeek,
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
                        _l10n.specialOffer,
                        style: AppTypography.systemLabel.copyWith(
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                      const Spacer(),
                      // Save badge
                      if (_specialOfferSavingsPercent case final savings?)
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
                            _l10n.savePercent(savings),
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
                      _l10n.protocolReservedFor,
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
                          _l10n.bestValue,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.primary,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _l10n.annualAccess,
                          style: AppTypography.bodySmall.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (_specialOfferSavingsPercent != null)
                        Text(
                          _localizedPriceForPlan(1),
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
                            _localizedPriceForPlan(0),
                            style: AppTypography.heroSmall.copyWith(
                              fontSize: 20,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            _l10n.perYear,
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
            title: _l10n.paywallDoseMathTitle,
            description: _l10n.paywallDoseMathBody,
          ),
          const SizedBox(height: AppSpacing.md),
          _FeatureRow(
            icon: Icons.location_on_outlined,
            title: _l10n.paywallRotationTitle,
            description: _l10n.paywallRotationBody,
          ),
          const SizedBox(height: AppSpacing.md),
          _FeatureRow(
            icon: Icons.timeline_rounded,
            title: _l10n.paywallArcTitle,
            description: _l10n.paywallArcBody,
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
              _l10n.paywallValueNote,
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
            _l10n.restorePurchase,
            style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Text(
            _l10n.subscriptionRenewalDisclaimer,
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
                _l10n.termsLabel,
                style: AppTypography.disclaimer.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            Text('·', style: AppTypography.disclaimer),
            TextButton(
              onPressed: () => _openLegalUrl(LegalLinks.privacyPolicy),
              child: Text(
                _l10n.privacyLabel,
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
    final selectedPrice = _priceForPlan(_selectedPlan)?.localizedPrice;
    final hasAnnualTrial = _annualTrialOffer != null;
    final label = switch (_selectedPlan) {
      0 when selectedPrice != null => _l10n.activateProPrice(selectedPrice),
      0 => _l10n.activatePro,
      // "Start free trial" is only promised when the store-derived annual
      // offer includes one the current user is eligible for; otherwise fall
      // back to plain subscribe.
      1 when hasAnnualTrial => _l10n.startFreeTrial,
      1 when selectedPrice != null => _l10n.subscribeAnnualPrice(selectedPrice),
      1 => _l10n.subscribeLabel,
      2 when selectedPrice != null => _l10n.subscribePrice(selectedPrice),
      _ => _l10n.subscribeLabel,
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
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _isSubmitting ? _l10n.connectingToStore : label,
                          maxLines: 1,
                          style: AppTypography.button.copyWith(
                            color: AppColors.textPrimary,
                            letterSpacing: 0.8,
                          ),
                        ),
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
    final height = featured ? 132.0 : 128.0;

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
