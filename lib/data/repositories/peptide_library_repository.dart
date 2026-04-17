import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/peptide.dart';
import '../../services/peptide_seed_data.dart';

/// Firestore-backed access to the global peptide library.
///
/// Library documents live at `peptideLibrary/{slug}` and are read-open to any
/// authenticated user. Writes are restricted via security rules — the client
/// only writes as part of the one-time bootstrap seed.
class PeptideLibraryRepository {
  PeptideLibraryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('peptideLibrary');

  /// Stream of the full library, sorted by name.
  Stream<List<Peptide>> watchAll() {
    return _col.orderBy('name').snapshots().map(
          (snap) => snap.docs
              .map((d) => Peptide.fromMap(d.id, d.data()))
              .toList(growable: false),
        );
  }

  /// One-shot read used during bootstrap to decide whether to seed.
  Future<int> count() async {
    final snap = await _col.limit(1).get();
    return snap.size;
  }

  /// Seed the 20 reference peptides if the collection is empty. Idempotent —
  /// safe to call on every launch.
  Future<void> seedIfEmpty() async {
    try {
      final existing = await count();
      if (existing > 0) return;

      final seed = PeptideSeedData.build();
      final batch = _firestore.batch();
      for (final p in seed) {
        batch.set(_col.doc(p.slug), p.toMap());
      }
      await batch.commit();
      debugPrint(
          'PeptideLibraryRepository: seeded ${seed.length} library docs.');
    } catch (e) {
      // Seeding relies on security rules being lax enough to write — in a
      // locked-down prod setup the admin console seeds instead.
      debugPrint('PeptideLibraryRepository seed failed: $e');
    }
  }

  Future<List<Peptide>> fetchAllOnce() async {
    final snap = await _col.orderBy('name').get();
    return snap.docs
        .map((d) => Peptide.fromMap(d.id, d.data()))
        .toList(growable: false);
  }
}
