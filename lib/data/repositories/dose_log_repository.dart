import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/dose_log.dart';

/// Storage contract used by protocol scheduling and dose-log providers.
abstract interface class DoseLogDataSource {
  Stream<List<DoseLog>> watchRange(String uid, DateTime start, DateTime end);

  Future<List<DoseLog>> fetchRange(String uid, DateTime start, DateTime end);

  Future<List<DoseLog>> fetchByProtocol(String uid, String protocolUuid);

  Future<void> upsert(String uid, DoseLog log);

  Future<void> upsertMany(String uid, List<DoseLog> logs);

  Future<void> delete(String uid, String uuid);

  Future<void> deleteMany(String uid, List<String> uuids);
}

/// Firestore CRUD for dose logs at `users/{uid}/doseLogs/{uuid}`.
///
/// Dose logs store denormalised `peptideName` + `protocolUuid` so the today
/// view can render without needing to resolve the owning protocol document.
class DoseLogRepository implements DoseLogDataSource {
  DoseLogRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _firestore.collection('users').doc(uid).collection('doseLogs');

  /// Stream the user's dose logs for the given window.
  @override
  Stream<List<DoseLog>> watchRange(String uid, DateTime start, DateTime end) {
    return _col(uid)
        .where('scheduledAt',
            isGreaterThanOrEqualTo: start.toIso8601String())
        .where('scheduledAt', isLessThan: end.toIso8601String())
        .orderBy('scheduledAt')
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => DoseLog.fromMap(d.id, d.data()))
            .toList(growable: false));
  }

  @override
  Future<List<DoseLog>> fetchRange(
      String uid, DateTime start, DateTime end) async {
    final snap = await _col(uid)
        .where('scheduledAt',
            isGreaterThanOrEqualTo: start.toIso8601String())
        .where('scheduledAt', isLessThan: end.toIso8601String())
        .orderBy('scheduledAt')
        .get();
    return snap.docs
        .map((d) => DoseLog.fromMap(d.id, d.data()))
        .toList(growable: false);
  }

  @override
  Future<List<DoseLog>> fetchByProtocol(String uid, String protocolUuid) async {
    final snap = await _col(uid)
        .where('protocolUuid', isEqualTo: protocolUuid)
        .get();
    return snap.docs
        .map((d) => DoseLog.fromMap(d.id, d.data()))
        .toList(growable: false);
  }

  @override
  Future<void> upsert(String uid, DoseLog log) async {
    await _col(uid).doc(log.uuid).set(log.toMap());
  }

  @override
  Future<void> upsertMany(String uid, List<DoseLog> logs) async {
    if (logs.isEmpty) return;
    // Batches are capped at 500 ops; our generator fills at most a week.
    final batch = _firestore.batch();
    for (final log in logs) {
      batch.set(_col(uid).doc(log.uuid), log.toMap());
    }
    await batch.commit();
  }

  @override
  Future<void> delete(String uid, String uuid) async {
    await _col(uid).doc(uuid).delete();
  }

  @override
  Future<void> deleteMany(String uid, List<String> uuids) async {
    if (uuids.isEmpty) return;
    final batch = _firestore.batch();
    for (final id in uuids) {
      batch.delete(_col(uid).doc(id));
    }
    await batch.commit();
  }
}
