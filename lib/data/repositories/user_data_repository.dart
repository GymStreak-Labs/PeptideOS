import 'package:cloud_firestore/cloud_firestore.dart';

/// Destructive user-data cleanup for account deletion.
///
/// Firestore cannot cascade-delete subcollections from a client document
/// delete, so account deletion explicitly wipes every user-owned collection
/// before deleting `users/{uid}`.
class UserDataRepository {
  UserDataRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const _batchSize = 400;
  static const _userCollections = <String>[
    'settings',
    'protocols',
    'doseLogs',
    'bodyMetrics',
  ];

  final FirebaseFirestore _firestore;

  Future<void> deleteAllForUser(String uid) async {
    final userRef = _firestore.collection('users').doc(uid);
    for (final collectionName in _userCollections) {
      await _deleteCollection(userRef.collection(collectionName));
    }
    await userRef.delete();
  }

  Future<void> _deleteCollection(
    CollectionReference<Map<String, dynamic>> collection,
  ) async {
    while (true) {
      final snapshot = await collection.limit(_batchSize).get();
      if (snapshot.docs.isEmpty) return;

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }
}
