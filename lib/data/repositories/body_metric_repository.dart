import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/body_metric.dart';

/// Firestore CRUD for body metrics at `users/{uid}/bodyMetrics/{uuid}`.
class BodyMetricRepository {
  BodyMetricRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _firestore.collection('users').doc(uid).collection('bodyMetrics');

  Stream<List<BodyMetric>> watchAll(String uid) {
    return _col(uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => BodyMetric.fromMap(d.id, d.data()))
            .toList(growable: false));
  }

  Future<void> upsert(String uid, BodyMetric entry) async {
    await _col(uid).doc(entry.uuid).set(entry.toMap());
  }

  Future<void> delete(String uid, String uuid) async {
    await _col(uid).doc(uuid).delete();
  }
}
