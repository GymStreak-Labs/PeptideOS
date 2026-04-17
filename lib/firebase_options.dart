// File generated for PeptideOS (gymstreak-labs Firebase project).
//
// Mirrors the shape of `flutterfire configure` output so the usage site remains
// `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`.
//
// Regenerate with `flutterfire configure --project=gymstreak-labs` once the
// CLI can auth locally, or by running the `firebase apps:sdkconfig` commands
// documented in CLAUDE.md.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'PeptideOS does not support Firebase on web. Run on iOS or Android.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.android:
        return android;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'PeptideOS does not support Firebase on '
          '${defaultTargetPlatform.name}.',
        );
    }
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCogT4VTi3Ffw0Td5XBAvC-5oWA21lBxeI',
    appId: '1:61227132457:ios:94a126cbe15ada8fe55e38',
    messagingSenderId: '61227132457',
    projectId: 'gymstreak-labs',
    storageBucket: 'gymstreak-labs.firebasestorage.app',
    iosBundleId: 'com.gymstreaklabs.peptideOs',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0LKiAAaSkWoqGzxjXjYH4zo4Xm-p8xME',
    appId: '1:61227132457:android:787382999e9ab790e55e38',
    messagingSenderId: '61227132457',
    projectId: 'gymstreak-labs',
    storageBucket: 'gymstreak-labs.firebasestorage.app',
  );
}
