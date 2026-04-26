import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/analytics_service.dart';
import '../../../core/theme/theme.dart';
import '../../../models/protocol.dart';
import '../../library/providers/peptide_provider.dart';
import '../../protocol/providers/dose_log_provider.dart';
import '../../protocol/providers/protocol_provider.dart';
import '../../profile/providers/settings_provider.dart';
import '../../subscription/providers/subscription_provider.dart';
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
import '../widgets/paywall_page.dart';

/// Full 17-screen onboarding flow — conversion-optimised v2.
///
/// Phase 1 — Emotional Mirror:   Age Gate → Hook → Social Proof → Disclaimer
/// Phase 2 — Personalisation:    Name → Birth Date → Goals → Experience → Frustration → Peptides
/// Phase 3 — Aha Moment:         Calculator Demo → Review Gate
/// Phase 4 — Reveal:             Processing → Protocol Preview → Results Summary
/// Phase 5 — Features & Convert: Feature Showcase → Paywall
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  static const _totalPages = 17;

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

  Future<void> _completeOnboarding() async {
    // Persist onboarding data and seed a first protocol from the user's picks.
    final settings = context.read<SettingsProvider>();
    final protocols = context.read<ProtocolProvider>();
    final doseLogs = context.read<DoseLogProvider>();
    final library = context.read<PeptideProvider>();

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

      await settings.completeOnboarding(
        name: _firstName,
        birthDate: _birthDate,
        goals: _selectedGoals.toList(),
        experience: _experienceLevel,
        frustration: _frustration,
      );

      if (_selectedPeptides.isNotEmpty) {
        // Match onboarding names to library peptides (case-insensitive).
        final matched = <String, String>{};
        for (final name in _selectedPeptides) {
          for (final p in library.all) {
            if (p.name.toLowerCase() == name.toLowerCase() ||
                p.slug.toLowerCase() == name.toLowerCase()) {
              matched[p.slug] = p.name;
              break;
            }
          }
        }

        final peptideEntries = <ProtocolPeptide>[];
        for (final slug in matched.keys) {
          final lib = library.findBySlug(slug);
          if (lib == null) continue;
          peptideEntries.add(
            protocols.buildPeptide(
              slug: lib.slug,
              name: lib.name,
              dose: lib.defaultDoseMcg,
              frequency: lib.defaultFrequency,
              route: lib.defaultRoute,
              cycleWeeks: lib.typicalCycleWeeks,
            ),
          );
        }

        if (peptideEntries.isNotEmpty) {
          await protocols.createProtocol(
            name: 'My Protocol',
            startDate: DateTime.now(),
            peptides: peptideEntries,
          );
          await doseLogs.refresh();
        }
      }

      if (settings.uid.isNotEmpty) {
        await OnboardingDraftService.clear();
      }
    } catch (e) {
      debugPrint('completeOnboarding failed: $e');
    }

    // The _AppRoot widget will re-render and show AppShell once
    // onboardingCompleted flips to true.
  }

  String get _firstPeptide =>
      _selectedPeptides.isNotEmpty ? _selectedPeptides.first : 'BPC-157';

  Future<void> _handleSubscribe(int selectedPlan) async {
    final sub = context.read<SubscriptionProvider>();
    AnalyticsService().logPaywallViewed('onboarding');

    if (!sub.isLoadingOfferings && sub.offerings == null) {
      await sub.loadOfferings();
    }
    if (!mounted) return;

    final offerings = sub.offerings;
    // If RC offerings are unavailable, skip straight to post-onboarding so
    // internal testers can still reach the app shell.
    final pkg = offerings == null
        ? null
        : sub.packageForOnboardingPlan(selectedPlan);

    if (pkg == null) {
      await _completeOnboarding();
      return;
    }

    AnalyticsService().logPurchaseInitiated(pkg.identifier);
    final result = await sub.purchase(pkg);
    if (!mounted) return;
    if (result.success || result.cancelled) {
      await _completeOnboarding();
    } else if (result.error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.error!)));
    }
  }

  Future<void> _handleRestore() async {
    final sub = context.read<SubscriptionProvider>();
    final result = await sub.restore();
    if (!mounted) return;
    if (result.success && result.isPremium) {
      await _completeOnboarding();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.error ?? 'No purchases found to restore.'),
        ),
      );
    }
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
                    'PeptideOS is a tracking and educational tool only. It does not provide medical advice, diagnosis, or treatment.\n\nAlways consult a qualified healthcare provider before starting any peptide regimen.\n\nBy continuing, you acknowledge this is not a medical device.',
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

              // 15: Feature Showcase
              FeatureShowcasePage(onNext: _nextPage),

              // 16: Paywall
              PaywallPage(
                onSubscribe: _handleSubscribe,
                onRestore: _handleRestore,
              ),
            ],
          ),

          // ── Progress bar (hidden on age gate & paywall)
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
