import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../services/onboarding_draft_service.dart';
import '../widgets/age_gate_page.dart';
import '../widgets/hook_page.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/birth_date_page.dart';
import '../widgets/first_name_page.dart';
import '../widgets/social_proof_page.dart';
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

/// Full 16-screen onboarding flow — conversion-optimised v2.
///
/// Phase 1 — Emotional Mirror:   Age Gate → Hook → Social Proof → Disclaimer
/// Phase 2 — Personalisation:    Name → Birth Date → Goals → Experience → Frustration → Peptides
/// Phase 3 — Aha Moment:         Calculator Demo → Review Gate
/// Phase 4 — Reveal:             Processing → Protocol Preview → Results Summary
/// Phase 5 — Features & Handoff: Feature Showcase → Auth → Paywall
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
  static const _totalPages = 16;

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

              // 2: Social Proof
              SocialProofPage(onNext: _nextPage),

              // 3: Medical Disclaimer (early — before personalisation)
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

              // 4: First name
              FirstNamePage(
                firstName: _firstName,
                onChanged: (value) {
                  setState(() => _firstName = value);
                },
                onNext: _nextPage,
              ),

              // 5: Birth date
              BirthDatePage(
                birthDate: _birthDate,
                onChanged: (value) {
                  setState(() => _birthDate = value);
                },
                onNext: _nextPage,
              ),

              // 6: Goals
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

              // 9: Current/Planned Peptides
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

              // 10: Unit Converter Demo
              CalculatorDemoPage(peptideName: _firstPeptide, onNext: _nextPage),

              // 11: Review Request Gate
              ReviewGatePage(onNext: _nextPage),

              // ── Phase 4: Reveal ───────────────────────────────────

              // 12: Building Your Protocol (processing)
              ProcessingPage(
                onNext: _nextPage,
                selectedPeptides: _selectedPeptides,
                selectedGoals: _selectedGoals,
              ),

              // 13: Protocol Preview
              ProtocolPreviewPage(
                peptides: _selectedPeptides,
                onNext: _nextPage,
              ),

              // 14: Personalised Results Summary
              ResultsSummaryPage(
                selectedGoals: _selectedGoals,
                experienceLevel: _experienceLevel,
                frustration: _frustration,
                selectedPeptides: _selectedPeptides,
                onNext: _nextPage,
              ),

              // ── Phase 5: Features & Convert ───────────────────────

              // 15: Feature Showcase → Auth handoff. Paywall is post-auth so
              // RevenueCat/AppRefer can attach purchase events to Firebase UID.
              FeatureShowcasePage(onNext: _handoffToAuth),
            ],
          ),

          // ── Progress bar (hidden on age gate & final auth handoff)
          if (_currentPage > 0 && _currentPage < _totalPages - 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + AppSpacing.sm,
              left: AppSpacing.screenHorizontal,
              right: AppSpacing.screenHorizontal,
              child: _ProgressBar(
                current: _currentPage,
                total: _totalPages - 1,
              ),
            ),
        ],
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
