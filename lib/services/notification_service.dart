import 'package:flutter/foundation.dart';

import '../models/dose_log.dart';

/// Scaffolding for Phase 2 — local dose reminders.
///
/// Intentionally does NOT initialise the plugin or request permissions yet;
/// calls here are no-ops that log in debug mode. Phase 2 will wire the real
/// `flutter_local_notifications` plugin behind these methods.
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  bool _ready = false;

  // TODO: Phase 2 — initialise flutter_local_notifications plugin, request
  // permissions, set up timezone data.
  Future<void> init() async {
    _ready = true;
    debugPrint('NotificationService: stub init complete.');
  }

  // TODO: Phase 2 — schedule a real local notification for the dose time.
  Future<void> scheduleDoseReminder(DoseLog log) async {
    if (!_ready) return;
    debugPrint(
      'NotificationService: (stub) would schedule reminder for '
      '${log.peptideName} at ${log.scheduledAt.toIso8601String()}',
    );
  }

  // TODO: Phase 2 — cancel all pending notifications.
  Future<void> cancelAll() async {
    if (!_ready) return;
    debugPrint('NotificationService: (stub) cancel all.');
  }
}
