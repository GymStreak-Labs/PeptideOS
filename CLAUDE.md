# PepMod

## Overview
Intelligent peptide protocol manager. Track doses, calculate reconstitution, manage protocols, and optimise your peptide journey with AI-powered insights.

Public app name: **PepMod**. Historical internal package/bundle identifiers still use `peptide_os` / `peptideOs`; do not rename those unless Firebase, Superwall, the retained legacy RevenueCat provider records, AppRefer, Meta, App Store, and Play Console integrations are migrated together.

## Tech Stack
- **Framework**: Flutter 3.41.4
- **Platform**: iOS + Android (unified design — no platform-adaptive widgets)
- **Fonts**: Space Grotesk (body) + JetBrains Mono (data) via `google_fonts`
- **Backend**: Firebase (Auth, Firestore) — Phase 2, replaces Isar. Firestore offline persistence enabled.
- **Auth**: Firebase Auth — Apple (iOS), Email/password, and Google once mobile OAuth is provisioned. Anonymous mode is intentionally disabled so AppRefer attribution survives cross-device.
- **Subscriptions**: Superwall (`superwallkit_flutter` 2.x) owns paywall presentation, purchases, restores, subscription status, and access. Only the active Superwall entitlement whose identifier is exactly `premium` grants Pro.
- **Attribution**: AppRefer Flutter SDK 0.4.1 (`configure` on app start with API key + advanced matching on sign-in).
- **Ad events**: Facebook App Events + App Tracking Transparency (ATT prompt requested on first visible app session; Facebook/AppRefer attribution starts only after the ATT request path has run).
- **Notifications**: `flutter_local_notifications` 18.x + `timezone` + `flutter_timezone` — real scheduling wired in Phase 2.
- **State management**: `provider` 6.1 — one ChangeNotifier per feature, UID-aware via `setUid()`.
- **Charts**: `fl_chart` 0.69
- **IDs**: `uuid` 4.5 — Firestore doc IDs + DoseLog cross-reference keys.

## Credential placeholders (search for these before release)
Meta App Events identifiers are live in source.
The remaining placeholders live in source code for visibility:
- `lib/main.dart` — `APPREFER_API_KEY` (read via `--dart-define`; live/test values are stored in Mission Control vault)
- `lib/data/services/superwall_bridge_service.dart` — `SUPERWALL_IOS_API_KEY` / `SUPERWALL_ANDROID_API_KEY` (read via `--dart-define`; public SDK keys are stored in Mission Control vault)
- Gleap support SDK token is read via `--dart-define=GLEAP_SDK_TOKEN`; live value is stored in Mission Control vault as `peptideos-gleap-sdk-token`. Missing token safely falls back to `support@gymstreak.com`.
- No TODOs for Firebase — using the dedicated `pepmod-prod` project (iOS + Android apps already registered).

Use `--dart-define=FORCE_PREMIUM=true` only as an explicit internal/reviewer bypass. Normal release builds use Superwall and must include the platform Superwall SDK key.

## Provisioned third-party app IDs
- AppRefer app: `app_74601f5191f` (GymStreak Labs org). Live/test SDK keys are stored in Mission Control vault as `peptideos-apprefer-api-key` and `peptideos-apprefer-test-api-key`.
- Legacy RevenueCat provider project/webhook: retained temporarily outside the app runtime until Superwall provider cutover and transaction-deduplicated AppRefer attribution are proven. The existing `AppRefer PepMod` webhook must not be deleted early. It points to `https://apprefer.com/api/webhook/revenuecat/app_74601f5191f`; its credentials remain in Mission Control vault and must never be added to the client.
- Meta app: `1657843155413563` (GymStreak business portfolio). Client token and URL scheme are stored in Mission Control vault as `peptideos-meta-client-token` and `peptideos-meta-url-scheme`; source is also configured for Facebook App Events on iOS + Android.
- Gleap support: project `PepMod` / `6a245300938ecfa0b363283c` in the GymStreak Labs Gleap org. App-side SDK integration is wired with hidden floating button and Profile -> Contact support entrypoint. Client token must be injected via `GLEAP_SDK_TOKEN`; AppStoreCopilot/MCP uses the PepMod service-account API token stored as `peptideos-gleap-api-token`.
- Superwall: full runtime subscription owner. Public project keys are injected via `SUPERWALL_IOS_API_KEY` and `SUPERWALL_ANDROID_API_KEY`. Target account: `joe+pepmod@gymstreaklabs.com` in the GymStreak Labs profile. Superwall performs purchases and restores directly and is the authoritative subscription-status source.

## Bundle ID
- iOS: `com.gymstreaklabs.peptideOs`
- Android: `com.gymstreaklabs.peptide_os`

## Firebase Project
- Project ID: `pepmod-prod`
- Project number: `183647218511`
- iOS app ID: `1:183647218511:ios:df57adc5f7327dfb6a733a`
- Android app ID: `1:183647218511:android:c725d5d8fbdb89716a733a`
- Firestore: `(default)` database in `nam5`
- Auth providers: Apple and email/password are enabled. Google is hidden by default (`--dart-define=ENABLE_GOOGLE_SIGN_IN=true` re-enables the button) until mobile OAuth client setup is complete.

## Review Account
- Email: `review-pepmod@gymstreaklabs.com`
- Password: stored in `mc-vault` as `pepmod-reviewer-password`
- Firebase Auth user exists in `pepmod-prod`, sign-in is verified, and App Store Connect App Review details use this account.

## Project Structure
```
lib/
├── core/
│   ├── theme/          # Design system tokens
│   │   ├── colors.dart       # Full colour palette (dark-mode-first)
│   │   ├── typography.dart   # Type scale (Inter, hero → disclaimer)
│   │   ├── spacing.dart      # 4pt grid system + component sizes
│   │   ├── durations.dart    # Animation timing tokens
│   │   ├── app_theme.dart    # Unified ThemeData builder
│   │   └── theme.dart        # Barrel export
│   ├── widgets/        # Reusable custom components
│   │   ├── glass_container.dart  # Frosted glass surface (BackdropFilter)
│   │   ├── glass_tab_bar.dart    # Floating glass bottom navigation
│   │   ├── app_card.dart         # Standard content card with optional glow
│   │   ├── primary_button.dart   # Primary action button with haptics
│   │   └── widgets.dart          # Barrel export
│   ├── constants/
│   ├── utils/
│   └── extensions/
├── features/
│   ├── protocol/       # 💉 Protocol tab (home)
│   │   ├── screens/
│   │   │   ├── protocol_home_screen.dart         # Today hero, next dose, schedule
│   │   │   ├── create_protocol_screen.dart       # 3-step wizard
│   │   │   └── active_protocol_detail_screen.dart # Manage / pause / end
│   │   ├── widgets/
│   │   │   ├── log_dose_sheet.dart               # Bottom sheet for logging
│   │   │   └── empty_state.dart                  # Shared empty-state tile
│   │   └── providers/
│   │       ├── protocol_provider.dart            # CRUD + dose schedule gen
│   │       └── dose_log_provider.dart            # log/skip/undo + stats
│   ├── progress/       # 📊 Progress tab
│   │   ├── screens/progress_screen.dart          # 30d adherence + weight trend
│   │   ├── widgets/log_metric_sheet.dart
│   │   └── providers/body_metric_provider.dart
│   ├── library/        # 🧪 Library tab
│   │   ├── screens/
│   │   │   ├── library_screen.dart               # Search + category filter
│   │   │   ├── peptide_detail_screen.dart        # Inline reconstitution calc
│   │   │   └── reconstitution_screen.dart        # Standalone calc (retained)
│   │   └── providers/peptide_provider.dart
│   ├── profile/        # ⚙️ You tab
│   │   ├── screens/profile_screen.dart
│   │   └── providers/settings_provider.dart
│   ├── onboarding/     # 18-screen onboarding + post-auth hard paywall
│   │   ├── screens/
│   │   │   └── onboarding_screen.dart   # PageView shell, 18 pages
│   │   └── widgets/
│   │       ├── age_gate_page.dart       # 1. 18+ age gate
│   │       ├── hook_page.dart           # 2. Emotional hook
│   │       ├── onboarding_page.dart     # Generic pages (disclaimer + value screens)
│   │       ├── social_proof_page.dart   # retained but hidden from current flow
│   │       ├── first_name_page.dart     # 4. Natural first-name capture
│   │       ├── birth_date_page.dart     # 5. Adult-only DOB capture
│   │       ├── goals_page.dart          # 6. Goal multi-select
│   │       ├── experience_page.dart     # 7. Experience level
│   │       ├── frustration_page.dart    # 8. Biggest frustration
│   │       ├── peptide_select_page.dart # 9. Peptide multi-select
│   │       ├── calculator_demo_page.dart # 10. Unit converter demo (aha moment)
│   │       ├── processing_page.dart     # 11. HUD radar processing
│   │       ├── protocol_preview_page.dart # 12. Personalised protocol card
│   │       ├── results_summary_page.dart # 13. Inputs summary + data tiles
│   │       ├── feature_showcase_page.dart # 14. Swipeable feature cards
│   │       ├── review_gate_page.dart    # 18. end-of-onboarding in_app_review prompt → auth
│   │       ├── paywall_page.dart        # Post-auth hard paywall (3 plans, countdown)
│   │       └── notification_page.dart   # (retained — not in current flow)
│   └── auth/           # Firebase authentication
├── routing/
├── services/
│   ├── database_service.dart     # Isar init + seed + clearAllUserData
│   ├── peptide_seed_data.dart    # 20 real peptides seeded on first launch
│   └── notification_service.dart # Phase 2 stub (scheduleDoseReminder / cancelAll)
├── models/                       # Isar collections
│   ├── peptide.dart              # Library row (read-only at runtime)
│   ├── protocol.dart             # Protocol + embedded ProtocolPeptide
│   ├── dose_log.dart             # Scheduled/taken/skipped doses
│   ├── body_metric.dart          # Weight + body fat + measurements
│   └── user_settings.dart        # Singleton (id == 1)
├── app_shell.dart      # Main shell with glass tab bar (Protocol / Progress / Library / You)
└── main.dart           # Entry — opens Isar, regenerates schedules, routes onboarding vs shell

assets/
├── icons/
├── images/
├── animations/
└── fonts/

docs/
├── plans/
│   ├── product-plan.md       # Full product plan
│   └── design-references.md  # Design research & reference guide
└── reference/
```

## Design System — "Clinical Cyberpunk"
- **Aesthetic**: Refined cyberpunk — sophistication over spectacle. Deus Ex, not Saints Row
- **Deep navy-black base** — `#0B0C10` background (not pure black, not neutral gray)
- **Electric cyan primary** — `#05D9E8` with glow effects for active/on-track states
- **Hot pink warning** — `#FF2A6D` for attention signals
- **Acid yellow danger** — `#FCEE0A` for expired/missed states
- **Deep purple AI** — `#7700A6` / `#BB44FF` for AI insight cards
- **Dual font strategy**: Space Grotesk (body) + JetBrains Mono (data numbers, system labels)
- **HUD-style system labels**: `SYS.PROTOCOL // ACTIVE` — monospace, tracked-out, cyan
- **Glowing borders** — buttons and active cards have neon glow halos
- **Unified design language** — identical on iOS and Android, no platform splits
- **Custom components** — no Material/Cupertino defaults for UI
- **Glassmorphism** — `BackdropFilter` + blur with cyan tinting
- **Haptic feedback** on all primary interactions
- **Sharper corners** — 12px card radius, 8px button radius (more technical feel)

## Commands
```bash
flutter run                      # Run on connected device
flutter build ios --simulator    # Build for iOS simulator
flutter build ipa                # iOS release build
flutter build appbundle          # Android release build
flutter test                     # Run tests
flutter analyze                  # Lint & analyze
firebase deploy --only firestore:rules   # Push rules after edits
```

## Firestore layout
```
users/{uid}                              # User doc (email, displayName, createdAt, lastLoginAt)
  settings/profile                       # UserSettings — onboarding flags, preferences, subscriptionState
  protocols/{protocolId}                 # Protocol (name, status, startDate, peptides[])
  doseLogs/{doseId}                      # DoseLog (scheduledAt as ISO-8601 string, denormalised peptideName)
  bodyMetrics/{entryId}                  # BodyMetric (weight, body fat, measurements, date)

peptideLibrary/{slug}                    # Shared reference peptides — read-authed, write-none
                                         # Seeded via `PeptideLibraryRepository.seedIfEmpty()` on first authed launch.
```

Security rules at `firestore.rules` — `users/{uid}/**` is owner-only, library is read-authed.

## App init order (lib/main.dart)
Essential (awaited, pre-`runApp`):
1. `WidgetsFlutterBinding.ensureInitialized()` + portrait lock + status bar style
2. `initializeFirebase()` — also enables offline persistence
3. `FlutterError.onError` → Crashlytics
4. Configure Superwall with the platform SDK key and begin authoritative subscription-status resolution
5. `AppReferSDK.configure()` — safe no-op if API key still TODO
6. `AnalyticsService().initializeIdentity()` — stable install ID stamped on Crashlytics / Analytics / Superwall / AppRefer
7. `PeptideLibraryRepository().seedIfEmpty()` — fire-and-forget
8. `runApp(PepModApp())`

Deferred (post-first-frame):
- `NotificationService.initialize()`
- ATT request path on iOS
- AppRefer configure + Facebook App Events init after ATT request path

## Auth gate flow (lib/main.dart `_AppRoot`)
1. `AuthProvider.isInitialized == false` → splash
2. User not signed in **and** onboarding not yet completed → `OnboardingScreen`
3. User not signed in → `AuthScreen` (Apple / Google / Email)
4. Signed in + genuinely completing a new onboarding version → versioned post-auth Superwall hard-paywall latch
5. Signed in + already onboarded → `AppShell` without an update-triggered hard paywall

Providers own the UID swap: every user-scoped provider has `setUid(String)` and
a `ChangeNotifierProxyProvider<AuthProvider, T>` in `PepModApp` triggers it
on auth state change. One provider instance survives sign-in / sign-out.

## Free tier gating
`SubscriptionProvider` exposes `canAddProtocol(count)` and `canAddPeptide(count)`:
- Free plan: 1 protocol, 1 peptide per protocol.
- `showSoftPaywall(ctx, source, reason)` (`features/subscription/screens/soft_paywall_sheet.dart`) registers the corresponding Superwall placement. Purchase and restore stay inside Superwall; there is no RevenueCat/native purchase fallback.
- Wired at `protocol_home_screen.dart` (create button) and `create_protocol_screen.dart` (add peptide button).

## Superwall subscriptions
- Superwall is the only runtime subscription SDK and owns purchases, restores, paywall presentation, and authoritative subscription status.
- Required placement names: `post_auth_onboarding`, `soft_gate_create_protocol`, `soft_gate_add_peptide`, and `profile_upgrade`.
- Product IDs/base plans/offers must match App Store Connect and Google Play source-of-truth rows. No app-side purchase controller forwards transactions to another provider.
- Identity is Firebase UID; safe attributes include `firebase_uid`, `install_id`, `apprefer_id`, and `subscription_tier`. Do not send peptide selections, DOB, or health free text.
- Grant Pro only when Superwall reports an active entitlement with the exact identifier `premium`. Other active entitlements do not unlock PepMod.
- A locally cached premium value is only a temporary continuity hint while Superwall status is unresolved. It prevents a previously premium user from being downgraded during startup/network uncertainty, but it never overrides an authoritative inactive Superwall readback.
- Existing onboarded users must never see a hard paywall merely because they updated the app. The post-auth hard paywall is eligible only when the current session completes genuinely new onboarding and sets the versioned paywall latch; consuming the latch is one-time and must not be synthesized from an app-version upgrade.
- Unknown, unavailable, or unconfigured Superwall state does not grant new premium access. Soft placements may fail closed, while already-onboarded users continue into the app instead of being trapped behind an update-triggered hard paywall.
- The old RevenueCat provider project and webhook are retained outside runtime only until Superwall store reporting and AppRefer attribution parity are proven. Do not restore its SDK/runtime path and do not delete the provider resources without explicit cutover approval.

## Data Architecture (Phase 1)

### Isar Collections
- `Peptide` — library entries, unique slug, seeded once on first launch (`PeptideSeedData.build()`)
- `Protocol` — user regimen with embedded `ProtocolPeptide` list + stable UUID
- `DoseLog` — one row per scheduled (or ad-hoc) dose — keys on `protocolUuid` + `protocolPeptideUuid` + `scheduledAt`
- `BodyMetric` — weight / body fat / embedded `MeasurementEntry` list
- `UserSettings` — singleton (`id == 1`)

### Provider topology (wired in `main.dart` via `MultiProvider`)
- `PeptideProvider` — read-only library w/ search + `findBySlug`
- `ProtocolProvider` — CRUD + `_generateDoseLogs` materialises the next 7 days of schedule rows on create / resume / app-open (`scheduleHorizonDays = 7`)
- `DoseLogProvider` — today + recent30, adherence% today, adherence% 30d, currentStreak, totalLogged, mutations log/skip/undo/logAdHoc
- `BodyMetricProvider` — CRUD for weight/BF/measurements
- `SettingsProvider` — reactive wrapper around the `UserSettings` singleton and onboarding/profile mutations.
- `AuthProvider.clearAppData()` — Profile reset coordinator: deletes dose logs, protocols, and body metrics in bounded server batches; cancels reminders and stale onboarding handoff state; then resets settings last while preserving Auth, subscription/reviewer flags, and the shared peptide library.

### Isar extension imports
Any file calling `.filter()`, `.sortByX()`, `.findAll()` MUST import `package:isar/isar.dart` directly — extensions are only visible when the defining package is imported in the consumer file. Providers already do this.

### Frequency schedule rules
`frequency` key on `ProtocolPeptide` drives `_isDosingDay`:
- `daily` — every day
- `eod` — every other day from start
- `twice_weekly` — Mon & Thu
- `weekly` — every 7 days from start
- `as_needed` — never auto-scheduled (log ad-hoc)

### Routing
`_AppRoot` in `main.dart` listens to `SettingsProvider`. If `settings.onboardingCompleted` is false it renders `OnboardingScreen`, else `AppShell`. Onboarding's final paywall CTA calls `SettingsProvider.completeOnboarding(...)` AND auto-creates a first protocol by matching picked peptides (case-insensitive) against the seeded library.

## Key Design Decisions
1. "Clinical Cyberpunk" aesthetic — biohacking IS cyberpunk, own it
2. One design language everywhere — brand IS the design system
3. Dual fonts: Space Grotesk (body) + JetBrains Mono (data) via google_fonts
4. Custom icons — not SF Symbols or Material Icons
5. No ripple/splash effects — custom scale animations + glow borders instead
6. Floating dark glass tab bar with cyan active indicator — signature navigation element
7. Portrait-locked — peptide tracking is a focused one-hand experience
8. Neon accents used surgically — only on actionable/status elements, never decorative

## Onboarding Flow (23 screens + auth + post-auth paywall — conversion-optimised v5)
1. Age Gate → 2. Hook → 3. Disclaimer → 4. First Name →
5. Goals → 6. Goals Reassurance → 7. Experience → 8. Frustration →
9. Confidence → 10. Confidence Reassurance → 11. Peptides →
12. Calculator Demo (aha moment) → 13. Processing (HUD radar) →
14. Protocol Preview → 15. Results Summary → 16. 60-day Roadmap →
17. Feature Showcase → 18. Notification Warm-up →
19. Value: Protocol Timeline → 20. Value: Unit Conversion →
21. Value: Progress Signals → 22. Birth Date →
23. Review Gate (`in_app_review`) → 24. Firebase Auth →
25. Hard Paywall.

Fake testimonial/social-proof cards are intentionally hidden from the current
flow. The native review request sits immediately before auth. Birth date is
deliberately late because precise DOB entry is higher-friction than the earlier
preference steps. Onboarding has a custom back button on every page after the
age gate.

Paywall narrative: the processing screen sets up the reserved protocol, then Firebase Auth happens before the new-onboarding hard paywall so Superwall/AppRefer events attach to a stable UID. Superwall remotely owns the paywall copy, current two-minute launch-offer countdown, products, restore action, and legal links.

## Key Dependencies
- `google_fonts: ^6.2.1` — Space Grotesk + JetBrains Mono
- `in_app_review: ^2.0.10` — native review prompt on the Review Gate screen

## Environment Variables
- `APPREFER_API_KEY` — AppRefer live/test API key (release builds require it).
- `GLEAP_SDK_TOKEN` — Gleap client SDK token.
- `FORCE_PREMIUM=true` — explicit internal/reviewer premium bypass; absent from normal tester and production builds.
- `ENABLE_GOOGLE_SIGN_IN=true` — exposes Google sign-in once mobile OAuth is ready.
- `SUPERWALL_IOS_API_KEY` / `SUPERWALL_ANDROID_API_KEY` — Superwall public SDK keys for the PepMod project.

## Legal
- Wellness/tracker app — NOT a medical device
- "Educational reference tool" framing
- Disclaimers on every dosing-related screen
- No disease claims, no prescriptions, no diagnosis
- 18+ age gate required
- Reconstitution calculator framed as "unit conversion tool" (Apple guideline 1.4.2)
