import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/protocol.dart';

/// Storage contract used by the protocol state provider.
///
/// Keeping the contract separate from the Firestore implementation lets the
/// provider's real-time behaviour be exercised without booting Firebase.
abstract interface class ProtocolDataSource {
  Stream<List<Protocol>> watchAll(String uid);

  Future<List<Protocol>> fetchAllOnce(String uid);

  Future<void> upsert(String uid, Protocol protocol);

  Future<void> delete(String uid, String protocolUuid);
}

/// Firestore CRUD for the authenticated user's protocols.
///
/// Layout: `users/{uid}/protocols/{protocolUuid}`.
class ProtocolRepository implements ProtocolDataSource {
  ProtocolRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _firestore.collection('users').doc(uid).collection('protocols');

  @override
  Stream<List<Protocol>> watchAll(String uid) {
    return _col(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => Protocol.fromMap(d.id, d.data()))
            .toList(growable: false));
  }

  @override
  Future<List<Protocol>> fetchAllOnce(String uid) async {
    final snap =
        await _col(uid).orderBy('createdAt', descending: true).get();
    return snap.docs
        .map((d) => Protocol.fromMap(d.id, d.data()))
        .toList(growable: false);
  }

  @override
  Future<void> upsert(String uid, Protocol protocol) async {
    await _col(uid).doc(protocol.uuid).set(protocol.toMap());
  }

  @override
  Future<void> delete(String uid, String protocolUuid) async {
    await _col(uid).doc(protocolUuid).delete();
  }
}
