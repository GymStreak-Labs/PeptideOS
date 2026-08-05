import '../../data/services/subscription_service.dart';
import '../../l10n/app_localizations.dart';

/// Converts stable subscription failures into customer-facing copy only at
/// the presentation boundary. Provider and SDK details stay out of the UI.
String localizedSubscriptionError(
  AppLocalizations l10n,
  SubscriptionErrorCode errorCode,
) {
  return switch (errorCode) {
    SubscriptionErrorCode.serviceUnavailable =>
      l10n.subscriptionErrorServiceUnavailable,
    SubscriptionErrorCode.plansUnavailable =>
      l10n.subscriptionErrorPlansUnavailable,
    SubscriptionErrorCode.purchaseCancelled =>
      l10n.subscriptionErrorPurchaseCancelled,
    SubscriptionErrorCode.purchaseNotAllowed =>
      l10n.subscriptionErrorPurchaseNotAllowed,
    SubscriptionErrorCode.purchaseInvalid =>
      l10n.subscriptionErrorPurchaseInvalid,
    SubscriptionErrorCode.productUnavailable =>
      l10n.subscriptionErrorProductUnavailable,
    SubscriptionErrorCode.network => l10n.subscriptionErrorNetwork,
    SubscriptionErrorCode.purchaseFailed =>
      l10n.subscriptionErrorPurchaseFailed,
    SubscriptionErrorCode.restoreFailed => l10n.subscriptionErrorRestoreFailed,
  };
}
