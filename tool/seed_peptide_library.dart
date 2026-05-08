import 'dart:convert';
import 'dart:io';

import 'package:peptide_os/models/peptide.dart';
import 'package:peptide_os/services/peptide_seed_data.dart';

const _tokenEnv = 'FIRESTORE_ACCESS_TOKEN';

Future<void> main(List<String> args) async {
  final project = _option(args, '--project');
  final dryRun = args.contains('--dry-run');
  if (project == null || project.isEmpty) {
    stderr.writeln(
      'Usage: dart run tool/seed_peptide_library.dart --project <project-id> [--dry-run]',
    );
    exitCode = 64;
    return;
  }

  final peptides = PeptideSeedData.build();
  if (dryRun) {
    stdout.writeln(
      'Would seed ${peptides.length} peptideLibrary docs into $project.',
    );
    stdout.writeln(peptides.map((p) => p.slug).join(', '));
    return;
  }

  final token = Platform.environment[_tokenEnv];
  if (token == null || token.isEmpty) {
    stderr.writeln('Missing $_tokenEnv.');
    exitCode = 64;
    return;
  }

  final uri = Uri.https(
    'firestore.googleapis.com',
    '/v1/projects/$project/databases/(default)/documents:commit',
  );
  final request = await HttpClient().postUrl(uri);
  request.headers.contentType = ContentType.json;
  request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
  request.write(
    jsonEncode({
      'writes': [
        for (final peptide in peptides)
          {
            'update': {
              'name':
                  'projects/$project/databases/(default)/documents/peptideLibrary/${peptide.slug}',
              'fields': _fields(peptide),
            },
          },
      ],
    }),
  );

  final response = await request.close();
  final body = await response.transform(utf8.decoder).join();
  if (response.statusCode < 200 || response.statusCode >= 300) {
    stderr.writeln('Firestore seed failed with HTTP ${response.statusCode}.');
    stderr.writeln(body);
    exitCode = 1;
    return;
  }

  stdout.writeln(
    'Seeded ${peptides.length} peptideLibrary docs into $project.',
  );
}

String? _option(List<String> args, String name) {
  final index = args.indexOf(name);
  if (index == -1 || index + 1 >= args.length) return null;
  return args[index + 1];
}

Map<String, Object?> _fields(Peptide peptide) {
  return peptide.toMap().map((key, value) => MapEntry(key, _value(value)));
}

Map<String, Object?> _value(Object? value) {
  if (value == null) return {'nullValue': null};
  if (value is bool) return {'booleanValue': value};
  if (value is int) return {'integerValue': value.toString()};
  if (value is double) return {'doubleValue': value};
  if (value is String) return {'stringValue': value};
  if (value is List) {
    return {
      'arrayValue': {
        if (value.isNotEmpty) 'values': value.map(_value).toList(),
      },
    };
  }
  throw UnsupportedError('Unsupported Firestore value: $value');
}
