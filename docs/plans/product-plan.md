# PepMod — Product Plan

## App Name
**PepMod** — "Your peptide protocol, intelligently managed."

## Business
GymStreak Labs

## Monetisation
Premium only — no free tier.
- Weekly: $9.99
- Annual: $59.99
- Hard paywall after onboarding quiz + protocol builder demo

## Target Audience
- Biohackers / longevity enthusiasts (Silicon Valley crowd)
- Bodybuilders / fitness community
- Semaglutide/tirzepatide users (weight loss — massive market)
- Anti-aging community
- Injury recovery (BPC-157 users)
- Anyone prescribed peptides through telehealth

## Market Context
- $140B peptide therapeutics market (2025), growing to $295B by 2033
- Semaglutide alone: $29.3B revenue in 2024
- 50M+ TikTok views on peptide content
- 14 of 19 restricted peptides re-legalized in Feb 2026 (RFK Jr.)
- Grey-market imports from China: $328M in 2025
- FDA found 40% of online products have incorrect dosages
- 8+ competitor apps already launched — all basic trackers, no clear winner

## Why NOW
- 14 peptides just re-legalized → massive influx of new users needing guidance
- Existing apps are new and basic — no clear winner
- 40% contamination rate → people want a trusted source
- Telehealth peptide prescriptions exploding
- Audience is affluent and willing to pay

---

## Core Features

### 1. Smart Reconstitution Calculator (the #1 pain point)
- Scan vial label (camera) → auto-detect peptide type + mg
- Select BAC water volume → shows exact syringe units with visual syringe diagram
- Reverse calculator: "I want 250mcg per dose" → tells how much BAC water to add
- Colour-coded safety warnings if dose seems abnormal
- Visual step-by-step reconstitution guide
- Foolproof — eliminates the terrifying math that causes 10x overdoses

### 2. Protocol Builder (the killer feature)
- Library of community protocols for 50+ peptides
- Drag-and-drop stack builder — combine peptides, set frequencies, titration phases
- AI checks for known interactions: "BPC-157 and TB-500 are commonly stacked, but X with Y may reduce absorption"
- Three-phase support: titration up → maintenance → taper down
- Import/share protocols with other users
- User-created — the app never prescribes, users input their own protocols

### 3. Intelligent Scheduling
- Understands half-lives, optimal timing, food interactions
- "Take BPC-157 on empty stomach, 30 min before breakfast"
- Injection site rotation with interactive body map
- Titration auto-adjustment per protocol phase
- Discreet push notifications (no peptide names in notification text)

### 4. Progress Tracking with AI Insights
- Log symptoms, energy, sleep, pain levels, body composition
- AI correlates protocol changes with outcome changes
- "Your joint pain dropped 40% in the 2 weeks since starting BPC-157"
- Before/after photo comparisons (body comp, skin, hair)
- Blood work integration — upload labs, track biomarkers over time
- Weekly insight report: trends, patterns, suggested focus

### 5. Vial Inventory Management
- Track doses remaining per vial
- Expiration alerts (reconstituted peptides lose potency fast — typically 28 days)
- Cost-per-dose calculator
- Reorder reminders
- Storage guidelines per peptide

### 6. Education Hub
- 50+ peptide profiles: mechanism, evidence level, dosing ranges, side effects, stacking compatibility
- Evidence ratings: FDA Approved / Clinical Trials / Animal Studies / Anecdotal
- Honest — not hype, not fear
- Video guides: how to reconstitute, inject, store
- Sourced from published research, not influencer claims

---

## App Structure (4 Tabs)

### 💉 Protocol (Home)
- Active protocol at a glance — today's doses, next up, completion status
- Quick "mark as taken" for each dose
- Syringe visual showing exact units to draw
- Injection site body map (tap to mark where you injected)

### 📊 Progress
- Symptom/wellness daily log
- AI insight cards
- Body composition photos (timeline)
- Blood work biomarker charts
- Weekly report (drops Sunday)

### 🧪 Library
- Peptide database (50+ profiles)
- Community protocol templates
- Reconstitution calculator (standalone access)
- Educational content + video guides

### ⚙️ You
- Vial inventory
- Subscription/settings
- Data export
- Share protocol
- Support

---

## Onboarding Flow

1. **"What are you using peptides for?"** — multi-select: recovery, weight loss, anti-aging, muscle growth, cognitive, immune, other
2. **"How experienced are you?"** — first time / some experience / advanced
3. **"What peptides are you currently using?"** — search/select from database
4. **Protocol setup** — guided walk-through of their current (or desired) protocol
5. **Reconstitution demo** — show the calculator in action with their peptides
6. **Authentication** — create/sign in before monetisation so attribution and purchase events attach to a stable Firebase UID
7. **Paywall** — by this point they've invested 3 minutes of personal context and RevenueCat/AppRefer can attribute the purchase cleanly

---

## Anti-Churn Mechanisms

### 1. Accumulating AI Mentor
The longer they use it, the smarter the insights get. By month 3, the AI knows their patterns, triggers, and responses. Irreplaceable.

### 2. Protocol History
Complete record of every protocol they've run, every dose they've taken, every outcome they've tracked. Cancelling means losing their entire peptide journey history.

### 3. Weekly Insight Report
Personalised trends, pattern detection, correlations. Active subscription value — you're paying for analysis of your own data, not static content.

### 4. Vial Tracking + Expiration Alerts
Practical daily utility — if you're actively using peptides, you need this. The moment you reconstitute a vial, you need to know when it expires.

### 5. Community Protocols
Access to shared protocols from other users. Leave the app, lose access to the protocol library.

---

## Gamification (Simple)

1. **Adherence score** — % of doses taken on time this week/month
2. **Streak** — consecutive days of protocol adherence
3. **Protocol completion** — progress bar through titration → maintenance → taper phases
4. **Milestones** — "First week complete", "First vial finished", "90 days consistent"

---

## Legal Protection Framework

### App Store Classification
- **Category**: Health & Fitness (NOT Medical)
- **NOT a medical device** — wellness tracker only
- **Apple guideline 1.4.1 compliant**: no diagnosis, no treatment recommendations
- **Google Health Content Policy compliant**: declaration form completed, privacy policy posted

### Disclaimers (mandatory, on every relevant screen)
- Onboarding: "This app is for tracking and educational purposes only. It does not provide medical advice, diagnosis, or treatment."
- Every dose reminder: "Always follow your healthcare provider's instructions"
- Protocol builder: "User-created protocols. Consult a qualified healthcare provider before starting any peptide regimen."
- AI insights: "AI-generated insight based on your logged data. Not medical advice."
- Education hub: "For informational purposes only. Evidence ratings reflect published research."

### Data & Privacy
- Health data encrypted at rest and in transit
- Never sell health data to third parties
- GDPR-compliant data deletion
- Clear privacy policy in App Store listing
- 18+ age gate

### Framing (critical)
- TRACKER, not ADVISOR
- "Track your protocol" not "We recommend this protocol"
- "Protocol library" not "Treatment plans"
- "Education hub" not "Medical guidance"
- Users INPUT their protocols — app never prescribes

### Terms of Service
- Comprehensive liability limitation
- "Not a substitute for professional medical advice"
- Indemnification clause
- Age restriction (18+)

---

## Tech Architecture

### Frontend: Flutter
- Cross-platform iOS + Android
- Same tech stack as GymStreak/GymLevels — team expertise

### Backend: Firebase
- **Auth**: Firebase Auth (email + Google + Apple sign-in)
- **Database**: Firestore (users, protocols, doses, vials, symptoms, bloodwork)
- **Push**: Firebase Cloud Messaging (discreet dose reminders)
- **Functions**: Cloud Functions for AI processing, weekly report generation
- **Analytics**: Firebase Analytics + Crashlytics

### AI Layer
- Claude API for intelligent mentor/insights
- Runs server-side via Cloud Functions (not on-device)
- Builds user model from: journal entries, dose logs, symptom logs, blood work
- Generates: weekly reports, pattern detection, correlations
- Guardrails: never prescribes, always frames as correlations

### Subscriptions: RevenueCat
- Weekly $9.99, Annual $59.99
- Hard paywall after onboarding
- Trial: none (the onboarding IS the demo)

### Data Model (Firestore)
```
users/{uid}
  profile: { name, age, experience_level, goals }
  subscription: { plan, expiry, rc_id }

users/{uid}/protocols/{protocolId}
  name, status (active/completed/paused)
  peptides: [{ name, dose_mcg, frequency, route, timing }]
  phases: [{ name, duration, dose_adjustments }]

users/{uid}/doses/{doseId}
  protocol_id, peptide, dose_mcg, timestamp, injection_site, taken (bool)

users/{uid}/vials/{vialId}
  peptide, mg_total, reconstitution_ml, doses_remaining, reconstituted_date, expires_date

users/{uid}/symptoms/{date}
  energy (1-5), sleep (1-5), pain (1-5), mood (1-5), custom_fields

users/{uid}/bloodwork/{testId}
  date, markers: { testosterone, IGF-1, CRP, ... }

peptides/{peptideId}  (global collection)
  name, aliases, mechanism, evidence_level, dosing_ranges, side_effects, interactions, half_life, storage
```

---

## Implementation Phases

### Phase 1: MVP (Weeks 1-3)
- Reconstitution calculator (visual, foolproof)
- Basic protocol builder (single peptide, simple schedule)
- Dose tracking with reminders
- Injection site body map
- 20 peptide profiles in education hub
- Onboarding flow + hard paywall
- RevenueCat integration
- Disclaimers everywhere

### Phase 2: Intelligence (Weeks 4-5)
- Symptom/wellness daily logging
- AI weekly insight reports (Claude API)
- Progress charts and trends
- Multi-peptide protocol stacking
- Titration phase support

### Phase 3: Complete (Weeks 6-8)
- Vial inventory management
- Blood work upload and tracking
- Before/after photo timeline
- Community protocol sharing
- 50+ peptide profiles
- Video education content

### Phase 4: Growth (Weeks 9+)
- Referral system
- Protocol marketplace
- Telehealth provider directory (partnerships)
- Apple Watch complications for dose reminders
- Widget for home screen

---

## Competitive Advantages Over Existing Apps

| Feature | PepTracker | SHOTLOG | PeptIQ | PepMod |
|---------|-----------|---------|--------|-----------|
| Reconstitution calc | Basic | Yes | Yes | **Visual + camera scan + reverse calc** |
| Protocol builder | No | Basic | No | **Drag-drop + stacks + phases + AI checks** |
| AI insights | No | No | Basic | **Accumulating mentor + weekly reports** |
| Injection site map | No | No | No | **Interactive body map** |
| Vial tracking | No | Yes | No | **With expiration alerts** |
| Blood work | No | No | No | **Upload + biomarker charts** |
| Evidence ratings | No | No | Yes | **Honest ratings + sourced** |
| Community protocols | No | No | No | **Share + import** |

---

## Key Metrics to Track
- DAU/MAU ratio (target: >40% = strong daily habit)
- Doses logged per user per week
- Protocol completion rate
- Reconstitution calculator usage
- Weekly report open rate
- Churn rate by month (target: <8% monthly after month 3)
- Revenue per user
- App Store rating (target: 4.7+)

---

## Features Borrowed from Shotsy (Market Leader)

Shotsy is the #1 GLP-1 tracker (~1M downloads, $2.25M raised, $49.99/year). These features are proven:

### Adopted Features
1. **Estimated Medication Levels Chart** — visualise drug concentration curve based on half-life. Extended to ALL peptides in stack, not just GLP-1.
2. **Metric Trends Colour-Coded by Dosage** — see which dose changes correlate with outcome changes. Extended to all tracked metrics (pain, energy, sleep, body comp).
3. **Apple Health Auto-Import** — weight, calories, protein, water pulled automatically. Zero manual entry.
4. **PDF Export for Healthcare Providers** — shareable protocol history + progress report for doctor visits.
5. **Single-Tap Dose Logging** — one tap to mark a dose as taken. Zero friction daily action.
6. **Home Screen Widgets** — next dose countdown, estimated levels, adherence streak.
7. **Multi-Route Support** — oral, subcutaneous, intramuscular, nasal. Not just injections.
8. **Maintenance Mode** — explicit support for transitioning to maintenance dose (maps to our taper phase).

### Our Differentiators vs Shotsy
| Feature | Shotsy | PepMod |
|---------|--------|-----------|
| Scope | GLP-1 only | All 50+ peptides |
| Reconstitution | No (pre-filled pens only) | Visual calculator + camera scan |
| Stacking | No | Multi-peptide protocol builder |
| AI Insights | Basic charts | Accumulating mentor + weekly reports |
| Community | No | Shared protocols |
| Education | No | 50+ profiles with evidence ratings |
| Vial Inventory | No | Tracking + expiration alerts |
| Blood Work | No | Upload + biomarker charts |
| Injection Map | Basic | Interactive body map |

---

## Onboarding section moved to docs/plans/onboarding.md for detailed reference.


---

## App Store Compliance Checklist (Rejection Prevention)

Based on research of real rejection reasons from Apple Developer Forums and health app guidelines.

### Critical: Guideline 1.4.2 — Drug Dosage Calculators
Apple requires dose calculators come from pharma/hospital/university/FDA. Our calculator is framed as a "unit conversion tool" that does arithmetic (mg → mcg → syringe units). User inputs ALL values. App never determines or recommends dosages.

### Submission Checklist
1. Calculator framed as "unit conversion tool" not "dosage calculator"
2. Calculator disclaimer on-screen: "Verify with healthcare provider"
3. No medical claims anywhere in app or metadata
4. Protocol templates labelled "community-reported" not "recommended"
5. AI insights labelled "AI-generated, not medical advice"
6. Evidence ratings cite sources factually (e.g., "3 animal studies, 0 human RCTs")
7. Privacy consent before health data collection
8. Health data encrypted, never used for ads
9. HealthKit data stays on-device
10. App Privacy label 100% accurate
11. 18+ age gate as first screen
12. Medical disclaimer in onboarding
13. "Not medical advice" in App Store description
14. "Consult healthcare provider" in App Store description
15. AI features disclosed in app description
16. Subscription value clearly described on paywall
17. App Review Notes: "educational tracker, not medical device, unit conversion not dosage calculation"
