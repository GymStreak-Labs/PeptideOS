import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/custom_compound.dart';

abstract interface class CustomCompoundStore {
  Stream<List<CustomCompound>> watchAll(String uid);
  Future<void> upsert(String uid, CustomCompound compound);
}

/// Firestore persistence for `users/{uid}/customCompounds/{compoundId}`.
class FirestoreCustomCompoundRepository implements CustomCompoundStore {
  FirestoreCustomCompoundRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _collection(String uid) =>
      _firestore.collection('users').doc(uid).collection('customCompounds');

  @override
  Stream<List<CustomCompound>> watchAll(String uid) {
    return _collection(uid).snapshots().map((snapshot) {
      final compounds = snapshot.docs
          .map((doc) => CustomCompound.fromMap(doc.id, doc.data()))
          .where((compound) => compound.name.isNotEmpty)
          .toList();
      compounds.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
      return compounds;
    });
  }

  @override
  Future<void> upsert(String uid, CustomCompound compound) {
    return _collection(uid).doc(compound.id).set(compound.toMap());
  }
}
