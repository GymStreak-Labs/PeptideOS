import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/body_metric.dart';
import '../models/dose_log.dart';
import '../models/peptide.dart';
import '../models/protocol.dart';
import '../models/user_settings.dart';
import 'peptide_seed_data.dart';

/// Wraps Isar setup and exposes typed accessors for each collection.
///
/// Call [DatabaseService.init] once during app boot before runApp.
class DatabaseService {
  DatabaseService._(this.isar);

  final Isar isar;

  static DatabaseService? _instance;
  static DatabaseService get instance {
    final i = _instance;
    if (i == null) {
      throw StateError(
        'DatabaseService.init() must be called before accessing instance.',
      );
    }
    return i;
  }

  /// Open Isar, seed the peptide library on first run, ensure a
  /// singleton UserSettings row exists.
  static Future<DatabaseService> init() async {
    if (_instance != null) return _instance!;

    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        PeptideSchema,
        ProtocolSchema,
        DoseLogSchema,
        BodyMetricSchema,
        UserSettingsSchema,
      ],
      directory: dir.path,
      name: 'peptide_os',
    );

    final db = DatabaseService._(isar);
    await db._seedIfEmpty();
    await db._ensureUserSettings();
    _instance = db;
    return db;
  }

  // ── Collection accessors ────────────────────────────────────────────────
  IsarCollection<Peptide> get peptides => isar.peptides;
  IsarCollection<Protocol> get protocols => isar.protocols;
  IsarCollection<DoseLog> get doseLogs => isar.doseLogs;
  IsarCollection<BodyMetric> get bodyMetrics => isar.bodyMetrics;
  IsarCollection<UserSettings> get userSettingsCol => isar.userSettings;

  // ── Singleton helpers ───────────────────────────────────────────────────
  Future<UserSettings> getUserSettings() async {
    final existing = await userSettingsCol.get(1);
    return existing ?? (UserSettings()..id = 1);
  }

  Future<void> saveUserSettings(UserSettings s) async {
    s.id = 1; // enforce singleton
    await isar.writeTxn(() async {
      await userSettingsCol.put(s);
    });
  }

  // ── Seeding ─────────────────────────────────────────────────────────────
  Future<void> _seedIfEmpty() async {
    final count = await peptides.count();
    if (count > 0) return;

    final seed = PeptideSeedData.build();
    try {
      await isar.writeTxn(() async {
        await peptides.putAll(seed);
      });
      debugPrint('DatabaseService: seeded ${seed.length} peptides.');
    } catch (e, st) {
      debugPrint('DatabaseService: peptide seed failed: $e\n$st');
    }
  }

  Future<void> _ensureUserSettings() async {
    final existing = await userSettingsCol.get(1);
    if (existing != null) return;
    final s = UserSettings()..id = 1;
    try {
      await isar.writeTxn(() async {
        await userSettingsCol.put(s);
      });
    } catch (e) {
      debugPrint('DatabaseService: user settings init failed: $e');
    }
  }

  /// Wipe every collection — used by the "Clear all data" setting.
  Future<void> clearAllUserData() async {
    await isar.writeTxn(() async {
      await protocols.clear();
      await doseLogs.clear();
      await bodyMetrics.clear();
      // Re-seed the settings singleton in a fresh state.
      await userSettingsCol.clear();
      await userSettingsCol.put(UserSettings()..id = 1);
      // Library peptides are intentionally left intact.
    });
  }

  /// Close Isar (called from tests / teardown).
  Future<void> close() async {
    await isar.close();
    _instance = null;
  }
}
