import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../models/dose_log.dart';
import '../models/protocol.dart';
import '../l10n/app_localizations.dart';

enum ProtocolReminderKind { cycleEnds, washoutEnds, phaseStarts }

typedef NotificationCopy = ({
  String channelName,
  String channelDescription,
  String doseTitle,
  String doseBody,
  String cycleTitle,
  String cycleBody,
  String restTitle,
  String restBody,
  String phaseTitle,
  String phaseBody,
});

typedef NotificationLocaleChangeHandler = Future<bool> Function();

const _scheduledNotificationLocaleKey = 'pepmod_scheduled_notification_locale';

@visibleForTesting
Locale resolveNotificationLocale(Locale locale) {
  final supported = AppLocalizations.supportedLocales;
  return supported
          .where(
            (candidate) =>
                candidate.languageCode == locale.languageCode &&
                candidate.countryCode == locale.countryCode,
          )
          .firstOrNull ??
      supported
          .where((candidate) => candidate.languageCode == locale.languageCode)
          .firstOrNull ??
      const Locale('en');
}

@visibleForTesting
String notificationLocaleTag(Locale locale) => locale.countryCode == null
    ? locale.languageCode
    : '${locale.languageCode}-${locale.countryCode}';

@visibleForTesting
bool scheduledNotificationLocaleNeedsRefresh({
  required String? scheduledLocaleTag,
  required Locale currentLocale,
  required bool hasPendingNotifications,
}) =>
    hasPendingNotifications &&
    scheduledLocaleTag != notificationLocaleTag(currentLocale);

@visibleForTesting
Future<NotificationCopy> loadNotificationCopy(Locale locale) async {
  final resolved = resolveNotificationLocale(locale);
  final l10n = await AppLocalizations.delegate.load(resolved);
  return (
    channelName: l10n.notificationChannelName,
    channelDescription: l10n.notificationChannelDescription,
    doseTitle: l10n.notificationDoseTitle,
    doseBody: l10n.notificationDoseBody,
    cycleTitle: l10n.notificationCycleTitle,
    cycleBody: l10n.notificationCycleBody,
    restTitle: l10n.notificationRestTitle,
    restBody: l10n.notificationRestBody,
    phaseTitle: l10n.notificationPhaseTitle,
    phaseBody: l10n.notificationPhaseBody,
  );
}

/// Schedules local notifications for upcoming peptide doses.
///
/// - Initialised from `main.dart` deferred init.
/// - On iOS, requests permission lazily (on first dose schedule), not upfront.
/// - Uses a stable 31-bit integer derived from the DoseLog UUID as the OS
///   notification ID so cancel-by-id works.
class NotificationService with WidgetsBindingObserver {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const String _channelId = 'pepmod_dose_reminders';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _permissionRequested = false;
  bool? _permissionGranted;
  NotificationCopy? _copy;
  Locale? _currentLocale;
  String? _scheduledLocaleTag;
  bool _localeRefreshPending = false;
  NotificationLocaleChangeHandler? _localeChangeHandler;
  Object? _localeChangeHandlerOwner;
  Future<void>? _localeRefresh;
  bool _localeRefreshQueued = false;
  bool _observingLocales = false;
  bool get isInitialized => _initialized;
  bool get needsLocaleRefresh => _localeRefreshPending;

  void setLocaleChangeHandler({
    required Object owner,
    required NotificationLocaleChangeHandler handler,
  }) {
    _localeChangeHandlerOwner = owner;
    _localeChangeHandler = handler;
  }

  void clearLocaleChangeHandler(Object owner) {
    if (!identical(_localeChangeHandlerOwner, owner)) return;
    _localeChangeHandlerOwner = null;
    _localeChangeHandler = null;
  }

  Future<void> initialize() async {
    if (_initialized) return;
    final currentLocale = resolveNotificationLocale(
      WidgetsBinding.instance.platformDispatcher.locale,
    );
    _currentLocale = currentLocale;
    _copy = await loadNotificationCopy(currentLocale);
    await _loadScheduledLocaleTag();
    if (!_observingLocales) {
      WidgetsBinding.instance.addObserver(this);
      _observingLocales = true;
    }
    try {
      tz_data.initializeTimeZones();
      final localName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localName));
    } catch (e) {
      debugPrint('NotificationService: timezone init failed: $e');
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
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
      await _refreshSchedulesIfNeeded();
    } catch (e) {
      debugPrint('NotificationService: plugin init failed: $e');
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    final locale = locales?.firstOrNull;
    if (locale == null) return;
    unawaited(refreshForLocale(locale));
  }

  @visibleForTesting
  Future<void> refreshForLocale(Locale locale) async {
    final resolved = resolveNotificationLocale(locale);
    if (_currentLocale == resolved) return;
    _currentLocale = resolved;
    _copy = await loadNotificationCopy(resolved);
    await _refreshSchedulesIfNeeded(force: true);
  }

  Future<void> _refreshSchedulesIfNeeded({bool force = false}) async {
    final activeRefresh = _localeRefresh;
    if (activeRefresh != null) {
      if (force) _localeRefreshQueued = true;
      return activeRefresh;
    }

    var runForce = force;
    do {
      _localeRefreshQueued = false;
      final refresh = _performLocaleRefreshIfNeeded(force: runForce);
      _localeRefresh = refresh;
      try {
        await refresh;
      } finally {
        if (identical(_localeRefresh, refresh)) _localeRefresh = null;
      }
      runForce = _localeRefreshQueued;
    } while (runForce);
  }

  Future<void> _performLocaleRefreshIfNeeded({required bool force}) async {
    final locale = _currentLocale;
    final handler = _localeChangeHandler;
    if (locale == null || handler == null || !_initialized) return;

    var hasPendingNotifications = false;
    try {
      hasPendingNotifications =
          (await _plugin.pendingNotificationRequests()).isNotEmpty;
    } catch (e) {
      debugPrint('NotificationService: pending request lookup failed: $e');
    }

    final needsRefresh =
        force ||
        scheduledNotificationLocaleNeedsRefresh(
          scheduledLocaleTag: _scheduledLocaleTag,
          currentLocale: locale,
          hasPendingNotifications: hasPendingNotifications,
        );
    if (!needsRefresh) return;

    _localeRefreshPending = true;
    try {
      final completed = await handler();
      if (!completed) return;
      _localeRefreshPending = false;
    } catch (e) {
      debugPrint('NotificationService: locale reschedule failed: $e');
    }
  }

  Future<void> _loadScheduledLocaleTag() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _scheduledLocaleTag = prefs.getString(_scheduledNotificationLocaleKey);
    } catch (e) {
      debugPrint('NotificationService: locale state load failed: $e');
    }
  }

  Future<void> _recordScheduledLocale() async {
    final locale = _currentLocale;
    if (locale == null) return;
    final tag = notificationLocaleTag(locale);
    if (_scheduledLocaleTag == tag) return;
    _scheduledLocaleTag = tag;
    _localeRefreshPending = false;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_scheduledNotificationLocaleKey, tag);
    } catch (e) {
      debugPrint('NotificationService: locale state save failed: $e');
    }
  }

  /// Ask the OS for permission — lazily, only once per install.
  Future<bool> requestPermission() async {
    if (!_initialized) await initialize();
    if (!_initialized) return false;
    if (_permissionRequested && _permissionGranted == true) return true;
    _permissionRequested = true;
    try {
      bool? granted;
      if (Platform.isIOS) {
        granted = await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
      } else if (Platform.isAndroid) {
        granted = await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
      } else {
        granted = true;
      }
      _permissionGranted = granted ?? false;
      return _permissionGranted!;
    } catch (e) {
      debugPrint('NotificationService: requestPermission failed: $e');
    }
    _permissionGranted = false;
    return false;
  }

  Future<void> scheduleDoseReminder(DoseLog log) async {
    if (!_initialized) await initialize();
    if (!_initialized) return;
    if (log.scheduledAt.isBefore(DateTime.now())) return;
    final hasPermission = await requestPermission();
    if (!hasPermission) return;

    final id = _notificationIdForUuid(log.uuid);
    final scheduled = tz.TZDateTime.from(log.scheduledAt, tz.local);
    final copy = _copy!;

    try {
      await _plugin.zonedSchedule(
        id,
        copy.doseTitle,
        copy.doseBody,
        scheduled,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            copy.channelName,
            channelDescription: copy.channelDescription,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      await _recordScheduledLocale();
    } on PlatformException catch (e) {
      debugPrint('NotificationService: schedule failed: ${e.code}');
    } catch (e) {
      debugPrint('NotificationService: schedule failed: $e');
    }
  }

  Future<void> scheduleProtocolReminder({
    required String protocolUuid,
    required String protocolPeptideUuid,
    required String peptideName,
    required ProtocolReminderKind kind,
    required DateTime scheduledAt,
    String reminderKey = '',
  }) async {
    if (!_initialized) await initialize();
    if (!_initialized) return;
    if (scheduledAt.isBefore(DateTime.now())) return;

    final id = _protocolReminderId(
      protocolUuid: protocolUuid,
      protocolPeptideUuid: protocolPeptideUuid,
      kind: kind,
      reminderKey: reminderKey,
    );
    final scheduled = tz.TZDateTime.from(scheduledAt, tz.local);
    final copy = _copy!;
    final (title, body) = switch (kind) {
      ProtocolReminderKind.cycleEnds => (copy.cycleTitle, copy.cycleBody),
      ProtocolReminderKind.washoutEnds => (copy.restTitle, copy.restBody),
      ProtocolReminderKind.phaseStarts => (copy.phaseTitle, copy.phaseBody),
    };

    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        scheduled,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            copy.channelName,
            channelDescription: copy.channelDescription,
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
      await _recordScheduledLocale();
    } catch (e) {
      debugPrint('NotificationService: protocol reminder failed: $e');
    }
  }

  Future<void> cancelDoseReminder(String doseUuid) async {
    if (!_initialized) await initialize();
    if (!_initialized) return;
    try {
      await _plugin.cancel(_notificationIdForUuid(doseUuid));
    } catch (e) {
      debugPrint('NotificationService: cancel failed: $e');
    }
  }

  Future<void> cancelProtocolRemindersForProtocol(Protocol protocol) async {
    if (!_initialized) await initialize();
    if (!_initialized) return;
    for (final peptide in protocol.peptides) {
      for (final kind in ProtocolReminderKind.values) {
        if (kind == ProtocolReminderKind.phaseStarts) continue;
        try {
          await _plugin.cancel(
            _protocolReminderId(
              protocolUuid: protocol.uuid,
              protocolPeptideUuid: peptide.uuid,
              kind: kind,
            ),
          );
        } catch (e) {
          debugPrint(
            'NotificationService: cancel protocol reminder failed: $e',
          );
        }
      }
      for (final phase in peptide.phases) {
        try {
          await _plugin.cancel(
            _protocolReminderId(
              protocolUuid: protocol.uuid,
              protocolPeptideUuid: peptide.uuid,
              kind: ProtocolReminderKind.phaseStarts,
              reminderKey: phase.uuid,
            ),
          );
        } catch (e) {
          debugPrint('NotificationService: cancel phase reminder failed: $e');
        }
      }
    }
  }

  Future<void> cancelAll({bool strict = false}) async {
    if (!_initialized) await initialize();
    if (!_initialized) {
      if (strict) {
        throw StateError('Notification service could not be initialized.');
      }
      return;
    }
    try {
      await _plugin.cancelAll();
      _scheduledLocaleTag = null;
      _localeRefreshPending = false;
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_scheduledNotificationLocaleKey);
      } catch (e) {
        debugPrint('NotificationService: locale state clear failed: $e');
      }
    } catch (e) {
      debugPrint('NotificationService: cancelAll failed: $e');
      if (strict) rethrow;
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

  int _protocolReminderId({
    required String protocolUuid,
    required String protocolPeptideUuid,
    required ProtocolReminderKind kind,
    String reminderKey = '',
  }) {
    final suffix = reminderKey.isEmpty ? '' : '|$reminderKey';
    return _notificationIdForUuid(
      'protocol|$protocolUuid|$protocolPeptideUuid|${kind.name}$suffix',
    );
  }
}
