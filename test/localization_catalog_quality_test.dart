import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _targetArbs = <String>[
  'lib/l10n/app_de.arb',
  'lib/l10n/app_es.arb',
  'lib/l10n/app_fr.arb',
  'lib/l10n/app_it.arb',
  'lib/l10n/app_ja.arb',
  'lib/l10n/app_ko.arb',
  'lib/l10n/app_pt.arb',
  'lib/l10n/app_pt_BR.arb',
];

void main() {
  final source = _readJson('lib/l10n/app_en.arb');
  final sourceKeys = _messageKeys(source);

  for (final path in _targetArbs) {
    test('$path matches source keys, metadata, and placeholders', () {
      final target = _readJson(path);
      expect(_messageKeys(target), sourceKeys, reason: '$path key parity');

      for (final key in sourceKeys) {
        final sourceValue = source[key] as String;
        final targetValue = target[key] as String;
        final sourceMeta = _metadata(source, key);
        final targetMeta = _metadata(target, key);

        expect(targetValue.trim(), isNotEmpty, reason: '$path:$key is empty');
        expect(
          targetMeta['sourceString'],
          sourceValue,
          reason: '$path:$key has stale source tracking',
        );
        expect(
          targetMeta['sourceDescription'],
          sourceMeta['description'],
          reason: '$path:$key has stale source context',
        );
        expect(
          _placeholderNames(targetMeta),
          _placeholderNames(sourceMeta),
          reason: '$path:$key placeholder metadata differs',
        );

        for (final placeholder in _placeholderNames(sourceMeta)) {
          expect(
            targetValue,
            contains('{$placeholder'),
            reason: '$path:$key lost {$placeholder}',
          );
        }
        expect(
          _placeholderReferences(targetValue),
          _placeholderNames(sourceMeta),
          reason: '$path:$key has missing or unexpected placeholder references',
        );
      }
    });
  }

  test('Portuguese base and Brazilian regional catalogs are explicit', () {
    final base = _readJson('lib/l10n/app_pt.arb');
    final brazil = _readJson('lib/l10n/app_pt_BR.arb');

    expect(base['@@locale'], 'pt');
    expect(brazil['@@locale'], 'pt_BR');
    final regionalDifferences = _messageKeys(
      base,
    ).where((key) => base[key] != brazil[key]).length;
    expect(
      regionalDifferences,
      greaterThan(0),
      reason: 'pt_BR must contain intentional regional wording overrides',
    );
  });

  test(
    'localized App Store names and subtitles fit the 30-character limit',
    () {
      final files = Directory('metadata/app-info')
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.json'));

      expect(files.length, 8);
      for (final file in files) {
        final metadata = _readJson(file.path);
        expect(
          (metadata['name'] as String).runes.length,
          lessThanOrEqualTo(30),
          reason: '${file.path} name exceeds App Store limit',
        );
        expect(
          (metadata['subtitle'] as String).runes.length,
          lessThanOrEqualTo(30),
          reason: '${file.path} subtitle exceeds App Store limit',
        );
      }
    },
  );
}

Map<String, dynamic> _readJson(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

Set<String> _messageKeys(Map<String, dynamic> arb) =>
    arb.keys.where((key) => !key.startsWith('@')).toSet();

Map<String, dynamic> _metadata(Map<String, dynamic> arb, String key) =>
    (arb['@$key'] as Map<String, dynamic>?) ?? const <String, dynamic>{};

Set<String> _placeholderNames(Map<String, dynamic> metadata) =>
    ((metadata['placeholders'] as Map<String, dynamic>?)?.keys ??
            const <String>{})
        .toSet();

Set<String> _placeholderReferences(String message) => RegExp(
  r'\{([A-Za-z][A-Za-z0-9_]*)\s*(?:[,}])',
).allMatches(message).map((match) => match.group(1)!).toSet();
