# PeptideOS

## Overview
Intelligent peptide protocol manager. Track doses, calculate reconstitution, manage protocols, and optimise your peptide journey with AI-powered insights.

## Tech Stack
- **Framework**: Flutter 3.41.4
- **Platform**: iOS + Android (unified design — no platform-adaptive widgets)
- **Fonts**: Space Grotesk (body) + JetBrains Mono (data) via `google_fonts`
- **Backend**: Firebase (Auth, Firestore) — Phase 2, replaces Isar. Firestore offline persistence enabled.
- **Auth**: Firebase Auth — Apple (iOS), Google, Email/password. Anonymous mode is intentionally disabled so AppRefer attribution survives cross-device.
- **Subscriptions**: RevenueCat (`purchases_flutter` 8.x), entitlement `premium`. Keys are TODO until the RC project is created.
- **Attribution**: AppRefer Flutter SDK 0.4.1 (`configure` on app start with API key + advanced matching on sign-in).
- **Ad events**: Facebook App Events + App Tracking Transparency (ATT prompt deferred to post first-frame).
- **Notifications**: `flutter_local_notifications` 18.x + `timezone` + `flutter_timezone` — real scheduling wired in Phase 2.
- **State management**: `provider` 6.1 — one ChangeNotifier per feature, UID-aware via `setUid()`.
- **Charts**: `fl_chart` 0.69
- **IDs**: `uuid` 4.5 — Firestore doc IDs + DoseLog cross-reference keys.

## Phase 2 credential placeholders (search for these before release)
All live in source code for visibility. Replace with real values once the
backing services are provisioned.
- `lib/data/services/subscription_service.dart` — `TODO_RC_IOS_KEY`, `TODO_RC_ANDROID_KEY`
- `lib/main.dart` — `APPREFER_API_KEY`, `FACEBOOK_APP_ID` (read via `--dart-define`)
- `ios/Runner/Info.plist` — `TODO_FB_APP_ID`, `TODO_FB_CLIENT_TOKEN`, `TODO_FB_URL_SCHEME`
- No TODOs for Firebase — using the pre-existing `gymstreak-labs` project (iOS + Android apps already registered).

Use `--dart-define=FORCE_PREMIUM=true` to bypass RC for testing while keys are still TODO.

## Bundle ID
- iOS: `com.gymstreaklabs.peptideOs`
- Android: `com.gymstreaklabs.peptide_os`

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
│   ├── onboarding/     # 15-screen onboarding + hard paywall
│   │   ├── screens/
│   │   │   └── onboarding_screen.dart   # PageView shell, 15 pages
│   │   └── widgets/
│   │       ├── age_gate_page.dart       # 1. 18+ age gate
│   │       ├── hook_page.dart           # 2. Emotional hook
│   │       ├── social_proof_page.dart   # 3. Testimonials + stats (NEW)
│   │       ├── onboarding_page.dart     # 4. Generic page (disclaimer uses this)
│   │       ├── goals_page.dart          # 5. Goal multi-select
│   │       ├── experience_page.dart     # 6. Experience level
│   │       ├── frustration_page.dart    # 7. Biggest frustration
│   │       ├── peptide_select_page.dart # 8. Peptide multi-select
│   │       ├── calculator_demo_page.dart # 9. Unit converter demo (aha moment)
│   │       ├── review_gate_page.dart    # 10. in_app_review prompt (NEW)
│   │       ├── processing_page.dart     # 11. HUD radar processing (NEW)
│   │       ├── protocol_preview_page.dart # 12. Personalised protocol card
│   │       ├── results_summary_page.dart # 13. Inputs summary + data tiles (NEW)
│   │       ├── feature_showcase_page.dart # 14. Swipeable feature cards
│   │       ├── paywall_page.dart        # 15. Hard paywall (3 plans, countdown)
│   │       └── notification_page.dart   # (retained — not in current flow)
│   └── auth/           # Authentication (not yet built)
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
4. `SubscriptionService.configure()` — safe no-op if RC key still TODO
5. `AppReferSDK.configure()` — safe no-op if API key still TODO
6. `AnalyticsService().initializeIdentity()` — stable install ID stamped on Crashlytics / Analytics / RC / AppRefer
7. `PeptideLibraryRepository().seedIfEmpty()` — fire-and-forget
8. `runApp(PeptideOSApp())`

Deferred (post-first-frame):
- `NotificationService.initialize()`
- Facebook App Events + ATT prompt (iOS only)

## Auth gate flow (lib/main.dart `_AppRoot`)
1. `AuthProvider.isInitialized == false` → splash
2. User not signed in **and** onboarding not yet completed → `OnboardingScreen`
3. User not signed in → `AuthScreen` (Apple / Google / Email)
4. Signed in + onboarded → `AppShell`

Providers own the UID swap: every user-scoped provider has `setUid(String)` and
a `ChangeNotifierProxyProvider<AuthProvider, T>` in `PeptideOSApp` triggers it
on auth state change. One provider instance survives sign-in / sign-out.

## Free tier gating
`SubscriptionProvider` exposes `canAddProtocol(count)` and `canAddPeptide(count)`:
- Free plan: 1 protocol, 1 peptide per protocol.
- `showSoftPaywall(ctx, source, reason)` (`features/subscription/screens/soft_paywall_sheet.dart`) presents an upgrade sheet and returns `true` on successful purchase.
- Wired at `protocol_home_screen.dart` (create button) and `create_protocol_screen.dart` (add peptide button).

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
- `SettingsProvider` — reactive wrapper around the `UserSettings` singleton, `completeOnboarding({goals, experience, frustration})`, `resetAll()` which wipes user data (preserves seeded library)

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

## Onboarding Flow (15 screens — conversion-optimised v2)
1. Age Gate → 2. Hook → 3. Social Proof → 4. Disclaimer →
5. Goals → 6. Experience → 7. Frustration → 8. Peptides →
9. Calculator Demo (aha moment) → 10. Review Gate (`in_app_review`) →
11. Processing (HUD radar, auto-advances at 100%) → 12. Protocol Preview →
13. Results Summary → 14. Feature Showcase → 15. Paywall

Notification permission is no longer requested inline — ask for it elsewhere.

Paywall narrative: the processing screen sets up "we reserved a protocol for you", then the paywall countdown ties back with `YOUR PERSONALISED PROTOCOL IS RESERVED FOR [15:00]` above the Best Value card. Hero headline: "Start your optimised protocol today".

## Key Dependencies
- `google_fonts: ^6.2.1` — Space Grotesk + JetBrains Mono
- `in_app_review: ^2.0.10` — native review prompt on the Review Gate screen

## Environment Variables
(To be filled during development)

## Legal
- Wellness/tracker app — NOT a medical device
- "Educational reference tool" framing
- Disclaimers on every dosing-related screen
- No disease claims, no prescriptions, no diagnosis
- 18+ age gate required
- Reconstitution calculator framed as "unit conversion tool" (Apple guideline 1.4.2)
