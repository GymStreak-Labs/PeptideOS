import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/theme.dart';
import '../services/onboarding_draft_service.dart';
import '../widgets/age_gate_page.dart';
import '../widgets/hook_page.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/birth_date_page.dart';
import '../widgets/first_name_page.dart';
import '../widgets/goals_page.dart';
import '../widgets/experience_page.dart';
import '../widgets/frustration_page.dart';
import '../widgets/peptide_select_page.dart';
import '../widgets/calculator_demo_page.dart';
import '../widgets/review_gate_page.dart';
import '../widgets/processing_page.dart';
import '../widgets/protocol_preview_page.dart';
import '../widgets/results_summary_page.dart';
import '../widgets/feature_showcase_page.dart';

/// Full 18-screen onboarding flow — conversion-optimised v3.
///
/// Phase 1 — Emotional Mirror:   Age Gate → Hook → Disclaimer
/// Phase 2 — Personalisation:    Name → Birth Date → Goals → Experience → Frustration → Peptides
/// Phase 3 — Aha Moment:         Calculator Demo
/// Phase 4 — Reveal:             Processing → Protocol Preview → Results Summary
/// Phase 5 — Value & Handoff:    Feature Showcase → Value Screens → Review → Auth → Paywall
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
  static const _totalPages = 18;

  // Collected data
  String _firstName = '';
  String _birthDate = '';
  final Set<String> _selectedGoals = {};
  String _experienceLevel = '';
  String _frustration = '';
  final Set<String> _selectedPeptides = {};

  void _nextPage() {
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
    _pageController.previousPage(
      duration: AppDurations.pageTransition,
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  Future<void> _handoffToAuth() async {
    // Persist onboarding data locally, then route to Firebase auth. Once auth
    // succeeds, AppRoot replays the draft into Firestore and shows paywall.
    try {
      final draft = OnboardingDraft(
        firstName: _firstName,
        birthDate: _birthDate,
        goals: _selectedGoals.toList(),
        experience: _experienceLevel,
        frustration: _frustration,
        selectedPeptides: _selectedPeptides.toList(),
      );
      await OnboardingDraftService.save(draft);
      await OnboardingDraftService.setPostAuthPaywallPending(true);
      widget.onReadyForAuth?.call();
    } catch (e) {
      debugPrint('onboarding auth handoff failed: $e');
    }
  }

  String get _firstPeptide =>
      _selectedPeptides.isNotEmpty ? _selectedPeptides.first : 'BPC-157';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                title: 'Important\nDisclaimer',
                body:
                    'PepMod is a tracking and educational tool only. It does not provide medical advice, diagnosis, or treatment.\n\nAlways consult a qualified healthcare provider before starting any peptide regimen.\n\nBy continuing, you acknowledge this is not a medical device.',
                icon: Icons.shield_rounded,
                iconColor: AppColors.warning,
                buttonLabel: 'I UNDERSTAND',
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

              // 6: Experience Level
              ExperiencePage(
                selected: _experienceLevel,
                onSelect: (level) {
                  setState(() => _experienceLevel = level);
                },
                onNext: _nextPage,
              ),

              // 7: Biggest Frustration
              FrustrationPage(
                selected: _frustration,
                onSelect: (f) => setState(() => _frustration = f),
                onNext: _nextPage,
              ),

              // 8: Current/Planned Peptides
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

              // 9: Unit Converter Demo
              CalculatorDemoPage(peptideName: _firstPeptide, onNext: _nextPage),

              // ── Phase 4: Reveal ───────────────────────────────────

              // 10: Building Your Protocol (processing)
              ProcessingPage(
                onNext: _nextPage,
                selectedPeptides: _selectedPeptides,
                selectedGoals: _selectedGoals,
              ),

              // 11: Protocol Preview
              ProtocolPreviewPage(
                peptides: _selectedPeptides,
                onNext: _nextPage,
              ),

              // 12: Personalised Results Summary
              ResultsSummaryPage(
                selectedGoals: _selectedGoals,
                experienceLevel: _experienceLevel,
                frustration: _frustration,
                selectedPeptides: _selectedPeptides,
                onNext: _nextPage,
              ),

              // ── Phase 5: Value & Handoff ─────────────────────────

              // 13: Feature Showcase
              FeatureShowcasePage(onNext: _nextPage),

              // 14: Value screen — protocol organization
              OnboardingPage(
                systemLabel: 'SYS.VALUE // PROTOCOL',
                title: 'Everything stays\nin one protocol.',
                body:
                    'Track what you planned, what you actually logged, and what is coming next — without digging through notes, screenshots, or group chats.',
                icon: Icons.view_timeline_rounded,
                iconColor: AppColors.primary,
                buttonLabel: 'CONTINUE',
                onNext: _nextPage,
              ),

              // 15: Value screen — unit conversion
              OnboardingPage(
                systemLabel: 'SYS.VALUE // CONVERT',
                title: 'Unit conversion\nwithout second guessing.',
                body:
                    'Use the built-in converter to translate vial, water, and dose inputs into clear syringe units for your own records.',
                icon: Icons.straighten_rounded,
                iconColor: AppColors.secondary,
                buttonLabel: 'CONTINUE',
                onNext: _nextPage,
              ),

              // 16: Value screen — trend tracking
              OnboardingPage(
                systemLabel: 'SYS.VALUE // SIGNAL',
                title: 'See your tracking\ndata over time.',
                body:
                    'Adherence, logs, metrics, and vial history build a cleaner picture of your routine — no promises, just better records.',
                icon: Icons.query_stats_rounded,
                iconColor: AppColors.aiInsightBright,
                buttonLabel: 'CONTINUE',
                onNext: _nextPage,
              ),

              // 17: Review request at the end → Auth handoff. Paywall is
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
              child: _BackButton(onPressed: _previousPage),
            ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.24)),
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
