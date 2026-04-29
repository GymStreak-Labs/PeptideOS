import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/core/widgets/widgets.dart';
import 'package:peptide_os/features/library/widgets/syringe_visual.dart';
import 'package:peptide_os/features/onboarding/widgets/calculator_demo_page.dart';
import 'package:peptide_os/features/onboarding/widgets/first_name_page.dart';
import 'package:peptide_os/features/onboarding/widgets/paywall_page.dart';
import 'package:peptide_os/features/onboarding/widgets/processing_page.dart';
import 'package:peptide_os/features/onboarding/widgets/protocol_preview_page.dart';
import 'package:peptide_os/features/onboarding/widgets/results_summary_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const PepModScreenshotHarness());
}

class PepModScreenshotHarness extends StatelessWidget {
  const PepModScreenshotHarness({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PepMod Screenshots',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const _ScreenshotPager(),
    );
  }
}

class _ScreenshotPager extends StatefulWidget {
  const _ScreenshotPager();

  @override
  State<_ScreenshotPager> createState() => _ScreenshotPagerState();
}

class _ScreenshotPagerState extends State<_ScreenshotPager> {
  late final PageController _controller;
  static const _initialPage = int.fromEnvironment(
    'SCREENSHOT_INITIAL_PAGE',
    defaultValue: 0,
  );
  int _index = _initialPage;

  static const _peptides = {'BPC-157', 'TB-500', 'CJC-1295'};
  static const _goals = {'Recovery', 'Longevity'};

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index >= _pages.length - 1) return;
    _controller.nextPage(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  void _previous() {
    if (_index <= 0) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  List<Widget> get _pages => [
    FirstNamePage(firstName: 'Joe', onChanged: (_) {}, onNext: _next),
    const CalculatorDemoPage(peptideName: 'BPC-157', onNext: _noop),
    ProcessingPage(
      selectedPeptides: _peptides,
      selectedGoals: _goals,
      onNext: () {},
    ),
    const _ProtocolBuilderMockScreen(),
    ProtocolPreviewPage(peptides: _peptides, onNext: _next),
    ResultsSummaryPage(
      selectedGoals: _goals,
      experienceLevel: 'Intermediate',
      frustration: 'Keeping protocols organised',
      selectedPeptides: _peptides,
      onNext: _next,
    ),
    PaywallPage(onSubscribe: (_) async {}, onRestore: () {}),
    const _TodayMockScreen(),
    const _ConverterMockScreen(),
    const _ProgressMockScreen(),
    const _LibraryMockScreen(),
    const _ProfileMockScreen(),
  ];

  static void _noop() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) => setState(() => _index = value),
            children: _pages,
          ),
          Positioned.fill(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _previous,
                    child: const SizedBox.expand(),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _next,
                    child: const SizedBox.expand(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppFrame extends StatelessWidget {
  const _AppFrame({required this.tabIndex, required this.child});

  final int tabIndex;
  final Widget child;

  static const _tabs = [
    GlassTabItem(
      icon: Icons.medical_services_outlined,
      activeIcon: Icons.medical_services_rounded,
      label: 'Protocol',
    ),
    GlassTabItem(
      icon: Icons.insights_outlined,
      activeIcon: Icons.insights_rounded,
      label: 'Progress',
    ),
    GlassTabItem(
      icon: Icons.science_outlined,
      activeIcon: Icons.science_rounded,
      label: 'Library',
    ),
    GlassTabItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'You',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        GlassTabBar(items: _tabs, currentIndex: tabIndex, onTap: (_) {}),
      ],
    );
  }
}

class _ScreenHeader extends StatelessWidget {
  const _ScreenHeader({
    required this.systemLabel,
    required this.title,
    this.actionIcon,
  });

  final String systemLabel;
  final String title;
  final IconData? actionIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        MediaQuery.of(context).padding.top + AppSpacing.xl,
        AppSpacing.screenHorizontal,
        AppSpacing.base,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(systemLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Text(title, style: AppTypography.h1),
              ],
            ),
          ),
          if (actionIcon != null)
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.08),
                border: Border.all(color: AppColors.borderCyan),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    blurRadius: 18,
                  ),
                ],
              ),
              child: Icon(actionIcon, color: AppColors.primary),
            ),
        ],
      ),
    );
  }
}

class _ProtocolBuilderMockScreen extends StatelessWidget {
  const _ProtocolBuilderMockScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.screenHorizontal,
                0,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SYS.PROTOCOL // NEW',
                          style: AppTypography.systemLabel,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Build Protocol · Step 2 / 3',
                          style: AppTypography.h3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Row(
                children: List.generate(3, (i) {
                  final active = i <= 1;
                  return Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.only(right: i < 2 ? 3 : 0),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : AppColors.border,
                        borderRadius: BorderRadius.circular(1),
                        boxShadow: i == 1
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.5,
                                  ),
                                  blurRadius: 4,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add peptides', style: AppTypography.h2),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Pick from the library and configure dose, frequency, and cycle.',
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const _BuilderPeptideCard(
                      name: 'BPC-157',
                      detail: '250 mcg · Daily · 8 weeks',
                      time: '08:00',
                    ),
                    const SizedBox(height: AppSpacing.cardGap),
                    const _BuilderPeptideCard(
                      name: 'TB-500',
                      detail: '2.5 mg · Twice weekly · 8 weeks',
                      time: '12:30',
                    ),
                    const SizedBox(height: AppSpacing.cardGap),
                    const _BuilderPeptideCard(
                      name: 'CJC-1295',
                      detail: '100 mcg · 5 nights / week · 12 weeks',
                      time: '21:00',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      height: AppSpacing.buttonHeight,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.buttonRadius,
                        ),
                        border: Border.all(color: AppColors.borderCyan),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.10),
                            blurRadius: 14,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_rounded,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            'ADD PEPTIDE',
                            style: AppTypography.button.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: const [
                        Expanded(
                          child: _BuilderStatTile(
                            label: 'PEPTIDES',
                            value: '3',
                          ),
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: _BuilderStatTile(
                            label: 'REMINDERS',
                            value: '5',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
              child: PrimaryButton(label: 'NEXT', onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuilderPeptideCard extends StatelessWidget {
  const _BuilderPeptideCard({
    required this.name,
    required this.detail,
    required this.time,
  });

  final String name;
  final String detail;
  final String time;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      glowColor: name == 'BPC-157' ? AppColors.primary : null,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderCyan),
            ),
            child: const Icon(Icons.biotech_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.labelLarge),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: AppTypography.bodySmall.copyWith(
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            time,
            style: AppTypography.tabular.copyWith(
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuilderStatTile extends StatelessWidget {
  const _BuilderStatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.systemLabel.copyWith(
              color: AppColors.textTertiary,
              fontSize: 9,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTypography.h2.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _TodayMockScreen extends StatelessWidget {
  const _TodayMockScreen();

  @override
  Widget build(BuildContext context) {
    return _AppFrame(
      tabIndex: 0,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ScreenHeader(
              systemLabel: 'SYS.PROTOCOL // TODAY',
              title: 'Tuesday\nApr 28',
              actionIcon: Icons.add_rounded,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: AppCard(
                borderColor: AppColors.borderCyan,
                glowColor: AppColors.primaryGlow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const _StatusDot(color: AppColors.primary),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'NEXT DOSE // 08:00',
                          style: AppTypography.systemLabel,
                        ),
                        const Spacer(),
                        Text(
                          'ON TRACK',
                          style: AppTypography.systemLabel.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('BPC-157', style: AppTypography.h2),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                '250 mcg · 10 units · Sub-Q',
                                style: AppTypography.bodyMedium,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(99),
                                child: const LinearProgressIndicator(
                                  minHeight: 10,
                                  value: 0.68,
                                  color: AppColors.primary,
                                  backgroundColor: AppColors.border,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.base),
                        Text(
                          '2h 14m',
                          style: AppTypography.heroMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    PrimaryButton(label: 'MARK AS TAKEN', onPressed: () {}),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Text(
                'SCHEDULE // TODAY',
                style: AppTypography.systemLabel,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                children: [
                  _DoseRow(
                    time: '08:00',
                    peptide: 'BPC-157',
                    meta: '250 mcg · abdomen',
                    status: 'READY',
                    glow: true,
                  ),
                  SizedBox(height: AppSpacing.cardGap),
                  _DoseRow(
                    time: '12:30',
                    peptide: 'TB-500',
                    meta: '2.5 mg · thigh',
                    status: 'UP NEXT',
                  ),
                  SizedBox(height: AppSpacing.cardGap),
                  _DoseRow(
                    time: '21:00',
                    peptide: 'CJC-1295',
                    meta: '100 mcg · rotate site',
                    status: 'PM',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.screenBottom),
          ],
        ),
      ),
    );
  }
}

class _DoseRow extends StatelessWidget {
  const _DoseRow({
    required this.time,
    required this.peptide,
    required this.meta,
    required this.status,
    this.glow = false,
  });

  final String time;
  final String peptide;
  final String meta;
  final String status;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      glowColor: glow ? AppColors.primaryGlow : null,
      padding: const EdgeInsets.all(AppSpacing.base),
      child: Row(
        children: [
          Text(
            time,
            style: AppTypography.tabular.copyWith(color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(peptide, style: AppTypography.labelLarge),
                const SizedBox(height: 2),
                Text(meta, style: AppTypography.bodySmall),
              ],
            ),
          ),
          Text(
            status,
            style: AppTypography.systemLabel.copyWith(
              color: glow ? AppColors.primary : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConverterMockScreen extends StatelessWidget {
  const _ConverterMockScreen();

  @override
  Widget build(BuildContext context) {
    return _AppFrame(
      tabIndex: 2,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ScreenHeader(
              systemLabel: 'SYS.CONVERT // UNITS',
              title: 'Unit\nConverter',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: AppCard(
                borderColor: AppColors.borderCyan,
                glowColor: AppColors.primaryGlow,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SyringeVisual(
                      fillFraction: 0.10,
                      totalUnits: 100,
                      fillUnits: 10,
                      height: 260,
                    ),
                    const SizedBox(width: AppSpacing.base),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DRAW VOLUME', style: AppTypography.systemLabel),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '10.0',
                                style: AppTypography.heroLarge.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text('units', style: AppTypography.unit),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          const _DataTile(
                            label: 'PEPTIDE',
                            value: '5mg BPC-157',
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const _DataTile(label: 'BAC WATER', value: '2ml'),
                          const SizedBox(height: AppSpacing.sm),
                          const _DataTile(label: 'TARGET', value: '250mcg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.cardGap),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      label: 'CONCENTRATION',
                      value: '2500',
                      unit: 'mcg/ml',
                    ),
                  ),
                  SizedBox(width: AppSpacing.cardGap),
                  Expanded(
                    child: _MetricCard(
                      label: 'DOSES / VIAL',
                      value: '20',
                      unit: 'doses',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Text(
                'Educational unit conversion only. Not medical advice.',
                style: AppTypography.disclaimer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressMockScreen extends StatelessWidget {
  const _ProgressMockScreen();

  @override
  Widget build(BuildContext context) {
    return _AppFrame(
      tabIndex: 1,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ScreenHeader(
              systemLabel: 'SYS.PROGRESS // 30D',
              title: 'Progress',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: AppCard(
                borderColor: AppColors.borderCyan,
                glowColor: AppColors.primaryGlow,
                child: Row(
                  children: [
                    SizedBox(
                      width: 136,
                      height: 136,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          const CircularProgressIndicator(
                            value: 0.92,
                            strokeWidth: 12,
                            color: AppColors.primary,
                            backgroundColor: AppColors.border,
                            strokeCap: StrokeCap.round,
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '92%',
                                  style: AppTypography.h2.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                Text(
                                  'ADHERENCE',
                                  style: AppTypography.systemLabel.copyWith(
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    const Expanded(
                      child: Column(
                        children: [
                          _DataTile(label: 'CURRENT STREAK', value: '14 days'),
                          SizedBox(height: AppSpacing.sm),
                          _DataTile(label: 'LOGGED DOSES', value: '38'),
                          SizedBox(height: AppSpacing.sm),
                          _DataTile(label: 'BODY WEIGHT', value: '184.2 lb'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Text(
                'WELLNESS // CHECK-IN',
                style: AppTypography.systemLabel,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _SignalCard(
                          icon: Icons.bolt_rounded,
                          label: 'Energy',
                          value: '8/10',
                        ),
                      ),
                      SizedBox(width: AppSpacing.cardGap),
                      Expanded(
                        child: _SignalCard(
                          icon: Icons.hotel_rounded,
                          label: 'Sleep',
                          value: '7h 42m',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.cardGap),
                  Row(
                    children: [
                      Expanded(
                        child: _SignalCard(
                          icon: Icons.healing_rounded,
                          label: 'Recovery',
                          value: 'Good',
                        ),
                      ),
                      SizedBox(width: AppSpacing.cardGap),
                      Expanded(
                        child: _SignalCard(
                          icon: Icons.mood_rounded,
                          label: 'Mood',
                          value: 'Stable',
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
}

class _LibraryMockScreen extends StatelessWidget {
  const _LibraryMockScreen();

  @override
  Widget build(BuildContext context) {
    return _AppFrame(
      tabIndex: 2,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ScreenHeader(
              systemLabel: 'SYS.LIBRARY // REFERENCE',
              title: 'Peptide\nLibrary',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                  border: Border.all(color: AppColors.borderCyan),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Search peptides, calculators, protocols',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                children: [
                  _PeptideCard(
                    name: 'BPC-157',
                    category: 'Recovery',
                    badge: 'POPULAR',
                    desc: 'Educational reference profile with unit converter.',
                  ),
                  SizedBox(height: AppSpacing.cardGap),
                  _PeptideCard(
                    name: 'TB-500',
                    category: 'Recovery',
                    badge: 'STACK',
                    desc: 'Track protocols, notes, and schedule history.',
                  ),
                  SizedBox(height: AppSpacing.cardGap),
                  _PeptideCard(
                    name: 'CJC-1295',
                    category: 'Longevity',
                    badge: 'RESEARCH',
                    desc: 'Organise cycle details and reminder cadence.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.screenBottom),
          ],
        ),
      ),
    );
  }
}

class _ProfileMockScreen extends StatelessWidget {
  const _ProfileMockScreen();

  @override
  Widget build(BuildContext context) {
    return _AppFrame(
      tabIndex: 3,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ScreenHeader(
              systemLabel: 'SYS.USER // CONTROL',
              title: 'You',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: AppCard(
                borderColor: AppColors.borderCyan,
                glowColor: AppColors.primaryGlow,
                child: Row(
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.aiInsightBright,
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: AppColors.background,
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.base),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Joe', style: AppTypography.h3),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Premium protocol access',
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'ACTIVE',
                      style: AppTypography.systemLabel.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.cardGap),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                children: [
                  _SettingsRow(
                    icon: Icons.notifications_active_rounded,
                    title: 'Dose reminders',
                    subtitle: 'Local notifications enabled',
                  ),
                  SizedBox(height: AppSpacing.cardGap),
                  _SettingsRow(
                    icon: Icons.ios_share_rounded,
                    title: 'Export data',
                    subtitle: 'Protocols, logs, and metrics',
                  ),
                  SizedBox(height: AppSpacing.cardGap),
                  _SettingsRow(
                    icon: Icons.privacy_tip_rounded,
                    title: 'Privacy & terms',
                    subtitle: 'AppStoreCopilot-hosted legal docs',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.7), blurRadius: 8),
        ],
      ),
    );
  }
}

class _DataTile extends StatelessWidget {
  const _DataTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.systemLabel.copyWith(
              fontSize: 9,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 3),
          Text(value, style: AppTypography.labelLarge),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.unit,
  });
  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.systemLabel.copyWith(fontSize: 9)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.h2.copyWith(color: AppColors.primary),
          ),
          Text(unit, style: AppTypography.unit),
        ],
      ),
    );
  }
}

class _SignalCard extends StatelessWidget {
  const _SignalCard({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(height: AppSpacing.md),
          Text(value, style: AppTypography.h3),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: AppTypography.systemLabel.copyWith(
              color: AppColors.textTertiary,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

class _PeptideCard extends StatelessWidget {
  const _PeptideCard({
    required this.name,
    required this.category,
    required this.badge,
    required this.desc,
  });
  final String name;
  final String category;
  final String badge;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.08),
              border: Border.all(color: AppColors.borderCyan),
            ),
            child: const Icon(Icons.biotech_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.base),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: AppTypography.h3),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(color: AppColors.borderCyan),
                      ),
                      child: Text(
                        badge,
                        style: AppTypography.systemLabel.copyWith(fontSize: 8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  category.toUpperCase(),
                  style: AppTypography.systemLabel.copyWith(
                    color: AppColors.primary,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(desc, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.base),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: AppSpacing.base),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelLarge),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.bodySmall),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}
