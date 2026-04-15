import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/age_gate_page.dart';
import '../widgets/goals_page.dart';
import '../widgets/experience_page.dart';
import '../widgets/paywall_page.dart';
import '../../../app_shell.dart';

/// Full onboarding flow controller.
/// Age gate → Welcome → Disclaimer → Goals → Experience → Paywall.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  static const _totalPages = 6;

  // Collected data
  final Set<String> _selectedGoals = {};
  String _experienceLevel = '';

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
              // 0: Age Gate
              AgeGatePage(onConfirmed: _nextPage),

              // 1: Welcome
              OnboardingPage(
                systemLabel: 'SYS.INIT // WELCOME',
                title: 'Welcome to\nPeptideOS',
                body:
                    'Your intelligent peptide protocol manager. Track doses, calculate reconstitution, and optimise your journey with AI-powered insights.',
                icon: Icons.biotech_rounded,
                buttonLabel: 'CONTINUE',
                onNext: _nextPage,
              ),

              // 2: Medical Disclaimer
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

              // 5: Paywall
              PaywallPage(
                onSubscribe: _completeOnboarding,
                onRestore: _completeOnboarding,
              ),
            ],
          ),

          // ── Progress bar (except age gate and paywall) ─────────────
          if (_currentPage > 0 && _currentPage < _totalPages - 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + AppSpacing.sm,
              left: AppSpacing.screenHorizontal,
              right: AppSpacing.screenHorizontal,
              child: _ProgressBar(
                current: _currentPage,
                total: _totalPages - 1, // exclude paywall from count
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
            margin: EdgeInsets.only(right: index < total - 1 ? 4 : 0),
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
