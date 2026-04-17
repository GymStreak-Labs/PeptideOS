import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/protocol.dart';

/// Firestore CRUD for the authenticated user's protocols.
///
/// Layout: `users/{uid}/protocols/{protocolUuid}`.
class ProtocolRepository {
  ProtocolRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _firestore.collection('users').doc(uid).collection('protocols');

  Stream<List<Protocol>> watchAll(String uid) {
    return _col(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => Protocol.fromMap(d.id, d.data()))
            .toList(growable: false));
  }

  Future<List<Protocol>> fetchAllOnce(String uid) async {
    final snap =
        await _col(uid).orderBy('createdAt', descending: true).get();
    return snap.docs
        .map((d) => Protocol.fromMap(d.id, d.data()))
        .toList(growable: false);
  }

  Future<void> upsert(String uid, Protocol protocol) async {
    await _col(uid).doc(protocol.uuid).set(protocol.toMap());
  }

  Future<void> delete(String uid, String protocolUuid) async {
    await _col(uid).doc(protocolUuid).delete();
  }
}
