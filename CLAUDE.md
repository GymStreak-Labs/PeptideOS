# PeptideOS

## Overview
Intelligent peptide protocol manager. Track doses, calculate reconstitution, manage protocols, and optimise your peptide journey with AI-powered insights.

## Tech Stack
- **Framework**: Flutter 3.41.4
- **Platform**: iOS + Android (unified design — no platform-adaptive widgets)
- **Font**: Inter via `google_fonts` package
- **Backend**: Firebase (Auth, Firestore, Cloud Functions, FCM) — not yet integrated
- **AI**: Claude API for the intelligent mentor — not yet integrated
- **Subscriptions**: RevenueCat — not yet integrated
- **Analytics**: Firebase Analytics + Crashlytics — not yet integrated

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
│   │   ├── widgets/
│   │   ├── models/
│   │   └── providers/
│   ├── progress/       # 📊 Progress tab
│   ├── library/        # 🧪 Library tab
│   ├── profile/        # ⚙️ You tab
│   ├── onboarding/     # Onboarding flow (not yet built)
│   └── auth/           # Authentication (not yet built)
├── routing/
├── services/
├── models/
├── app_shell.dart      # Main shell with glass tab bar
└── main.dart           # Entry point

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

## Design System
- **Dark-mode-first** — `#121212` background, never pure black
- **Unified design language** — identical on iOS and Android, no platform splits
- **Custom components** — no Material/Cupertino defaults for UI
- **Accent colours**: Primary `#64B5F6`, Success `#81C784`, Warning `#FFB74D`, Danger `#E57373`, AI `#CE93D8`, Peptide `#4DD0E1`
- **Glassmorphism** — `BackdropFilter` + blur for floating surfaces
- **Haptic feedback** on all primary interactions
- **Animation tokens** defined in `durations.dart` — purposeful, not decorative

## Commands
```bash
flutter run                      # Run on connected device
flutter build ios --simulator    # Build for iOS simulator
flutter build ipa                # iOS release build
flutter build appbundle          # Android release build
flutter test                     # Run tests
flutter analyze                  # Lint & analyze
```

## Key Design Decisions
1. One design language everywhere — brand IS the design system
2. Inter font (google_fonts) — not SF Pro (Apple-only)
3. Custom icons — not SF Symbols or Material Icons
4. No ripple/splash effects — custom press animations instead
5. Floating glass tab bar — signature navigation element
6. Portrait-locked — peptide tracking is a focused one-hand experience

## Environment Variables
(To be filled during development)

## Legal
- Wellness/tracker app — NOT a medical device
- "Educational reference tool" framing
- Disclaimers on every dosing-related screen
- No disease claims, no prescriptions, no diagnosis
- 18+ age gate required
- Reconstitution calculator framed as "unit conversion tool" (Apple guideline 1.4.2)
