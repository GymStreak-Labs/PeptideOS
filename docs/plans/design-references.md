# PepMod — Design Reference Guide

## Design Vision
PepMod should feel like an Apple Design Award winner — modern, data-rich but never cluttered, dark-mode-first, with purposeful animations and a calming-yet-premium aesthetic. We're building a tool that handles complex medical data but presents it with the warmth and clarity of the best health apps.

---

## 0. Unified Design Language — "PepMod Design System"

PepMod has **one design language** — identical on iOS and Android. No platform-adaptive widgets, no Cupertino-on-iOS / Material-on-Android split. The app looks, feels, and behaves the same everywhere, like Oura, Calm, or Headspace.

### Why One Language
- Premium apps own their identity — the *brand* is the design language, not the platform
- Consistent user experience regardless of device
- Easier to maintain — one component library, one set of design tokens
- Stronger brand recognition

### Implementation Approach
- **All custom widgets** — no `Material` or `Cupertino` defaults for core UI
- **Custom `ThemeData`** built from our own design tokens (colours, typography, spacing, radii)
- **Custom bottom nav bar** — our own floating glass-style tab bar, not `BottomNavigationBar` or `CupertinoTabBar`
- **Custom cards, buttons, inputs, sheets** — all bespoke, matching the PepMod identity
- **Custom icon set** — consistent across both platforms (not SF Symbols, not Material Icons)
- **One font family** — Inter or a similar cross-platform geometric sans-serif (not SF Pro, which is Apple-only)
- **Platform-specific only where mandatory**: status bar style, notification channels, health data APIs (HealthKit / Health Connect), camera permissions. Nothing the user sees differs.

---

## 1. Apple Design Award Winners — Key Lessons

### Gentler Streak (2024 ADA Winner — Inclusivity)
**What makes it great:**
- **Activity Path** — a single visual that reframes fitness data into "in range / above / below" zones. Simplifies complexity into an intuitive glanceable format
- **Mascot-driven UX** (Yorhart) — abstract character that provides emotional connection without being childish. Creates a "soft environment" that feels pleasant and frictionless
- **Perceived Exertion slider** — enriches objective data with personal context, featuring micro-animations. Brilliant for PepMod symptom logging
- **Non-judgmental tone** — every piece of copy validates the user's effort. No guilt, no comparison
- **Warm color palette** — soft blues and greens, soothing tones. Smooth transitions between screens
- **Monthly Summary** — focuses on personal progress, not comparison to others
- **Revenue**: ~$55K/month, 4.7 stars, soft paywall with 50% OFF timer after onboarding

**Steal for PepMod:**
- Activity Path concept → "Protocol Health" visualization showing adherence zones
- Perceived Exertion slider → daily symptom logging with micro-animations
- Warm, encouraging tone for AI mentor copy
- Mascot possibility for the AI mentor personality

### Any Distance (2023 ADA Winner — Visuals & Graphics)
**What makes it great:**
- **Data as Art** — transforms cold metrics into beautiful, shareable formats
- **Metal-rendered gradient backgrounds** — fluid, dynamic visual aesthetic
- **Oval brand mask** — simple shape becomes a recognizable brand element used everywhere
- **Shareable cards** — combine photos + routes + metrics in gorgeous layouts
- **SF Symbols** used extensively (called "the single greatest contribution to design Apple has ever made")
- **Collectible medals** — time-based and achievement-driven engagement

**Steal for PepMod:**
- Data-as-art approach for progress visualizations and weekly reports
- Metal/shader-style gradient backgrounds for dashboard
- Shareable protocol summary cards (for sharing stacks with friends)
- Achievement/milestone collectibles with beautiful design

### CapWords (2025 ADA Winner — Delight & Fun)
**What makes it great:**
- **Micro-animations as invisible loading** — instead of spinners, engaging animations play while backend processes. Transforms waiting into entertainment
- **Multi-sensory feedback** — visual + audio + haptic for every interaction
- **Physical metaphor** (sticker peeling) — grounds digital interaction in real-world familiarity
- **Purpose-aligned delight** — every animation serves the core purpose, nothing is decorative fluff

**Steal for PepMod:**
- Micro-animations during reconstitution calculation (syringe filling animation while computing)
- Multi-sensory dose logging (satisfying haptic + subtle sound when marking dose complete)
- Physical metaphors: syringe filling, vial liquid levels, injection site body map interactions

### Waterllama (2022 ADA Finalist — Delight & Fun)
**What makes it great:**
- **Gamified tracking** — 45+ collectible animal characters that fill up as you hydrate
- **500+ illustrations** — makes mundane tracking joyful
- **Liquid Glass integration** (updated for iOS 26) — soft transparency, smooth reflections
- **Core interaction satisfaction** — logging a drink visually fills the character. Instant gratification

**Steal for PepMod:**
- Visual feedback on dose logging (vial level decreasing, adherence ring filling)
- Satisfying core interaction for the most frequent action (marking dose as taken)

### Streaks (ADA Winner — multiple years)
**What makes it great:**
- **Bold simplicity** — big buttons, tap-and-hold to complete
- **78 color themes** — deep customization without complexity
- **600+ task icons** — visual identity for each habit
- **Gets out of the way** — minimal UI, maximum focus

**Steal for PepMod:**
- One-tap dose completion (tap and hold = satisfying)
- Colour themes for personalization
- Minimal chrome, maximum content

---

## 2. Premium Health App Design Patterns

### Oura Ring (Gold standard for dark mode health data)
- **Color-as-signal system** — colors represent body states, not decoration. Immediate visual feedback
- **"One Big Thing"** — Today tab surfaces the single most important insight, cutting through data clutter
- **Personalized baselines** — everything is relative to YOUR normal, not population averages
- **Long-term trend graphs** — slow-moving metrics visualized to show trajectory
- **Vitals quick-glance** — core health pillars at a glance, anchored to personal baselines

**Steal for PepMod:**
- Color-coded protocol status (on track = green glow, missed dose = amber, overdue = red)
- "One Big Thing" for today's dashboard — next dose + most important insight
- Personal baseline tracking for symptoms (energy, pain relative to YOUR normal)
- Dark, premium feel with strategic color accents

---

## 3. Glassmorphism & Depth — Inspired by Liquid Glass

Apple's iOS 26 "Liquid Glass" introduced translucency, depth, and floating controls as a major design trend. We take the *principles* and build our own implementation in Flutter — identical on both platforms.

### Core Principles
- **Translucent surfaces** — `BackdropFilter` + `ImageFilter.blur` for frosted glass panels
- **Dynamic transformation** — controls morph to focus attention on content
- **Tab bar recedes** when scrolling to maximize content space
- **Floating controls** over content — `Stack` + `Positioned` layering
- **Warm translucent glows** on accent colors — `BoxShadow` with accent at low opacity
- **Bottom-first navigation** — all controls within thumb reach

### Inspiration (design intent, not platform implementation)
- **AllTrails**: Hero image collapses into compact glass nav bar
- **CARROT Weather**: Reduced tab count for cleaner experience
- **LazyFit**: Floating playback controls over exercise footage — canvas-first design
- **FotMob**: Toolbar buttons adapt tint to content colour palettes
- **Le Monde**: Fluid translucent nav bars; floating tab bar recedes with scroll

### How PepMod Uses Glass & Depth
- Custom floating bottom tab bar with frosted glass effect
- Protocol dashboard: content fills the screen, controls float over it
- Reconstitution calculator: glass-style input panels over syringe visualization
- Body map: floating annotation cards at injection sites
- Shrinking headers on scroll to maximize data visibility

---

## 4. Dark Mode Design System (PepMod Default)

### Background Hierarchy
| Surface | Color | Usage |
|---------|-------|-------|
| Primary BG | #121212 → #1A1A1A | Main background |
| Card/Surface | #1E1E1E → #2A2A2A | Cards, bottom sheets |
| Elevated | #2D2D2D → #333333 | Modals, popovers |
| Input fields | #252525 | Text inputs, search bars |

### Text Hierarchy
| Level | Color | Usage |
|-------|-------|-------|
| Primary | #FFFFFF / #F5F5F5 | Titles, key numbers |
| Secondary | #E0E0E0 | Body text, labels |
| Tertiary | #B0B0B0 → #C0C0C0 | Captions, hints |
| Disabled | #666666 | Inactive elements |

### Accent Colors (De-saturated for dark mode, 20-30% less saturation)
| Purpose | Color | Usage |
|---------|-------|-------|
| Primary accent | #64B5F6 (soft blue) | Primary actions, selected states |
| Success/On-track | #81C784 (soft green) | Doses taken, adherence good |
| Warning | #FFB74D (soft amber) | Approaching expiry, missed timing |
| Danger | #E57373 (soft red) | Missed doses, expired vials |
| AI/Insight | #CE93D8 (soft purple) | AI insights, weekly report |
| Peptide | #4DD0E1 (soft cyan) | Peptide-specific elements |

### Chart/Data Visualization
- **Gridlines**: #3A3A3A to #4A4A4A (subtle, never compete with data)
- **Axis lines**: #5A5A5A
- **Axis labels**: #C0C0C0
- **Line stroke**: 2-3px (thicker than light mode)
- **Bar fills**: 80-90% opacity with #5A5A5A outlines
- **Never use pure black** (#000000) backgrounds — always deep gray
- **Direct labels on data points** — don't rely solely on legends

---

## 5. Typography Strategy

### Font: Inter (cross-platform, Google Fonts, free)
Inter is a geometric sans-serif designed specifically for screens. Clean, modern, excellent number rendering, wide weight range. Identical on iOS and Android.

Alternative options: Plus Jakarta Sans (warmer), Outfit (rounder/friendlier), DM Sans (compact).

### Type Scale
- **Hero numbers** (doses, stats): Inter, weight 700-800, 32-40pt
- **Section headers**: Inter, semibold (600), 20-22pt
- **Body text**: Inter, regular (400), 15-17pt
- **Captions/labels**: Inter, regular/medium, 12-13pt
- **Tab labels**: Inter, medium (500), 10-11pt
- **Disclaimer text**: Inter, regular, 11pt, tertiary colour

### Number Styling
- Dose amounts: Large, bold, primary colour (like Gentler Streak's "big bold numbers")
- Units (mcg, ml, IU): Smaller, secondary colour, beside the number
- Countdown/timers: Inter with tabular figures (`fontFeatures: [FontFeature.tabularFigures()]`) for consistent width

---

## 6. Animation & Interaction Principles

### Core Philosophy (from ADA winners)
1. **Every animation serves a purpose** — no decorative motion
2. **Micro-animations as invisible loading** (CapWords) — engage during processing
3. **Physical metaphors** — syringe filling, liquid levels, body map touch responses
4. **Multi-sensory feedback** — haptic + visual + (optional) audio for key actions

### Key Animations for PepMod
| Action | Animation | Duration |
|--------|-----------|----------|
| Mark dose taken | Satisfying pulse + haptic + checkmark morph | 300ms |
| Vial level decrease | Smooth liquid level animation | 500ms |
| Reconstitution calc | Syringe fills with calculated amount | 400ms |
| Injection site marked | Ripple from tap point on body map | 250ms |
| Weekly report arrives | Card slides up with gentle bounce | 350ms |
| AI insight appears | Subtle glow + fade-in | 400ms |
| Protocol phase change | Progress bar morphs to next phase | 600ms |
| Streak milestone | Celebratory particles + haptic | 800ms |

### Haptic Patterns
- **Dose logged**: `.success` (sharp, satisfying)
- **Vial scanned**: `.medium` impact
- **Streak achieved**: `.notification` pattern
- **Warning/expiry**: `.warning` vibration
- **Injection site tap**: `.light` impact

---

## 7. Navigation Pattern

### 4-Tab Bottom Navigation (Custom floating glass bar)
```
💉 Protocol    📊 Progress    🧪 Library    ⚙️ You
```

- Custom floating tab bar with frosted glass backdrop
- Shrinks on scroll, expands on scroll-up
- Active tab: filled icon + primary accent glow
- Inactive: outline icon + tertiary text colour
- Semi-transparent background, content scrolls behind it
- Custom icons (not SF Symbols, not Material Icons) — consistent set from Phosphor, Lucide, or bespoke

### Screen Transitions
- **Forward navigation**: Shared axis / slide-in (consistent both platforms)
- **Modal sheets**: Custom bottom sheet with glass background + drag handle
- **Tab switching**: Cross-fade (not slide)
- **Drill-down in lists**: Push with collapsing header → compact title

---

## 8. Component Design Patterns

### Cards (Primary content container)
- Background: #1E1E1E with 1px border at 8% white opacity
- Corner radius: 16pt
- Padding: 16pt
- Shadow: None (dark mode) — use border instead
- Hover/press: lighten to #252525

### Dose Card (Most important component)
```
┌─────────────────────────────────┐
│ 💉 BPC-157          8:00 AM    │
│                                 │
│    ██████ 250 mcg ██████       │
│    Subcutaneous · Left abdomen  │
│                                 │
│   [  Mark as Taken  ✓  ]       │
│                                 │
│ Syringe: 10 units @ 0.5ml      │
└─────────────────────────────────┘
```
- Large dose number (250 mcg) as hero element
- Subtle syringe diagram showing fill level
- One-tap completion button (large, thumb-friendly)
- Color-coded border glow: upcoming (blue), due now (green pulse), overdue (amber)

### Syringe Visualization
- Realistic but stylized syringe diagram
- Graduated markings with highlighted fill level
- Animated fill on calculation
- Color: primary accent for filled portion, dark gray for empty

### Body Map
- Anatomical outline, dark theme with subtle muscle definition
- Tap to mark injection site — ripple animation
- Color-coded dots for recent injection sites (green = healed, amber = recent, red = too soon)
- Rotation suggestion based on history

### AI Insight Card
- Subtle purple (#CE93D8) left border or glow
- "AI" badge in top-right
- Warm, conversational copy
- "Not medical advice" disclaimer in tertiary text at bottom
- Expandable for more detail

---

## 9. Onboarding Design (Gentler Streak inspired)
- **Warm-up screens** before system permission prompts
- Explain VALUE of health data before asking for health access (HealthKit on iOS, Health Connect on Android — the only platform-specific divergence, hidden behind a single API)
- Progress indicator (dots or thin bar, not numbered steps)
- Large illustrations/animations per step
- Skip option always visible but not prominent
- Build investment before paywall (they've set up their protocol = sunk cost)

---

## 10. Reference Apps to Study

| App | What to Study | Platform |
|-----|--------------|----------|
| **Gentler Streak** | Warmth, data visualization, encouraging tone | iOS |
| **Any Distance** | Data-as-art, shareable cards, gradient aesthetics | iOS |
| **Oura Ring** | Dark mode excellence, health data hierarchy, "One Big Thing" | iOS |
| **Waterllama** | Gamification, satisfying core interaction, Liquid Glass | iOS |
| **Streaks** | Simplicity, one-tap actions, bold minimalism | iOS |
| **CapWords** | Micro-animations, multi-sensory feedback, delight | iOS |
| **Shotsy** | GLP-1 competitor, medication level charts, Apple Health | iOS |
| **CARROT Weather** | Personality in data, dark mode, humor | iOS |
| **Apple Health** | Data organization, chart patterns, native feel | iOS |
| **Calm** | Premium dark aesthetic, calming UX, subscription flow | iOS |

---

## 11. Key Design Principles Summary

1. **One design, every device** — singular custom design language. PepMod looks identical on iOS and Android. The brand IS the design system
2. **Dark-mode-first** — design in dark mode, adapt to light. Premium, calming, easy on eyes during early-morning/late-night dose times
3. **Data as story, not spreadsheet** — every number needs context ("Your pain dropped 40% since starting BPC-157" not "Pain: 2/5")
4. **One Big Thing** — dashboard shows what matters NOW, not everything at once
5. **Satisfying core loop** — marking a dose as taken should feel GOOD (haptic + visual + progress)
6. **Physical metaphors** — syringes fill, liquids flow, body maps respond to touch
7. **Calming premium** — not clinical, not techy, not gym-bro. Think Oura meets Calm
8. **Progressive disclosure** — simple surface, depth available on tap
9. **Accessibility from day one** — scalable text, screen readers, high contrast mode
10. **Purposeful animation** — every motion serves a function, nothing is decorative
