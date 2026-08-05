import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/features/library/utils/library_labels.dart';
import 'package:peptide_os/features/protocol/widgets/protocol_localizations.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/peptide.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  final german = lookupAppLocalizations(const Locale('de'));

  test('every canonical injection site has a localized presentation label', () {
    for (final site in kInjectionSites) {
      expect(localizedInjectionSiteLabel(german, site.key), isNot(site.key));
    }
  });

  test('stored protocol keys map to localized frequency and route labels', () {
    expect(
      localizedProtocolFrequencyLabel(german, 'eod'),
      german.frequencyEveryOtherDay,
    );
    expect(localizedProtocolRouteLabel(german, 'topical'), german.routeTopical);
  });

  test(
    'peptide categories are localized at picker presentation boundaries',
    () {
      for (final category in PeptideCategory.values) {
        expect(
          localizedPeptideCategoryLabel(german, category),
          isNot(category.label),
        );
      }
    },
  );
}
