import 'dart:async';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/repositories/custom_compound_repository.dart';
import 'package:peptide_os/features/library/providers/custom_compound_provider.dart';
import 'package:peptide_os/models/custom_compound.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  group('CustomCompound', () {
    test('round-trips a Firestore-safe preset', () {
      final createdAt = DateTime.utc(2026, 7, 20, 10);
      final updatedAt = DateTime.utc(2026, 7, 21, 11);
      final compound = CustomCompound(
        id: 'preset-1',
        name: 'Personal vial',
        vialAmount: 12.5,
        vialUnit: 'mg',
        trackingUnit: 'mcg',
        route: 'subcutaneous',
        notes: 'Blue label',
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      final payload = compound.toMap();
      expect(
        payload.values.every(
          (value) =>
              value == null || value is String || value is num || value is bool,
        ),
        isTrue,
      );

      final decoded = CustomCompound.fromMap(compound.id, payload);
      expect(decoded.name, 'Personal vial');
      expect(decoded.vialAmount, 12.5);
      expect(decoded.vialUnit, 'mg');
      expect(decoded.trackingUnit, 'mcg');
      expect(decoded.notes, 'Blue label');
      expect(decoded.createdAt, createdAt);
      expect(decoded.updatedAt, updatedAt);
    });

    test('sanitizes unknown units from older documents', () {
      final decoded = CustomCompound.fromMap('legacy', {
        'name': 'Legacy',
        'vialUnit': 'grams',
        'trackingUnit': 'units',
      });

      expect(decoded.vialUnit, 'mg');
      expect(decoded.trackingUnit, 'mcg');
    });
  });

  test('Firestore repository keeps compounds scoped to their owner', () async {
    final firestore = FakeFirebaseFirestore();
    final repository = FirestoreCustomCompoundRepository(firestore: firestore);
    final now = DateTime.utc(2026, 7, 25);
    final compound = CustomCompound(
      id: 'mine',
      name: 'My vial',
      vialAmount: 5,
      vialUnit: 'mg',
      trackingUnit: 'mcg',
      route: 'subcutaneous',
      createdAt: now,
      updatedAt: now,
    );

    await repository.upsert('user-a', compound);
    await repository.upsert('user-b', compound.copyWith(name: 'Someone else'));

    final userA = await repository.watchAll('user-a').first;
    final userB = await repository.watchAll('user-b').first;
    expect(userA.single.name, 'My vial');
    expect(userB.single.name, 'Someone else');
  });

  test('provider creates, edits, archives, and restores a preset', () async {
    final store = _MemoryCompoundStore();
    final provider = CustomCompoundProvider(store, uid: 'user-a');
    await Future<void>.delayed(Duration.zero);

    final created = await provider.save(
      name: '  Personal vial  ',
      vialAmount: 10,
      vialUnit: 'mg',
      trackingUnit: 'mcg',
      route: 'subcutaneous',
      notes: '  Amber label  ',
    );
    expect(created.name, 'Personal vial');
    expect(created.notes, 'Amber label');
    expect(provider.active.single.id, created.id);

    final edited = await provider.save(
      existing: created,
      name: 'Updated vial',
      vialAmount: 15,
      vialUnit: 'mg',
      trackingUnit: 'mg',
      route: 'intramuscular',
    );
    expect(edited.id, created.id);
    expect(edited.createdAt, created.createdAt);
    expect(provider.active.single.vialAmount, 15);

    await provider.setArchived(edited, true);
    expect(provider.active, isEmpty);
    expect(provider.archived.single.id, edited.id);

    await provider.setArchived(provider.archived.single, false);
    expect(provider.active.single.id, edited.id);
    provider.dispose();
  });

  test('protocol compound data remains an immutable selection snapshot', () {
    final selectedAt = DateTime.utc(2026, 7, 25, 9);
    final protocolEntry = ProtocolPeptide(
      peptideSlug: 'custom:preset-1',
      peptideName: 'Original label',
      dosePerInjection: 250,
      sourceCompoundId: 'preset-1',
      sourceCompoundUpdatedAt: selectedAt,
      vialAmountSnapshot: 10,
      vialUnitSnapshot: 'mg',
      compoundNotesSnapshot: 'Original note',
    );
    final stored = protocolEntry.toMap();

    final laterPreset = CustomCompound(
      id: 'preset-1',
      name: 'Renamed label',
      vialAmount: 20,
      vialUnit: 'mg',
      trackingUnit: 'mcg',
      route: 'subcutaneous',
      notes: 'Changed',
      createdAt: selectedAt,
      updatedAt: selectedAt.add(const Duration(days: 2)),
    );
    expect(laterPreset.vialAmount, 20);

    final historical = ProtocolPeptide.fromMap(stored);
    expect(historical.peptideName, 'Original label');
    expect(historical.vialAmountSnapshot, 10);
    expect(historical.compoundNotesSnapshot, 'Original note');
    expect(historical.sourceCompoundUpdatedAt, selectedAt);
  });
}

class _MemoryCompoundStore implements CustomCompoundStore {
  final _controller = StreamController<List<CustomCompound>>.broadcast(
    sync: true,
  );
  final _items = <String, CustomCompound>{};

  _MemoryCompoundStore() {
    _controller.add(const []);
  }

  @override
  Stream<List<CustomCompound>> watchAll(String uid) async* {
    yield _items.values.toList();
    yield* _controller.stream;
  }

  @override
  Future<void> upsert(String uid, CustomCompound compound) async {
    _items[compound.id] = compound;
    _controller.add(_items.values.toList());
  }
}
