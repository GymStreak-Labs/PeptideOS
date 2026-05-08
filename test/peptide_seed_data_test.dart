import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/services/peptide_seed_data.dart';

void main() {
  test('bundled peptide library includes store-listing reference examples', () {
    final peptides = PeptideSeedData.build();
    final slugs = peptides.map((p) => p.slug).toSet();

    expect(peptides.length, greaterThanOrEqualTo(36));
    expect(slugs.length, peptides.length);
    expect(
      slugs,
      containsAll([
        'bpc-157',
        'tb-500',
        'cjc-1295-no-dac',
        'sermorelin',
        'aod-9604',
        'kpv',
        'ss-31',
        'll-37',
        'dihexa',
        'ghrp-2',
        'ghrp-6',
        'hexarelin',
        'igf-1-lr3',
        'igf-1-des',
        'peg-mgf',
        'mk-677',
        'five-amino-1mq',
        'tesofensine',
        'ru-58841',
      ]),
    );
  });
}
