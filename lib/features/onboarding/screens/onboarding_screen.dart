import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/services/analytics_service.dart';
import '../../../core/theme/theme.dart';
import '../../../services/notification_service.dart';
import '../../../l10n/app_localizations.dart';
import '../services/onboarding_draft_service.dart';
import '../widgets/age_gate_page.dart';
import '../widgets/hook_page.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/birth_date_page.dart';
import '../widgets/first_name_page.dart';
import '../widgets/goals_page.dart';
import '../widgets/experience_page.dart';
import '../widgets/frustration_page.dart';
import '../widgets/confidence_page.dart';
import '../widgets/peptide_select_page.dart';
import '../widgets/calculator_demo_page.dart';
import '../widgets/notification_page.dart';
import '../widgets/review_gate_page.dart';
import '../widgets/processing_page.dart';
import '../widgets/protocol_preview_page.dart';
import '../widgets/protocol_roadmap_page.dart';
import '../widgets/results_summary_page.dart';
import '../widgets/feature_showcase_page.dart';

/// Full onboarding flow — conversion-optimised v5.
///
/// Phase 1 — Emotional Mirror:   Age Gate → Hook → Disclaimer
/// Phase 2 — Personalisation:    Name → Birth Date → Goals → Experience → Frustration → Confidence → Peptides
/// Phase 3 — Aha Moment:         Calculator Demo
/// Phase 4 — Reveal:             Processing → Protocol Preview → Results Summary → 60-day roadmap
/// Phase 5 — Value & Handoff:    Feature Showcase → Notifications → Value Screens → Review → Auth → Paywall
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.onReadyForAuth});

  /// Called after onboarding data is staged locally and the next step should
  /// be Firebase auth. The paywall is intentionally post-auth for attribution.
  final VoidCallback? onReadyForAuth;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  static const _totalPages = 23;
  static const _stepNames = <String>[
    'age_gate',
    'hook',
    'disclaimer',
    'first_name',
    'birth_date',
    'goals',
    'goals_reassurance',
    'experience',
    'frustration',
    'confidence',
    'confidence_reassurance',
    'peptide_select',
    'calculator_demo',
    'processing',
    'protocol_preview',
    'results_summary',
    'first_60_days',
    'feature_showcase',
    'notification_prompt',
    'value_protocol',
    'value_conversion',
    'value_progress',
    'review_gate',
  ];

  // Collected data
  String _firstName = '';
  String _birthDate = '';
  final Set<String> _selectedGoals = {};
  String _experienceLevel = '';
  String _frustration = '';
  final Set<String> _selectedConfidenceNeeds = {};
  final Set<String> _selectedPeptides = {};
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    unawaited(AnalyticsService().logOnboardingStarted());
    _logScreenViewed(0);
  }

  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }

  void _nextPage() {
    _dismissKeyboard();
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: AppDurations.pageTransition,
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage <= 0) return;
    HapticFeedback.selectionClick();
    _dismissKeyboard();
    _pageController.previousPage(
      duration: AppDurations.pageTransition,
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int page) {
    _dismissKeyboard();
    setState(() => _currentPage = page);
    _logScreenViewed(page);
  }

  Future<void> _handoffToAuth() async {
    _dismissKeyboard();
    // Persist onboarding data locally, then route to Firebase auth. Once auth
    // succeeds, AppRoot replays the draft into Firestore and shows paywall.
    try {
      final draft = OnboardingDraft(
        firstName: _firstName,
        birthDate: _birthDate,
        goals: _selectedGoals.toList(),
        confidenceNeeds: _selectedConfidenceNeeds.toList(),
        experience: _experienceLevel,
        frustration: _frustration,
        selectedPeptides: _selectedPeptides.toList(),
        notificationsEnabled: _notificationsEnabled,
      );
      await OnboardingDraftService.save(draft);
      await OnboardingDraftService.setPostAuthPaywallPending(true);
      unawaited(
        AnalyticsService().logOnboardingCompleted(
          stepTotal: _totalPages,
          goalCount: _selectedGoals.length,
          peptideCount: _selectedPeptides.length,
          hasFirstName: _firstName.trim().isNotEmpty,
          hasBirthDate: _birthDate.trim().isNotEmpty,
          hasExperience: _experienceLevel.trim().isNotEmpty,
          hasFrustration: _frustration.trim().isNotEmpty,
        ),
      );
      widget.onReadyForAuth?.call();
    } catch (e) {
      debugPrint('onboarding auth handoff failed: $e');
    }
  }

  String get _firstPeptide =>
      _selectedPeptides.isNotEmpty ? _selectedPeptides.first : 'BPC-157';

  Future<bool> _requestNotifications() async {
    final granted = await NotificationService.instance.requestPermission();
    if (mounted) {
      setState(() => _notificationsEnabled = granted);
    }
    return granted;
  }

  void _logScreenViewed(int page) {
    if (page < 0 || page >= _stepNames.length) return;
    unawaited(
      AnalyticsService().logOnboardingScreenViewed(
        stepIndex: page,
        stepPosition: page + 1,
        stepTotal: _totalPages,
        stepName: _stepNames[page],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Pages ──────────────────────────────────────────────────
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: _onPageChanged,
            children: [
              // ── Phase 1: Emotional Mirror ──────────────────────────

              // 0: Age Gate
              AgeGatePage(onConfirmed: _nextPage),

              // 1: The Hook
              HookPage(onNext: _nextPage),

              // 2: Medical Disclaimer (early — before personalisation)
              OnboardingPage(
                systemLabel: 'SYS.LEGAL // DISCLAIMER',
                title: l10n.onboardingDisclaimerTitle,
                body: l10n.onboardingDisclaimerBody,
                icon: Icons.shield_rounded,
                iconColor: AppColors.warning,
                buttonLabel: l10n.iUnderstand,
                onNext: _nextPage,
              ),

              // ── Phase 2: Personalisation (sunk cost) ──────────────

              // 3: First name
              FirstNamePage(
                firstName: _firstName,
                onChanged: (value) {
                  setState(() => _firstName = value);
                },
                onNext: _nextPage,
              ),

              // 4: Birth date
              BirthDatePage(
                birthDate: _birthDate,
                onChanged: (value) {
                  setState(() => _birthDate = value);
                },
                onNext: _nextPage,
              ),

              // 5: Goals
              GoalsPage(
                selectedGoals: _selectedGoals,
                onToggle: (goal) {
                  setState(() {
                    if (_selectedGoals.contains(goal)) {
                      _selectedGoals.remove(goal);
                    } else {
                      _selectedGoals.add(goal);
                    }
                  });
                },
                onNext: _nextPage,
              ),

              // 6: Reassurance after goals
              OnboardingPage(
                systemLabel: 'SYS.GUIDE // CALIBRATED',
                title: l10n.onboardingAheadTitle,
                body: l10n.onboardingAheadBody,
                icon: Icons.route_rounded,
                iconColor: AppColors.primary,
                buttonLabel: l10n.continueLabel,
                onNext: _nextPage,
              ),

              // 7: Experience Level
              ExperiencePage(
                selected: _experienceLevel,
                onSelect: (level) {
                  setState(() => _experienceLevel = level);
                },
                onNext: _nextPage,
              ),

              // 8: Biggest Frustration
              FrustrationPage(
                selected: _frustration,
                onSelect: (f) => setState(() => _frustration = f),
                onNext: _nextPage,
              ),

              // 9: Confidence Signals
              ConfidencePage(
                selectedNeeds: _selectedConfidenceNeeds,
                onToggle: (need) {
                  setState(() {
                    if (_selectedConfidenceNeeds.contains(need)) {
                      _selectedConfidenceNeeds.remove(need);
                    } else {
                      _selectedConfidenceNeeds.add(need);
                    }
                  });
                },
                onNext: _nextPage,
              ),

              // 10: Reassurance after confidence signals
              OnboardingPage(
                systemLabel: 'SYS.CLARITY // READY',
                title: l10n.onboardingGuidedStartTitle,
                body: l10n.onboardingGuidedStartBody,
                icon: Icons.verified_user_outlined,
                iconColor: AppColors.secondary,
                buttonLabel: l10n.continueLabel,
                onNext: _nextPage,
              ),

              // 11: Current/Planned Peptides
              PeptideSelectPage(
                selectedPeptides: _selectedPeptides,
                onToggle: (p) {
                  setState(() {
                    if (_selectedPeptides.contains(p)) {
                      _selectedPeptides.remove(p);
                    } else {
                      _selectedPeptides.add(p);
                    }
                  });
                },
                onNext: _nextPage,
              ),

              // ── Phase 3: Aha Moment ───────────────────────────────

              // 12: Unit Converter Demo
              CalculatorDemoPage(peptideName: _firstPeptide, onNext: _nextPage),

              // ── Phase 4: Reveal ───────────────────────────────────

              // 13: Building Your Protocol (processing)
              ProcessingPage(
                onNext: _nextPage,
                selectedPeptides: _selectedPeptides,
                selectedGoals: _selectedGoals,
              ),

              // 14: Protocol Preview
              ProtocolPreviewPage(
                peptides: _selectedPeptides,
                onNext: _nextPage,
              ),

              // 15: Personalised Results Summary
              ResultsSummaryPage(
                selectedGoals: _selectedGoals,
                confidenceNeeds: _selectedConfidenceNeeds,
                experienceLevel: _experienceLevel,
                frustration: _frustration,
                selectedPeptides: _selectedPeptides,
                onNext: _nextPage,
              ),

              // 16: 60-day Roadmap
              ProtocolRoadmapPage(
                selectedGoals: _selectedGoals,
                confidenceNeeds: _selectedConfidenceNeeds,
                selectedPeptides: _selectedPeptides,
                onNext: _nextPage,
              ),

              // ── Phase 5: Value & Handoff ─────────────────────────

              // 17: Feature Showcase
              FeatureShowcasePage(onNext: _nextPage),

              // 18: Notification permission warm-up
              NotificationPage(
                onEnable: _requestNotifications,
                onNext: _nextPage,
              ),

              // 19: Value screen — protocol organization
              OnboardingPage(
                systemLabel: 'SYS.VALUE // PROTOCOL',
                title: l10n.onboardingProtocolValueTitle,
                body: l10n.onboardingProtocolValueBody,
                icon: Icons.view_timeline_rounded,
                iconColor: AppColors.primary,
                buttonLabel: l10n.continueLabel,
                onNext: _nextPage,
              ),

              // 20: Value screen — unit conversion
              OnboardingPage(
                systemLabel: 'SYS.VALUE // CONVERT',
                title: l10n.onboardingConversionValueTitle,
                body: l10n.onboardingConversionValueBody,
                icon: Icons.straighten_rounded,
                iconColor: AppColors.secondary,
                buttonLabel: l10n.continueLabel,
                onNext: _nextPage,
              ),

              // 21: Value screen — trend tracking
              OnboardingPage(
                systemLabel: 'SYS.VALUE // SIGNAL',
                title: l10n.onboardingProgressValueTitle,
                body: l10n.onboardingProgressValueBody,
                icon: Icons.query_stats_rounded,
                iconColor: AppColors.aiInsightBright,
                buttonLabel: l10n.continueLabel,
                onNext: _nextPage,
              ),

              // 22: Review request at the end → Auth handoff. Paywall is
              // post-auth so RevenueCat/AppRefer attach events to Firebase UID.
              ReviewGatePage(onNext: _handoffToAuth),
            ],
          ),

          // ── Progress bar (hidden on age gate & final auth handoff)
          if (_currentPage > 0 && _currentPage < _totalPages - 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + AppSpacing.sm,
              left: AppSpacing.screenHorizontal + 52,
              right: AppSpacing.screenHorizontal,
              child: _ProgressBar(
                current: _currentPage,
                total: _totalPages - 1,
              ),
            ),

          // ── Back button (hidden only on first page)
          if (_currentPage > 0)
            Positioned(
              top: MediaQuery.of(context).padding.top + AppSpacing.sm - 19,
              left: AppSpacing.screenHorizontal,
              child: _BackButton(label: l10n.back, onPressed: _previousPage),
            ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.24),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.12),
                blurRadius: 14,
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
            size: AppSpacing.iconMedium,
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final isActive = index < current;
        final isCurrent = index == current;

        return Expanded(
          child: Container(
            height: 2,
            margin: EdgeInsets.only(right: index < total - 1 ? 3 : 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: isActive || isCurrent
                  ? AppColors.primary
                  : AppColors.border,
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.5),
                        blurRadius: 4,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
