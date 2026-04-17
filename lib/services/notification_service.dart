import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../models/dose_log.dart';

/// Schedules local notifications for upcoming peptide doses.
///
/// - Initialised from `main.dart` deferred init.
/// - On iOS, requests permission lazily (on first dose schedule), not upfront.
/// - Uses a stable 31-bit integer derived from the DoseLog UUID as the OS
///   notification ID so cancel-by-id works.
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const String _channelId = 'peptide_os_dose_reminders';
  static const String _channelName = 'Dose Reminders';
  static const String _channelDescription =
      'Scheduled reminders for your active peptide protocol doses.';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _permissionRequested = false;
  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      tz_data.initializeTimeZones();
      final localName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localName));
    } catch (e) {
      debugPrint('NotificationService: timezone init failed: $e');
    }

    const androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    try {
      await _plugin.initialize(
        const InitializationSettings(android: androidInit, iOS: iosInit),
      );
      _initialized = true;
    } catch (e) {
      debugPrint('NotificationService: plugin init failed: $e');
    }
  }

  /// Ask the OS for permission — lazily, only once per install.
  Future<bool> requestPermission() async {
    if (_permissionRequested) return true;
    _permissionRequested = true;
    try {
      if (Platform.isIOS) {
        final ok = await _plugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        return ok ?? false;
      } else if (Platform.isAndroid) {
        final ok = await _plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
        return ok ?? false;
      }
    } catch (e) {
      debugPrint('NotificationService: requestPermission failed: $e');
    }
    return false;
  }

  Future<void> scheduleDoseReminder(DoseLog log) async {
    if (!_initialized) await initialize();
    if (!_initialized) return;
    if (log.scheduledAt.isBefore(DateTime.now())) return;

    final id = _notificationIdForUuid(log.uuid);
    final scheduled = tz.TZDateTime.from(log.scheduledAt, tz.local);

    try {
      await _plugin.zonedSchedule(
        id,
        'Time for your dose',
        '${log.peptideName} · ${log.amountTaken.toStringAsFixed(0)} ${log.units}',
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    } catch (e) {
      debugPrint('NotificationService: schedule failed: $e');
    }
  }

  Future<void> cancelDoseReminder(String doseUuid) async {
    if (!_initialized) return;
    try {
      await _plugin.cancel(_notificationIdForUuid(doseUuid));
    } catch (e) {
      debugPrint('NotificationService: cancel failed: $e');
    }
  }

  Future<void> cancelAll() async {
    if (!_initialized) return;
    try {
      await _plugin.cancelAll();
    } catch (e) {
      debugPrint('NotificationService: cancelAll failed: $e');
    }
  }

  /// Derive a stable 31-bit integer from a UUID string so cancel-by-id works
  /// across app launches without needing to persist the generated ID.
  int _notificationIdForUuid(String uuid) {
    var hash = 0;
    for (final codeUnit in uuid.codeUnits) {
      hash = (hash * 31 + codeUnit) & 0x7FFFFFFF;
    }
    return hash;
  }
}
