# PepMod product walkthrough — support-led next-version improvements

Date: 2026-08-31

## Customer evidence and success conditions

This pass responds to the complete Gleap conversations reviewed in the CEO support audit:

- `6a8256be…`: a 70-year-old customer returned to Calendar/Notes because entering a dose did not clearly lead to the syringe units to draw, and prior-day data/reminders were difficult to find. Success means a user can perform their own vial conversion from protocol setup and can see or correct historical schedule state without leaving the planner.
- `6a925660…` and `6a90752d…`: customers described the product as hard to navigate or not user-friendly. Success means the relevant controls are present in the path where the task begins, with plain labels rather than internal terminology.
- `6a5ec3eb…` and `6a909321…`: customers needed an explicit Spanish/English language choice. Success means Profile offers a persistent in-app language selection without changing the whole device language.
- `6a80e8ee…`: requested PDF/image import. This remains a separate, larger follow-on because document interpretation needs an explicit review/confirmation flow and should not be bundled into these deterministic tracking improvements.

## Feature trace

| Feature | Status | End-to-end result |
|---|---|---|
| Protocol vial conversion | ✅ Works | Create/edit protocol → peptide configuration → **Open unit converter** → user enters vial amount and diluent → **ADD TO PROTOCOL** writes the validated U-100 draw-unit result into the optional syringe-units field → protocol save persists it. The converter remains user-input-driven and never recommends an amount or frequency. Results exceeding the selected syringe capacity cannot be applied. |
| Weekly planner history | ✅ Works | Protocol → weekly calendar joins each scheduled card to its `DoseLog` using protocol, peptide, and exact scheduled time. Cards render taken, skipped, or missed state. Recorded and past cards open the existing log/edit/skip/undo sheet. A missing historical log is offered as **LOG DOSE**, not silently classified as missed. |
| In-app language | ✅ Works | Profile → Preferences → **Language** → system default or one of the app's supported locales. The choice is stored in `users/{uid}/settings/profile.localeCode` and drives `MaterialApp.locale`. Existing records without the field continue to follow the device language. |
| PDF/image import | ⚠️ Deferred | Valid support demand, but not part of this PR. A future flow must show extracted fields for confirmation before modifying a protocol. |

## Wording and discoverability

- The protocol control renders as **Open unit converter**, immediately below the syringe-units field described by the customer. The converter action renders as **ADD TO PROTOCOL**.
- Planner state uses short existing schedule language: **TAKEN · TAP TO EDIT**, **SKIPPED**, **MISSED**, and **LOG DOSE**. State color uses existing success, secondary, warning, and primary tokens on the dark card surface.
- Profile uses **Language**, **System default**, and **Choose app language**, followed by each language's native name.
- New copy is available in English, Spanish, French, Italian, German, Japanese, Korean, Portuguese, and Brazilian Portuguese.

## Edge cases and compatibility

- Existing protocols and settings require no migration; the new locale field defaults to an empty string and existing syringe-unit values remain untouched.
- Invalid, zero, cross-family, above-vial, or over-capacity converter inputs cannot be applied.
- Future planner cards remain read-only; past cards can be logged. Existing taken/skipped records remain editable through the established dose sheet.
- Planner schedules still come from `ProtocolPeptide.scheduleForDate`, so custom weekdays, phases, washouts, and legacy schedules do not fork into a second scheduling implementation.

## Monetization assessment

These changes improve the paid and free core tracking loop without changing entitlements. Free-plan limits remain one protocol and one peptide per protocol; premium retains multiple protocols/stacks. There is no new paywall bypass or subscription dependency in these paths.

## First-use experience

The conversion entry is now available at the moment a user configures a peptide instead of requiring them to discover the Library tool independently. After returning, the calculated draw units are visible in the same form before Save. The weekly planner now answers what happened on prior days and provides the correction action on the card. Language selection is discoverable under the existing Preferences section and applies immediately.

## Remaining recommendation

Build PDF/photo import as a separately instrumented feature: choose document, extract candidate vial/protocol fields, show confidence and source text, require field-by-field confirmation, then create a draft rather than writing an active protocol directly.
