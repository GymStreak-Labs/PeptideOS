import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:apprefer/apprefer.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app_shell.dart';
import 'core/firebase/firebase_init.dart';
import 'core/services/analytics_service.dart';
import 'core/services/support_service.dart';
import 'core/theme/theme.dart';
import 'core/widgets/widgets.dart';
import 'data/repositories/body_metric_repository.dart';
import 'data/repositories/dose_log_repository.dart';
import 'data/repositories/peptide_library_repository.dart';
import 'data/repositories/protocol_repository.dart';
import 'data/repositories/user_settings_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/superwall_bridge_service.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/screens/account_deleted_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/library/providers/peptide_provider.dart';
import 'features/onboarding/services/onboarding_draft_service.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/profile/providers/settings_provider.dart';
import 'features/progress/providers/body_metric_provider.dart';
import 'features/protocol/providers/dose_log_provider.dart';
import 'features/protocol/providers/protocol_provider.dart';
import 'features/subscription/providers/subscription_provider.dart';
import 'services/notification_service.dart';

/// AppRefer is injected via --dart-define so test/live keys can stay out of
/// source. Meta App Events uses public SDK/app identifiers in source. Release
/// builds fail fast if this value is missing; local/dev builds
/// can still run without attribution. AppRefer is configured on the first
/// visible app frame so install attribution is captured before onboarding/auth.
///
/// See CLAUDE.md for the per-SDK credential rollout plan.
const String _appReferApiKey = String.fromEnvironment(
  'APPREFER_API_KEY',
  defaultValue: 'TODO_APPREFER_API_KEY',
);
const String _facebookAppId = String.fromEnvironment(
  'FACEBOOK_APP_ID',
  defaultValue: '1657843155413563',
);

bool get _hasAppReferApiKey =>
    _appReferApiKey.trim().isNotEmpty && !_appReferApiKey.startsWith('TODO_');

Future<void> main() async {
  // Capture uncaught errors and ship them to Crashlytics once Firebase is up.
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      GoogleFonts.config.allowRuntimeFetching = false;

      // Lock to portrait — peptide tracking is a focused, one-hand experience.
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // Dark status bar icons on dark background.
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.background,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );

      // ── Essential init (awaited, pre-runApp) ───────────────────────────────
      await initializeFirebase();

      // Forward Flutter framework errors to Crashlytics.
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        try {
          FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        } catch (_) {}
      };

      _validateReleaseAttributionConfig();
      _validateReleaseSuperwallConfig();

      // Superwall is the sole purchase, restore, and entitlement provider.
      await SuperwallBridgeService.instance.configure();

      // Gleap support — safe no-op if GLEAP_SDK_TOKEN is not injected.
      await SupportService.instance.initialize();

      // Stable install ID on Crashlytics / Analytics / Superwall / Gleap. AppRefer
      // receives the same ID once it is configured on the first visible frame.
      await AnalyticsService().initializeIdentity();

      // Seed the peptide library on first authenticated launch. Idempotent —
      // safe to call even when the collection is already populated.
      unawaited(PeptideLibraryRepository().seedIfEmpty());

      runApp(const PepModApp());

      // ── Deferred init (post-first-frame, non-blocking) ─────────────────────
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        unawaited(NotificationService.instance.initialize());
        unawaited(_initAttributionAfterTrackingPrompt());
      });
    },
    (error, stack) {
      try {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      } catch (_) {}
    },
  );
}

Future<void> _initAttributionAfterTrackingPrompt() async {
  final trackingStatus = await _requestTrackingPermission();
  await _configureAppRefer();
  await _initFacebookEvents(trackingStatus);
}

Future<void> _configureAppRefer() async {
  if (!_hasAppReferApiKey) {
    if (kReleaseMode) {
      throw StateError(
        'Release builds require --dart-define=APPREFER_API_KEY.',
      );
    }
    debugPrint('AppRefer init skipped: APPREFER_API_KEY not configured.');
    return;
  }
  try {
    final analytics = AnalyticsService();
    await AppReferSDK.configure(
      AppReferConfig(apiKey: _appReferApiKey, userId: analytics.installId),
    );
    final appReferId = await AppReferSDK.getDeviceId();
    if (appReferId != null) {
      await SuperwallBridgeService.instance.setUserAttributes({
        'apprefer_id': appReferId,
      });
    }
    await analytics.syncAppReferIdentity();
  } catch (e) {
    debugPrint('AppRefer init failed: $e');
  }
}

void _validateReleaseAttributionConfig() {
  if (!kReleaseMode || _hasAppReferApiKey) return;
  throw StateError('Release builds require --dart-define=APPREFER_API_KEY.');
}

void _validateReleaseSuperwallConfig() {
  if (!kReleaseMode) return;
  if (!SuperwallBridgeService.enabled) {
    throw StateError('Release builds require Superwall to be enabled.');
  }
  if (SuperwallBridgeService.hasPlatformApiKey) return;
  throw StateError(
    'Release builds require --dart-define=SUPERWALL_IOS_API_KEY or '
    '--dart-define=SUPERWALL_ANDROID_API_KEY.',
  );
}

Future<void> _initFacebookEvents(TrackingStatus trackingStatus) async {
  if (_facebookAppId.startsWith('TODO_')) return;
  try {
    final fb = FacebookAppEvents();
    final advertiserTrackingAllowed =
        defaultTargetPlatform != TargetPlatform.iOS ||
        trackingStatus == TrackingStatus.authorized;
    await fb.setAdvertiserTracking(enabled: advertiserTrackingAllowed);
    if (advertiserTrackingAllowed) {
      await fb.logEvent(name: 'app_open');
    }
  } catch (e) {
    debugPrint('Facebook App Events init failed: $e');
  }
}

Future<TrackingStatus> _requestTrackingPermission() async {
  if (defaultTargetPlatform != TargetPlatform.iOS) {
    return TrackingStatus.notSupported;
  }
  try {
    // Let Flutter paint the first app screen before presenting the system
    // prompt; iOS only displays ATT while the app is active and foregrounded.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      return AppTrackingTransparency.requestTrackingAuthorization();
    }
    return status;
  } catch (e) {
    debugPrint('ATT request failed: $e');
    return TrackingStatus.notSupported;
  }
}

/// Top-level app widget — hosts the MultiProvider scope and swaps the root
/// view based on auth + onboarding state.
class PepModApp extends StatelessWidget {
  const PepModApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Auth + settings are base providers; every other user-scoped provider
    // listens to AuthProvider via ProxyProvider so the UID can swap on
    // sign-in / sign-out without re-creating the whole tree.
    return MultiProvider(
      providers: [
        // ── Auth & identity ────────────────────────────────────────────────
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        // ── Subscription (depends on settings so it can mirror tier) ───────
        ChangeNotifierProxyProvider<AuthProvider, SettingsProvider>(
          create: (_) => SettingsProvider(UserSettingsRepository(), uid: ''),
          update: (_, auth, previous) {
            final prov =
                previous ??
                SettingsProvider(UserSettingsRepository(), uid: auth.uid);
            prov.setUid(auth.uid);
            return prov;
          },
        ),
        ChangeNotifierProxyProvider<SettingsProvider, SubscriptionProvider>(
          create: (ctx) => SubscriptionProvider(
            settingsProvider: ctx.read<SettingsProvider>(),
          ),
          update: (_, settings, previous) {
            final provider = previous ?? SubscriptionProvider();
            provider.setSettingsProvider(settings);
            return provider;
          },
        ),
        // ── User-scoped data providers ─────────────────────────────────────
        ChangeNotifierProxyProvider<AuthProvider, PeptideProvider>(
          create: (_) => PeptideProvider(PeptideLibraryRepository()),
          update: (_, __, previous) =>
              previous ?? PeptideProvider(PeptideLibraryRepository()),
        ),
        ChangeNotifierProxyProvider2<
          AuthProvider,
          SettingsProvider,
          ProtocolProvider
        >(
          create: (_) => ProtocolProvider(
            ProtocolRepository(),
            DoseLogRepository(),
            uid: '',
          ),
          update: (_, auth, settings, previous) {
            final prov =
                previous ??
                ProtocolProvider(
                  ProtocolRepository(),
                  DoseLogRepository(),
                  uid: auth.uid,
                  notificationsEnabled: settings.settings.notificationsEnabled,
                );
            prov.setUid(auth.uid);
            prov.setNotificationsEnabled(
              settings.settings.notificationsEnabled,
            );
            return prov;
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, DoseLogProvider>(
          create: (_) => DoseLogProvider(DoseLogRepository(), uid: ''),
          update: (_, auth, previous) {
            final prov =
                previous ?? DoseLogProvider(DoseLogRepository(), uid: auth.uid);
            prov.setUid(auth.uid);
            return prov;
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, BodyMetricProvider>(
          create: (_) => BodyMetricProvider(BodyMetricRepository(), uid: ''),
          update: (_, auth, previous) {
            final prov =
                previous ??
                BodyMetricProvider(BodyMetricRepository(), uid: auth.uid);
            prov.setUid(auth.uid);
            return prov;
          },
        ),
        // Expose the auth service standalone for screens that only need it.
        Provider<AuthService>(
          create: (ctx) => ctx.read<AuthProvider>().authService,
        ),
      ],
      child: MaterialApp(
        title: 'PepMod',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const _AppRoot(),
      ),
    );
  }
}

/// Routes between auth gate, onboarding, and the main shell.
///
/// Flow:
/// 1. Auth not yet initialised → splash
/// 2. Onboarding not completed → OnboardingScreen
/// 3. Onboarding draft staged → AuthScreen
/// 4. Signed in → replay draft, then show post-auth PaywallScreen
/// 5. Signed in + onboarded + paywall handled → AppShell
class _AppRoot extends StatefulWidget {
  const _AppRoot();

  @override
  State<_AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> {
  bool _firstFrameRefresh = false;
  bool _handoffStateLoaded = false;
  bool _preAuthOnboardingReady = false;
  bool _postAuthPaywallPending = false;
  bool _onboardingReplayAttempted = false;
  bool _replayingOnboardingDraft = false;

  @override
  void initState() {
    super.initState();
    _loadOnboardingHandoffState();
  }

  Future<void> _loadOnboardingHandoffState() async {
    final hasDraft = await OnboardingDraftService.hasDraft();
    final paywallPending =
        await OnboardingDraftService.isPostAuthPaywallPending();
    if (!mounted) return;
    setState(() {
      _preAuthOnboardingReady = hasDraft;
      _postAuthPaywallPending = paywallPending;
      _handoffStateLoaded = true;
    });
  }

  void _markReadyForAuth() {
    final isSignedIn = context.read<AuthProvider>().isSignedIn;
    setState(() {
      _preAuthOnboardingReady = true;
      _postAuthPaywallPending = true;
      // A signed-in user can re-enter onboarding through Clear all data.
      // In that flow the first replay attempt happens before the new draft
      // exists, so release the latch now that onboarding has staged it.
      if (isSignedIn && !_replayingOnboardingDraft) {
        _onboardingReplayAttempted = false;
      }
    });
  }

  Future<void> _clearPostAuthPaywall() async {
    await OnboardingDraftService.setPostAuthPaywallPending(false);
    if (!mounted) return;
    setState(() => _postAuthPaywallPending = false);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final settings = context.watch<SettingsProvider>();

    // Regenerate dose schedules once after first auth — keeps the Today view
    // fresh after long sleeps. Fire-and-forget.
    if (auth.isSignedIn && !_firstFrameRefresh) {
      _firstFrameRefresh = true;
      final protocols = context.read<ProtocolProvider>();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(
          protocols.refresh().then((_) => protocols.regenerateSchedules()),
        );
      });
    }
    if (!auth.isSignedIn) {
      _firstFrameRefresh = false;
      _onboardingReplayAttempted = false;
      _replayingOnboardingDraft = false;
    }

    if (!auth.isInitialized) return const _Splash();
    if (!auth.isSignedIn && auth.accountDeletionCompleted) {
      return AccountDeletedScreen(
        onContinue: auth.clearAccountDeletionCompleted,
      );
    }

    // Onboarding story runs first; auth comes before the paywall so attribution
    // and Superwall purchase events attach to a stable Firebase UID.
    if (settings.isLoading && auth.isSignedIn) return const _Splash();
    if (!settings.settings.onboardingCompleted && !auth.isSignedIn) {
      if (!_handoffStateLoaded) return const _Splash();
      if (_preAuthOnboardingReady) {
        return const AuthScreen(createAccountByDefault: true);
      }
      return OnboardingScreen(onReadyForAuth: _markReadyForAuth);
    }

    if (!auth.isSignedIn) return const AuthScreen();
    if (!auth.isSubscriptionIdentityReady) return const _Splash();

    if (!settings.settings.onboardingCompleted) {
      if (!_onboardingReplayAttempted && !_replayingOnboardingDraft) {
        _onboardingReplayAttempted = true;
        _replayingOnboardingDraft = true;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await OnboardingDraftService.replayAfterAuth(
            email: auth.currentUser?.email ?? '',
            settings: context.read<SettingsProvider>(),
            protocols: context.read<ProtocolProvider>(),
            doseLogs: context.read<DoseLogProvider>(),
            library: context.read<PeptideProvider>(),
          );
          final paywallPending =
              await OnboardingDraftService.isPostAuthPaywallPending();
          if (!mounted) return;
          setState(() {
            _postAuthPaywallPending = paywallPending;
            _preAuthOnboardingReady = false;
            _replayingOnboardingDraft = false;
          });
        });
      }
      if (_replayingOnboardingDraft) return const _Splash();
      return OnboardingScreen(onReadyForAuth: _markReadyForAuth);
    }

    final subscription = context.watch<SubscriptionProvider>();
    final reviewAccount = settings.settings.reviewAccount;
    if (_postAuthPaywallPending &&
        !reviewAccount &&
        !SuperwallBridgeService.forcePremium &&
        !subscription.isPremium) {
      return _PostAuthPaywallGate(onComplete: _clearPostAuthPaywall);
    }
    if (_postAuthPaywallPending &&
        (reviewAccount ||
            SuperwallBridgeService.forcePremium ||
            subscription.isPremium)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(_clearPostAuthPaywall());
      });
    }

    return const AppShell();
  }
}

class _PostAuthPaywallGate extends StatefulWidget {
  const _PostAuthPaywallGate({required this.onComplete});

  final Future<void> Function() onComplete;

  @override
  State<_PostAuthPaywallGate> createState() => _PostAuthPaywallGateState();
}

class _PostAuthPaywallGateState extends State<_PostAuthPaywallGate> {
  bool _viewLogged = false;
  bool _superwallAttempted = false;
  bool _showRemoteUnavailable = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewLogged) return;
    _viewLogged = true;
    unawaited(AnalyticsService().logPaywallViewed('post_auth_onboarding'));
    _presentSuperwallIfAvailable();
  }

  void _presentSuperwallIfAvailable() {
    if (_superwallAttempted) return;
    final bridge = SuperwallBridgeService.instance;
    if (!bridge.canPresentPaywalls) {
      _showUnavailable();
      return;
    }

    _superwallAttempted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await bridge.presentPlacement(
        SuperwallPlacements.postAuthOnboarding,
        params: const {
          'source': 'post_auth_onboarding',
          'surface': 'hard_paywall',
        },
      );
      if (!mounted) return;
      if (result == SuperwallPlacementResult.completedPremium) {
        await widget.onComplete();
        return;
      }
      _showUnavailable();
    });
  }

  void _showUnavailable() => setState(() => _showRemoteUnavailable = true);

  void _retrySuperwall() {
    setState(() {
      _superwallAttempted = false;
      _showRemoteUnavailable = false;
    });
    _presentSuperwallIfAvailable();
  }

  Future<void> _handleRestore() async {
    final sub = context.read<SubscriptionProvider>();
    final result = await sub.restore();
    if (!mounted) return;
    if (result.success && result.isPremium) {
      await widget.onComplete();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.error ?? 'No purchases found to restore.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showRemoteUnavailable) {
      return _RemotePaywallUnavailable(
        onRetry: _retrySuperwall,
        onRestore: _handleRestore,
      );
    }
    return const _Splash();
  }
}

class _RemotePaywallUnavailable extends StatelessWidget {
  const _RemotePaywallUnavailable({
    required this.onRetry,
    required this.onRestore,
  });

  final VoidCallback onRetry;
  final Future<void> Function() onRestore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'SYS.PRO // CONNECTION',
                style: AppTypography.systemLabel,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'PepMod Pro is not available right now',
                style: AppTypography.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Please try again or restore an existing purchase.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(label: 'TRY AGAIN', onPressed: onRetry),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: onRestore,
                child: Text(
                  'Restore purchases',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }
}

/// Minimal `unawaited` helper to document intentional fire-and-forget calls.
void unawaited(Future<void> future) {
  // Intentionally discard the future.
}
