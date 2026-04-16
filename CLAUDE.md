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
```

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
