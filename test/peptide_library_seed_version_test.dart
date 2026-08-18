import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/repositories/peptide_library_repository.dart';
import 'package:peptide_os/services/peptide_seed_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const newSlugs = [
    'testosterone',
    'glutathione',
    'kisspeptin-10',
    'slu-pp-332',
  ];

  group('seed catalogue v2', () {
    final peptides = PeptideSeedData.build();
    final bySlug = {for (final p in peptides) p.slug: p};

    test('bundles the requested reference additions', () {
      expect(PeptideSeedData.seedVersion, 2);
      expect(bySlug.keys, containsAll(newSlugs));
    });

    test('never invents blend formulations for vendor marketing names', () {
      // KLOW / GLOW / Wolverine have no canonical composition — users must
      // enter their own vial's contents instead of trusting an invented one.
      final names = peptides.map((p) => p.name.toLowerCase()).toSet();
      for (final alias in ['klow', 'glow', 'wolverine']) {
        expect(bySlug.keys, isNot(contains(alias)));
        expect(names, isNot(contains(alias)));
      }
    });

    test('new entries stay neutral: no default dose or invented schedule', () {
      for (final slug in newSlugs) {
        final entry = bySlug[slug]!;
        expect(entry.defaultDoseMcg, 0, reason: slug);
        expect(entry.defaultFrequency, 'as_needed', reason: slug);
        expect(entry.typicalCycleWeeks, 0, reason: slug);
        expect(
          entry.notes,
          contains('does not provide'),
          reason: '$slug notes must disavow dosing guidance',
        );
      }
    });
  });

  group('ensureSeeded', () {
    test('seeds the full catalogue on an empty collection and stores the '
        'version marker', () async {
      SharedPreferences.setMockInitialValues({});
      final firestore = FakeFirebaseFirestore();
      final repo = PeptideLibraryRepository(firestore: firestore);

      await repo.ensureSeeded();

      final docs = await firestore.collection('peptideLibrary').get();
      expect(docs.size, PeptideSeedData.build().length);

      final prefs = await SharedPreferences.getInstance();
      expect(
        prefs.getInt(PeptideLibraryRepository.seedVersionPrefsKey),
        PeptideSeedData.seedVersion,
      );
    });

    test(
      'only adds missing slugs and never overwrites remote documents',
      () async {
        SharedPreferences.setMockInitialValues({});
        final firestore = FakeFirebaseFirestore();
        // Remote copy diverged (e.g. admin-curated edit) — must survive.
        await firestore.collection('peptideLibrary').doc('bpc-157').set({
          'name': 'BPC-157 (curated)',
          'description': 'Curated remote copy',
        });

        final repo = PeptideLibraryRepository(firestore: firestore);
        await repo.ensureSeeded();

        final curated = await firestore
            .collection('peptideLibrary')
            .doc('bpc-157')
            .get();
        expect(curated.data()!['name'], 'BPC-157 (curated)');
        expect(curated.data()!['description'], 'Curated remote copy');

        final docs = await firestore.collection('peptideLibrary').get();
        expect(docs.size, PeptideSeedData.build().length);
      },
    );

    test('is idempotent across repeated launches', () async {
      SharedPreferences.setMockInitialValues({});
      final firestore = FakeFirebaseFirestore();
      final repo = PeptideLibraryRepository(firestore: firestore);

      await repo.ensureSeeded();
      await repo.ensureSeeded();
      await repo.seedIfEmpty(); // legacy alias points at the same path

      final docs = await firestore.collection('peptideLibrary').get();
      expect(docs.size, PeptideSeedData.build().length);
    });

    test('supports chunked transactional reconciliation', () async {
      SharedPreferences.setMockInitialValues({});
      final firestore = FakeFirebaseFirestore();
      final repo = PeptideLibraryRepository(firestore: firestore);

      await repo.ensureSeeded(chunkSize: 3);

      final docs = await firestore.collection('peptideLibrary').get();
      expect(docs.size, PeptideSeedData.build().length);
    });

    test('rejects a non-positive transaction chunk size', () async {
      SharedPreferences.setMockInitialValues({});
      final repo = PeptideLibraryRepository(firestore: FakeFirebaseFirestore());

      await expectLater(
        repo.ensureSeeded(chunkSize: 0),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('skips reconciliation when the stored version is current', () async {
      SharedPreferences.setMockInitialValues({
        PeptideLibraryRepository.seedVersionPrefsKey:
            PeptideSeedData.seedVersion,
      });
      final firestore = FakeFirebaseFirestore();
      final repo = PeptideLibraryRepository(firestore: firestore);

      await repo.ensureSeeded();

      // No writes at all — a current marker means no read/write pass runs.
      final docs = await firestore.collection('peptideLibrary').get();
      expect(docs.size, 0);
    });

    test('a stale version marker triggers a reconciliation pass', () async {
      SharedPreferences.setMockInitialValues({
        PeptideLibraryRepository.seedVersionPrefsKey: 1,
      });
      final firestore = FakeFirebaseFirestore();
      // Simulate a v1 install: everything except the v2 additions exists.
      final v1Entries = PeptideSeedData.build().where(
        (p) => !newSlugs.contains(p.slug),
      );
      for (final p in v1Entries) {
        await firestore.collection('peptideLibrary').doc(p.slug).set(p.toMap());
      }

      final repo = PeptideLibraryRepository(firestore: firestore);
      await repo.ensureSeeded();

      final docs = await firestore.collection('peptideLibrary').get();
      expect(docs.size, PeptideSeedData.build().length);
      for (final slug in newSlugs) {
        final doc = await firestore
            .collection('peptideLibrary')
            .doc(slug)
            .get();
        expect(doc.exists, isTrue, reason: slug);
      }

      final prefs = await SharedPreferences.getInstance();
      expect(
        prefs.getInt(PeptideLibraryRepository.seedVersionPrefsKey),
        PeptideSeedData.seedVersion,
      );
    });

    test(
      'bundled merge surfaces new entries even without any remote write',
      () async {
        // Production security rules deny client writes; reads must still show
        // the new bundled entries.
        SharedPreferences.setMockInitialValues({});
        final firestore = FakeFirebaseFirestore();
        final repo = PeptideLibraryRepository(firestore: firestore);

        final all = await repo.fetchAllOnce();
        expect(all.length, PeptideSeedData.build().length);
        expect(all.map((p) => p.slug), containsAll(newSlugs));
      },
    );
  });
}
