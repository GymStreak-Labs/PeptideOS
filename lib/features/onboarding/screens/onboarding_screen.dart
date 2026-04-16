import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../widgets/age_gate_page.dart';
import '../widgets/hook_page.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/goals_page.dart';
import '../widgets/experience_page.dart';
import '../widgets/frustration_page.dart';
import '../widgets/peptide_select_page.dart';
import '../widgets/calculator_demo_page.dart';
import '../widgets/protocol_preview_page.dart';
import '../widgets/feature_showcase_page.dart';
import '../widgets/notification_page.dart';
import '../widgets/paywall_page.dart';
import '../../../app_shell.dart';

/// Full 12-screen onboarding flow — rejection-proofed.
///
/// Phase 1 — Emotional Mirror:   Age Gate → Hook → Disclaimer
/// Phase 2 — Personalisation:    Goals → Experience → Frustration → Peptides
/// Phase 3 — Product Demo:       Calculator Demo → Protocol Preview → Features
/// Phase 4 — Permissions:        Notifications
/// Phase 5 — Convert:            Paywall
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  static const _totalPages = 12;

  // Collected data
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

  void _completeOnboarding() {
    // TODO: save onboarding data, check subscription
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppShell()),
      (route) => false,
    );
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
                    'PeptideOS is a tracking and educational tool only. It does not provide medical advice, diagnosis, or treatment.\n\nAlways consult a qualified healthcare provider before starting any peptide regimen.\n\nBy continuing, you acknowledge this is not a medical device.',
                icon: Icons.shield_rounded,
                iconColor: AppColors.warning,
                buttonLabel: 'I UNDERSTAND',
                onNext: _nextPage,
              ),

              // ── Phase 2: Personalisation (sunk cost) ──────────────

              // 3: Goals
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

              // 4: Experience Level
              ExperiencePage(
                selected: _experienceLevel,
                onSelect: (level) {
                  setState(() => _experienceLevel = level);
                },
                onNext: _nextPage,
              ),

              // 5: Biggest Frustration
              FrustrationPage(
                selected: _frustration,
                onSelect: (f) => setState(() => _frustration = f),
                onNext: _nextPage,
              ),

              // 6: Current/Planned Peptides
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

              // ── Phase 3: Product Demo (see the value) ─────────────

              // 7: Unit Converter Demo
              CalculatorDemoPage(
                peptideName: _firstPeptide,
                onNext: _nextPage,
              ),

              // 8: Protocol Preview
              ProtocolPreviewPage(
                peptides: _selectedPeptides,
                onNext: _nextPage,
              ),

              // 9: Feature Showcase
              FeatureShowcasePage(onNext: _nextPage),

              // ── Phase 4: Permissions ───────────────────────────────

              // 10: Notification Permission
              NotificationPage(onNext: _nextPage),

              // ── Phase 5: Convert ──────────────────────────────────

              // 11: Paywall
              PaywallPage(
                onSubscribe: _completeOnboarding,
                onRestore: _completeOnboarding,
              ),
            ],
          ),

          // ── Progress bar (screens 1-10, hidden on age gate & paywall)
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
