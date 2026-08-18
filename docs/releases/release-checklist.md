# PepMod Release Checklist

Standing pre-release checks for every PepMod release. Version-specific notes
live in `docs/releases/<version>.md`; this file is the recurring gate.

## Paywall / offer alignment (MANDATORY)

The paywall renders prices and free-trial copy only from store-derived data
(`PaywallPlanPrice` built from RevenueCat `StoreProduct`s;
`freeTrialDaysFromIntroductoryPrice` in
`lib/features/subscription/paywall_offer_state.dart`). That protects the app
from showing a stale promise, but nothing in the app can verify what the
stores and ad creatives claim. Before each release, confirm ALL of these say
the exact same price, discount, and trial:

- [ ] App Store Connect subscription prices and introductory offers
      (per-territory) match the intended offer.
- [ ] Google Play Console base plans and offers match the same numbers.
- [ ] RevenueCat offerings/packages (`default` and `special_offer`) point at
      the products carrying those prices, and the
      `show_special_offer_on_subscription_screen` / `special_offering`
      metadata is set as intended.
- [ ] The free trial length configured on the stores matches what marketing
      claims. The app only shows a trial badge/CTA when the store product
      actually carries a zero-price introductory offer — if creatives promise
      "3-day free trial", the store offer must actually be 3 days, or the
      creative must change.
- [ ] Ad creatives (Meta/TikTok), App Store screenshots, and store listing
      text quote the same price, discount percentage, and trial length as the
      live store configuration. No creative may quote a discount the paywall
      cannot show.
- [ ] Run `flutter test test/paywall_offer_state_test.dart` — guardrails that
      trial copy stays store-derived in every locale.

## Peptide library seed version

The bundled reference catalogue is versioned
(`PeptideSeedData.seedVersion` in `lib/services/peptide_seed_data.dart`).

How it works:

- On launch, `PeptideLibraryRepository.ensureSeeded()` compares the locally
  stored marker (`pepmod_library_seed_version` in SharedPreferences) against
  the bundled version. If the bundle is newer it writes only the **missing**
  slugs to `peptideLibrary/{slug}` — existing remote documents are never
  overwritten, so remote/admin edits always win.
- Production Firestore rules deny client writes to the library. That is fine:
  `watchAll()`/`fetchAllOnce()` merge the bundled seed underneath remote
  data, so users see new bundled entries immediately regardless of write
  permissions. The version marker still advances so the denied write is not
  retried every launch.

When adding library entries:

- [ ] Bump `PeptideSeedData.seedVersion` and record the change in its doc
      comment history.
- [ ] New entries must stay neutral: no invented default dose, frequency, or
      cycle for compounds without established published protocols
      (`defaultDoseMcg: 0`, blank `defaultFrequency`,
      `hasProtocolDefaults: false`). Investigational entries also set
      `isInvestigational: true` and must not auto-create onboarding protocols.
- [ ] Never ship a preset for vendor blend marketing names (KLOW, GLOW,
      Wolverine, …) — compositions vary by vendor; users enter their own
      vial contents via custom compounds / blend vials.
- [ ] Add localized detail content for every new slug in
      `lib/features/library/utils/localized_peptide_content.dart` plus all 9
      ARB catalogs.
- [ ] Run `flutter test test/peptide_library_seed_version_test.dart`.

Existing remote documents are not overwritten by seed reconciliation. When
changing safety metadata on an existing slug, apply an explicit admin migration
after review. Retatrutide seed v3 requires these fields on
`peptideLibrary/retatrutide` (the client also fails safe by slug until then):

```json
{
  "isInvestigational": true,
  "hasProtocolDefaults": false,
  "defaultDoseMcg": 0,
  "defaultFrequency": "",
  "typicalCycleWeeks": 0,
  "typicalDose": "No approved dosing regimen. Trial amounts are study references, not instructions for use."
}
```

## Localization

- [ ] All 9 ARB catalogs (`en`, `de`, `es`, `fr`, `it`, `ja`, `ko`, `pt`,
      `pt_BR`) have identical key sets; run `flutter gen-l10n` and commit the
      generated files.
- [ ] `flutter test test/localization_catalog_quality_test.dart` and the
      multi-locale suites pass.

## Manual test plan (support-audit surfaces)

Run on a real device (one iOS, one Android) before submitting:

1. **Twice-weekly schedules**
   - Create a protocol with a 2x-per-week peptide: the editor must show a
     two-day weekday selection prefilled Mon/Thu, block saving unless exactly
     two days are chosen, and the planner must show doses on the chosen days.
   - Open an existing (pre-update) twice-weekly protocol: schedule must still
     be Mon/Thu; editing and saving must not shift any day.
2. **Reminders blocked recovery**
   - Enable dose reminders, deny the OS permission: a persistent "Reminders
     are blocked" card must appear on Protocol home and Profile with an Open
     Settings button that lands on the app's notification settings.
   - Re-enable notifications in system settings and return to the app: the
     banner must disappear and scheduled reminders must resume without
     re-toggling anything.
3. **Paywall**
   - With the production offering: prices must match the store, the trial
     badge/CTA must appear only if the store product has a free trial, and
     the badge must show the store's trial length.
4. **Library additions**
   - Search Testosterone, Glutathione, Kisspeptin-10, SLU-PP-332: entries
     exist, show no suggested dose, and their detail page shows the
     reference-only note.
5. **Custom compounds / blends**
   - Search "KLOW" (or GLOW/Wolverine) in Library: no invented preset; the
     empty state offers "Create custom compound" and the editor opens with
     the search term prefilled; the blend guidance hint is shown.
   - In protocol creation, search a blend name in the peptide picker and pick
     the blend path: the entered name must carry over as the blend name.
