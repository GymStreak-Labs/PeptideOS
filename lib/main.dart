import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app_shell.dart';
import 'core/theme/theme.dart';
import 'features/library/providers/peptide_provider.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/profile/providers/settings_provider.dart';
import 'features/progress/providers/body_metric_provider.dart';
import 'features/protocol/providers/dose_log_provider.dart';
import 'features/protocol/providers/protocol_provider.dart';
import 'services/database_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait — peptide tracking is a focused, one-hand experience.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Dark status bar icons on dark background.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.background,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Open Isar and seed the peptide library on first launch.
  final db = await DatabaseService.init();
  await NotificationService.instance.init();

  // Regenerate dose schedules for any active protocols on app open, so the
  // Today view reflects reality after long app sleeps.
  final protocolProvider = ProtocolProvider(db);
  // Fire and forget — the provider will notify when load completes.
  unawaited(protocolProvider.refresh().then((_) => protocolProvider.regenerateSchedules()));

  runApp(PeptideOSApp(db: db, protocolProvider: protocolProvider));
}

/// Top-level app widget — hosts the MultiProvider scope and decides between
/// the onboarding flow and the main shell based on [UserSettings.onboardingCompleted].
class PeptideOSApp extends StatelessWidget {
  const PeptideOSApp({
    super.key,
    required this.db,
    required this.protocolProvider,
  });

  final DatabaseService db;
  final ProtocolProvider protocolProvider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseService>.value(value: db),
        ChangeNotifierProvider<PeptideProvider>(
          create: (_) => PeptideProvider(db),
        ),
        ChangeNotifierProvider<ProtocolProvider>.value(value: protocolProvider),
        ChangeNotifierProvider<DoseLogProvider>(
          create: (_) => DoseLogProvider(db),
        ),
        ChangeNotifierProvider<BodyMetricProvider>(
          create: (_) => BodyMetricProvider(db),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(db),
        ),
      ],
      child: MaterialApp(
        title: 'PeptideOS',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const _AppRoot(),
      ),
    );
  }
}

/// Routes between onboarding and the main shell based on settings state.
class _AppRoot extends StatelessWidget {
  const _AppRoot();

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        if (settings.isLoading) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        return settings.settings.onboardingCompleted
            ? const AppShell()
            : const OnboardingScreen();
      },
    );
  }
}

/// Minimal `unawaited` helper to document intentional fire-and-forget calls.
void unawaited(Future<void> future) {
  // Intentionally discard the future — the caller doesn't need completion signal.
}
