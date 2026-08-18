import 'package:purchases_flutter/purchases_flutter.dart';

/// Derives a free-trial length in days from a store-provided introductory
/// offer, or `null` when the product carries no free trial.
///
/// Paywall guardrail: trial copy must only ever render from this store-derived
/// value — never from hardcoded durations — so the app cannot promise a trial
/// (or a trial length) that the live App Store / Play Store offer does not
/// actually grant.
int? freeTrialDaysFromStoreProduct(StoreProduct product) {
  final fromIntro = freeTrialDaysFromIntroductoryPrice(
    product.introductoryPrice,
  );
  if (fromIntro != null) return fromIntro;
  // Google Play Billing 5+ surfaces free trials as a zero-price pricing phase
  // on the default subscription option rather than `introductoryPrice`.
  return freeTrialDaysFromFreePhase(product.defaultOption?.freePhase);
}

/// Google-side counterpart of [freeTrialDaysFromIntroductoryPrice]: derives a
/// free-trial length from a zero-price [PricingPhase], or `null` when the
/// phase is absent, paid, or malformed.
int? freeTrialDaysFromFreePhase(PricingPhase? freePhase) {
  final period = freePhase?.billingPeriod;
  if (freePhase == null || period == null) return null;
  if (freePhase.price.amountMicros != 0) return null;
  final cycles = freePhase.billingCycleCount ?? 1;
  if (period.value <= 0 || cycles <= 0) return null;
  final unitDays = switch (period.unit) {
    PeriodUnit.day => 1,
    PeriodUnit.week => 7,
    PeriodUnit.month => 30,
    PeriodUnit.year => 365,
    PeriodUnit.unknown => 0,
  };
  if (unitDays == 0) return null;
  return period.value * unitDays * cycles;
}

int? freeTrialDaysFromIntroductoryPrice(IntroductoryPrice? intro) {
  if (intro == null) return null;
  // A paid introductory price is a discount, not a free trial.
  if (intro.price != 0) return null;
  final units = intro.periodNumberOfUnits;
  if (units <= 0) return null;
  return switch (intro.periodUnit) {
    PeriodUnit.day => units,
    PeriodUnit.week => units * 7,
    PeriodUnit.month => units * 30,
    PeriodUnit.year => units * 365,
    PeriodUnit.unknown => null,
  };
}
