import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<Peptide> get bundledSeed => PeptideSeedData.build();

  /// Stream of the full library, sorted by name.
  Stream<List<Peptide>> watchAll() {
    return _col.orderBy('name').snapshots().map((snap) {
      final remote = snap.docs
          .map((d) => Peptide.fromMap(d.id, d.data()))
          .toList(growable: false);
      return _mergeWithBundled(remote);
    });
  }

  /// One-shot read used during bootstrap to decide whether to seed.
  Future<int> count() async {
    final snap = await _col.limit(1).get();
    return snap.size;
  }

  /// Local marker recording which bundled seed version this install has
  /// already reconciled against the remote collection.
  static const String seedVersionPrefsKey = 'pepmod_library_seed_version';

  /// Versioned, idempotent library seeding.
  ///
  /// Reconciles the remote collection with the bundled catalogue whenever the
  /// bundled [PeptideSeedData.seedVersion] is newer than the last version this
  /// install processed. Only *missing* slugs are written — existing documents
  /// are never touched, so remote edits (or a future admin-curated catalogue)
  /// can never be clobbered by a client. Safe to call on every launch.
  ///
  /// Read-side note: [watchAll]/[fetchAllOnce] merge the bundled seed under
  /// remote data, so users see new bundled entries immediately even when
  /// security rules deny client writes (the prod setup). The version marker is
  /// still advanced in that case to avoid retrying a denied write every
  /// launch.
  Future<void> ensureSeeded() async {
    int? storedVersion;
    SharedPreferences? prefs;
    try {
      prefs = await SharedPreferences.getInstance();
      storedVersion = prefs.getInt(seedVersionPrefsKey);
    } catch (e) {
      debugPrint('PeptideLibraryRepository: seed version read failed: $e');
    }
    if (storedVersion != null && storedVersion >= PeptideSeedData.seedVersion) {
      return;
    }

    try {
      final existingSlugs = (await _col.get()).docs.map((d) => d.id).toSet();
      final missing = PeptideSeedData.build()
          .where((p) => !existingSlugs.contains(p.slug))
          .toList(growable: false);
      if (missing.isNotEmpty) {
        final batch = _firestore.batch();
        for (final p in missing) {
          batch.set(_col.doc(p.slug), p.toMap());
        }
        await batch.commit();
        debugPrint(
          'PeptideLibraryRepository: seeded ${missing.length} new library '
          'docs (seed v${PeptideSeedData.seedVersion}).',
        );
      }
    } catch (e) {
      // Client writes are denied by prod security rules — the bundled merge in
      // watchAll()/fetchAllOnce() still surfaces the new entries to users.
      debugPrint('PeptideLibraryRepository seed failed: $e');
    }

    try {
      await prefs?.setInt(seedVersionPrefsKey, PeptideSeedData.seedVersion);
    } catch (e) {
      debugPrint('PeptideLibraryRepository: seed version save failed: $e');
    }
  }

  /// Backwards-compatible alias for the pre-versioned bootstrap entry point.
  Future<void> seedIfEmpty() => ensureSeeded();

  Future<List<Peptide>> fetchAllOnce() async {
    final snap = await _col.orderBy('name').get();
    final remote = snap.docs
        .map((d) => Peptide.fromMap(d.id, d.data()))
        .toList(growable: false);
    return _mergeWithBundled(remote);
  }

  List<Peptide> _mergeWithBundled(List<Peptide> remote) {
    final bySlug = <String, Peptide>{
      for (final p in bundledSeed) p.slug: p,
      for (final p in remote) p.slug: p,
    };
    final merged = bySlug.values.toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return merged;
  }
}
