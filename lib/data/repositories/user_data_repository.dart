import 'package:cloud_firestore/cloud_firestore.dart';

/// Destructive cleanup for app resets and account deletion.
///
/// Firestore cannot cascade-delete subcollections from a client document
/// delete, so each user-owned collection is wiped explicitly in bounded
/// batches.
class UserDataRepository {
  UserDataRepository({FirebaseFirestore? firestore, int batchSize = 400})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _batchSize = _validatedBatchSize(batchSize);

  static const _appDataCollections = <String>[
    'doseLogs',
    'protocols',
    'bodyMetrics',
  ];

  final FirebaseFirestore _firestore;
  final int _batchSize;

  /// Clears tracking data while preserving the Firebase account, user root,
  /// settings, subscription identity, and shared peptide library.
  Future<void> deleteAppDataForUser(String uid) async {
    _validateUid(uid);
    final userRef = _firestore.collection('users').doc(uid);
    for (final collectionName in _appDataCollections) {
      await _deleteCollection(userRef.collection(collectionName));
    }
  }

  Future<void> deleteAllForUser(String uid) async {
    _validateUid(uid);
    final userRef = _firestore.collection('users').doc(uid);
    await deleteAppDataForUser(uid);
    await _deleteCollection(userRef.collection('settings'));
    await userRef.delete();
  }

  Future<void> _deleteCollection(
    CollectionReference<Map<String, dynamic>> collection,
  ) async {
    while (true) {
      final snapshot = await collection
          .limit(_batchSize)
          .get(const GetOptions(source: Source.server));
      if (snapshot.docs.isEmpty) return;

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }

  void _validateUid(String uid) {
    if (uid.trim().isEmpty) {
      throw ArgumentError.value(uid, 'uid', 'Must not be empty.');
    }
  }

  static int _validatedBatchSize(int value) {
    if (value < 1 || value > 500) {
      throw RangeError.range(value, 1, 500, 'batchSize');
    }
    return value;
  }
}
