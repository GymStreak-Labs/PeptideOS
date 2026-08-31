import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../l10n/app_localizations.dart';

/// Calendar unit of a store-derived free-trial period.
///
/// Kept as the store's own unit — never converted into approximate day
/// counts — so a one-month trial is advertised as one month, not "30 days".
enum TrialPeriodUnit { day, week, month, year }

/// Whether the *current user* can actually redeem a product's introductory
/// offer. Anything other than [eligible] must suppress trial copy (fail
/// closed): a paywall promise the store won't honour is worse than showing
/// the ordinary price.
enum TrialEligibility { eligible, ineligible, unknown }

/// A store-derived free trial: an exact [count] of calendar [unit]s.
///
/// Paywall guardrail: trial copy must only ever render from this
/// store-derived value — never from hardcoded durations — so the app cannot
/// promise a trial (or a trial length) that the live App Store / Play Store
/// offer does not actually grant.
@immutable
class StoreTrialOffer {
  const StoreTrialOffer({required this.count, required this.unit});

  /// Exact number of [unit]s, always > 0. Multi-cycle Google pricing phases
  /// are folded in exactly (e.g. 2 cycles of P1W → 2 weeks).
  final int count;
  final TrialPeriodUnit unit;

  @override
  bool operator ==(Object other) =>
      other is StoreTrialOffer && other.count == count && other.unit == unit;

  @override
  int get hashCode => Object.hash(count, unit);

  @override
  String toString() => 'StoreTrialOffer($count $unit)';
}

/// Resolves the free trial the current user can actually start for [product],
/// or `null` when no trial may be advertised.
///
/// Platform semantics (purchases_flutter 8.x):
/// - Apple platforms: `StoreProduct.introductoryPrice` describes the offer on
///   the *product*, regardless of whether this user already consumed it. It
///   is only trusted when `Purchases.checkTrialOrIntroductoryPriceEligibility`
///   reported [TrialEligibility.eligible] for this product; ineligible,
///   unknown, and error states all fail closed.
/// - Google Play: `checkTrialOrIntroductoryPriceEligibility` always returns
///   unknown, so it is not consulted. Instead the trial comes only from the
///   free phase of `StoreProduct.defaultOption` — the subscription option
///   Play itself returned as available to this user and the one
///   `Purchases.purchasePackage` will buy.
StoreTrialOffer? resolveTrialOffer({
  required StoreProduct product,
  required bool isApplePlatform,
  required TrialEligibility Function(String productIdentifier) eligibilityFor,
}) {
  if (isApplePlatform) {
    if (eligibilityFor(product.identifier) != TrialEligibility.eligible) {
      return null;
    }
    return trialOfferFromIntroductoryPrice(product.introductoryPrice);
  }
  return trialOfferFromFreePhase(product.defaultOption?.freePhase);
}

/// Derives a free trial from an introductory offer, or `null` when the
/// product carries no free trial or the offer is malformed.
StoreTrialOffer? trialOfferFromIntroductoryPrice(IntroductoryPrice? intro) {
  if (intro == null) return null;
  // A paid introductory price is a discount, not a free trial.
  if (intro.price != 0) return null;
  final units = intro.periodNumberOfUnits;
  final cycles = intro.cycles;
  if (units <= 0 || cycles <= 0) return null;
  final unit = _trialUnit(intro.periodUnit);
  if (unit == null) return null;
  return StoreTrialOffer(count: units * cycles, unit: unit);
}

/// Google-side counterpart of [trialOfferFromIntroductoryPrice]: derives a
/// free trial from a zero-price [PricingPhase], or `null` when the phase is
/// absent, paid, or malformed.
StoreTrialOffer? trialOfferFromFreePhase(PricingPhase? freePhase) {
  final period = freePhase?.billingPeriod;
  if (freePhase == null || period == null) return null;
  if (freePhase.price.amountMicros != 0) return null;
  final cycles = freePhase.billingCycleCount ?? 1;
  if (period.value <= 0 || cycles <= 0) return null;
  final unit = _trialUnit(period.unit);
  if (unit == null) return null;
  return StoreTrialOffer(count: period.value * cycles, unit: unit);
}

TrialPeriodUnit? _trialUnit(PeriodUnit unit) => switch (unit) {
  PeriodUnit.day => TrialPeriodUnit.day,
  PeriodUnit.week => TrialPeriodUnit.week,
  PeriodUnit.month => TrialPeriodUnit.month,
  PeriodUnit.year => TrialPeriodUnit.year,
  // Unknown period units must suppress trial copy, not guess a length.
  PeriodUnit.unknown => null,
};

/// Localized paywall badge for a store-derived trial, in the store's own
/// calendar unit.
String freeTrialBadgeLabel(AppLocalizations l10n, StoreTrialOffer offer) =>
    switch (offer.unit) {
      TrialPeriodUnit.day => l10n.freeTrialBadgeDays(offer.count),
      TrialPeriodUnit.week => l10n.freeTrialBadgeWeeks(offer.count),
      TrialPeriodUnit.month => l10n.freeTrialBadgeMonths(offer.count),
      TrialPeriodUnit.year => l10n.freeTrialBadgeYears(offer.count),
    };
