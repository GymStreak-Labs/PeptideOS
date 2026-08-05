import 'dart:convert';
import 'dart:io';

const _sourcePath = 'lib/l10n/app_en.arb';
const _targetPaths = <String>[
  'lib/l10n/app_de.arb',
  'lib/l10n/app_es.arb',
  'lib/l10n/app_fr.arb',
  'lib/l10n/app_it.arb',
  'lib/l10n/app_ja.arb',
  'lib/l10n/app_ko.arb',
  'lib/l10n/app_pt.arb',
  'lib/l10n/app_pt_BR.arb',
];

void main(List<String> arguments) {
  final checkOnly = arguments.contains('--check');
  final sourceFile = File(_sourcePath);
  final originalSource = sourceFile.readAsStringSync();
  final source = _withCompleteSourceMetadata(_readArb(_sourcePath));
  final encodedSource =
      '${const JsonEncoder.withIndent('  ').convert(source)}\n';
  var staleFiles = 0;

  if (encodedSource != originalSource) {
    staleFiles += 1;
    if (!checkOnly) sourceFile.writeAsStringSync(encodedSource);
    stdout.writeln('${checkOnly ? 'STALE' : 'UPDATED'} $_sourcePath');
  }

  for (final path in _targetPaths) {
    final target = _readArb(path);
    final updated = _withSourceMetadata(source, target, path);
    final encoded = '${const JsonEncoder.withIndent('  ').convert(updated)}\n';
    final current = File(path).readAsStringSync();
    if (encoded == current) continue;

    staleFiles += 1;
    if (!checkOnly) File(path).writeAsStringSync(encoded);
    stdout.writeln('${checkOnly ? 'STALE' : 'UPDATED'} $path');
  }

  if (checkOnly && staleFiles > 0) exitCode = 1;
}

Map<String, dynamic> _withCompleteSourceMetadata(Map<String, dynamic> source) {
  final updated = Map<String, dynamic>.from(source);
  for (final key in source.keys.where((key) => !key.startsWith('@'))) {
    final metadata = source['@$key'] as Map<String, dynamic>?;
    if (metadata?['description'] != null) continue;
    updated['@$key'] = <String, dynamic>{
      if (metadata?['placeholders'] != null)
        'placeholders': metadata!['placeholders'],
      'description': 'Customer-facing app copy for $key.',
    };
  }
  return updated;
}

Map<String, dynamic> _withSourceMetadata(
  Map<String, dynamic> source,
  Map<String, dynamic> target,
  String targetPath,
) {
  final updated = Map<String, dynamic>.from(target);
  for (final entry in source.entries) {
    final key = entry.key;
    if (key.startsWith('@')) continue;
    if (!target.containsKey(key)) {
      throw StateError('$targetPath is missing message $key');
    }

    final sourceMetadata = source['@$key'] as Map<String, dynamic>?;
    final targetMetadata = target['@$key'] as Map<String, dynamic>?;
    final metadata = <String, dynamic>{
      if (targetMetadata?['description'] != null)
        'description': targetMetadata!['description']
      else if (sourceMetadata?['description'] != null)
        'description': sourceMetadata!['description'],
      if (sourceMetadata?['placeholders'] != null)
        'placeholders': sourceMetadata!['placeholders'],
      'sourceString': entry.value,
      'sourceDescription': sourceMetadata?['description'],
    };
    updated['@$key'] = metadata;
  }
  return updated;
}

Map<String, dynamic> _readArb(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
