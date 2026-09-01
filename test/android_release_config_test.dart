import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Android release notification configuration', () {
    test('keeps Gson generic metadata used by scheduled notifications', () {
      final buildConfig = File(
        'android/app/build.gradle.kts',
      ).readAsStringSync();
      final rules = File('android/app/proguard-rules.pro').readAsStringSync();

      expect(buildConfig, contains('isMinifyEnabled = true'));
      expect(buildConfig, contains('"proguard-rules.pro"'));
      expect(rules, contains('-keepattributes Signature'));
      expect(
        rules,
        contains(
          '-keep,allowobfuscation,allowshrinking class '
          'com.google.gson.reflect.TypeToken',
        ),
      );
      expect(
        rules,
        contains(
          '-keep,allowobfuscation,allowshrinking class * extends '
          'com.google.gson.reflect.TypeToken',
        ),
      );
    });

    test('keeps the notification icon from release resource shrinking', () {
      final resources = File(
        'android/app/src/main/res/raw/keep.xml',
      ).readAsStringSync();

      expect(resources, contains('tools:keep="@mipmap/ic_launcher"'));
    });
  });
}
