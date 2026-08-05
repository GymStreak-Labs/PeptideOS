import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/services/subscription_service.dart';
import 'package:peptide_os/features/subscription/subscription_error_localization.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  test('RevenueCat purchase failures become stable customer-safe codes', () {
    expect(
      SubscriptionService.purchaseErrorCode(
        PurchasesErrorCode.purchaseNotAllowedError,
      ),
      SubscriptionErrorCode.purchaseNotAllowed,
    );
    expect(
      SubscriptionService.purchaseErrorCode(
        PurchasesErrorCode.purchaseInvalidError,
      ),
      SubscriptionErrorCode.purchaseInvalid,
    );
    expect(
      SubscriptionService.purchaseErrorCode(
        PurchasesErrorCode.productNotAvailableForPurchaseError,
      ),
      SubscriptionErrorCode.productUnavailable,
    );
    expect(
      SubscriptionService.purchaseErrorCode(PurchasesErrorCode.networkError),
      SubscriptionErrorCode.network,
    );
    expect(
      SubscriptionService.purchaseErrorCode(
        PurchasesErrorCode.purchaseCancelledError,
      ),
      SubscriptionErrorCode.purchaseCancelled,
    );
  });

  test('non-English presentation maps every typed failure through l10n', () {
    final l10n = lookupAppLocalizations(const Locale('de'));

    final messages = SubscriptionErrorCode.values
        .map((code) => localizedSubscriptionError(l10n, code))
        .toList();

    expect(messages, everyElement(isNotEmpty));
    expect(messages.toSet(), hasLength(SubscriptionErrorCode.values.length));
    expect(messages, isNot(contains('Unable to load plans.')));
    expect(messages, isNot(contains('An unexpected error occurred.')));
    expect(messages, isNot(contains('Failed to restore purchases.')));
  });

  test('service and provider contain no customer-facing English errors', () {
    final implementation = [
      File('lib/data/services/subscription_service.dart').readAsStringSync(),
      File(
        'lib/features/subscription/providers/subscription_provider.dart',
      ).readAsStringSync(),
    ].join('\n');

    for (final rawMessage in const [
      'Subscription service is not configured yet.',
      'Unable to load plans. Check your connection.',
      'Unable to load plans.',
      'Purchase was cancelled.',
      'Purchases are not allowed on this device.',
      'The purchase was invalid.',
      'This product is not available for purchase.',
      'Network error. Please check your connection.',
      'An unexpected error occurred.',
      'Failed to restore purchases.',
    ]) {
      expect(implementation, isNot(contains(rawMessage)));
    }
  });
}
