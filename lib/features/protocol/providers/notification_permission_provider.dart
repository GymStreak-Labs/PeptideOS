import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../services/notification_service.dart';

typedef NotificationPermissionLoader =
    Future<NotificationPermissionStatus> Function();

/// Tracks the OS notification permission so Protocol/Profile surfaces can show
/// a persistent "reminders blocked" state with an Open Settings recovery path.
///
/// The status is re-checked whenever the app returns to the foreground (the
/// user may have just re-enabled notifications in system settings). When a
/// denied permission flips back to granted, [onPermissionRegranted] fires once
/// so callers can resync the pending reminder schedule. It never prompts.
class NotificationPermissionProvider extends ChangeNotifier
    with WidgetsBindingObserver {
  NotificationPermissionProvider({
    NotificationPermissionLoader? statusLoader,
    Future<void> Function()? openSettings,
    bool observeLifecycle = true,
  }) : _statusLoader =
           statusLoader ?? NotificationService.instance.permissionStatus,
       _openSettings =
           openSettings ??
           NotificationService.instance.openSystemNotificationSettings,
       _observeLifecycle = observeLifecycle {
    if (_observeLifecycle) {
      WidgetsBinding.instance.addObserver(this);
    }
    unawaited(refresh());
  }

  final NotificationPermissionLoader _statusLoader;
  final Future<void> Function() _openSettings;
  final bool _observeLifecycle;

  NotificationPermissionStatus _status = NotificationPermissionStatus.unknown;
  Future<void> Function()? onPermissionRegranted;
  Future<void>? _activeRefresh;
  bool _disposed = false;

  NotificationPermissionStatus get status => _status;

  /// True when the OS is known to block notifications. `unknown` deliberately
  /// reads as not blocked so the banner never appears on a false alarm.
  bool get isBlocked => _status == NotificationPermissionStatus.denied;

  Future<void> refresh() {
    final active = _activeRefresh;
    if (active != null) return active;
    final refreshRun = _performRefresh();
    _activeRefresh = refreshRun;
    return refreshRun.whenComplete(() {
      if (identical(_activeRefresh, refreshRun)) _activeRefresh = null;
    });
  }

  Future<void> _performRefresh() async {
    NotificationPermissionStatus next;
    try {
      next = await _statusLoader();
    } catch (_) {
      next = NotificationPermissionStatus.unknown;
    }
    if (_disposed || next == _status) return;
    final wasDenied = _status == NotificationPermissionStatus.denied;
    _status = next;
    notifyListeners();
    if (wasDenied && next == NotificationPermissionStatus.granted) {
      final handler = onPermissionRegranted;
      if (handler != null) {
        try {
          await handler();
        } catch (e) {
          debugPrint('NotificationPermissionProvider resync failed: $e');
        }
      }
    }
  }

  Future<void> openSystemSettings() => _openSettings();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(refresh());
    }
  }

  @override
  void dispose() {
    _disposed = true;
    if (_observeLifecycle) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }
}
