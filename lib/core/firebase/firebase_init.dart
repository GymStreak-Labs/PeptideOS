import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

/// Initialises Firebase + enables Firestore offline persistence. Mirrors
/// GymLevels' essential-init flow so the rest of the app can assume Firebase
/// is ready once this completes.
Future<void> initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    try {
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
    } catch (e) {
      // Settings must be set exactly once before any other Firestore call —
      // hot restart will re-invoke this which is fine.
      debugPrint('Firestore settings already applied: $e');
    }
  } catch (e) {
    debugPrint('Firebase initialisation failed: $e');
  }
}
