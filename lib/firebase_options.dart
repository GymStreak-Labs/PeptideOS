// File generated for PepMod (pepmod-prod Firebase project).
//
// Mirrors the shape of `flutterfire configure` output so the usage site remains
// `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`.
//
// Regenerate with `flutterfire configure --project=pepmod-prod` once the
// CLI can auth locally, or by running the `firebase apps:sdkconfig` commands
// documented in CLAUDE.md.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'PepMod does not support Firebase on web. Run on iOS or Android.',
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
          'PepMod does not support Firebase on '
          '${defaultTargetPlatform.name}.',
        );
    }
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsXMk5e8Ru7LHYigKq9-1MuX9uSyQlIRo',
    appId: '1:183647218511:ios:df57adc5f7327dfb6a733a',
    messagingSenderId: '183647218511',
    projectId: 'pepmod-prod',
    storageBucket: 'pepmod-prod.firebasestorage.app',
    iosBundleId: 'com.gymstreaklabs.peptideOs',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzobOfaAYRopI7sfUpObzVA4T4ijNWMDc',
    appId: '1:183647218511:android:c725d5d8fbdb89716a733a',
    messagingSenderId: '183647218511',
    projectId: 'pepmod-prod',
    storageBucket: 'pepmod-prod.firebasestorage.app',
  );
}
