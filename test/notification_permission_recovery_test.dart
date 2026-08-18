import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/user_settings_repository.dart';
import 'package:peptide_os/features/profile/providers/settings_provider.dart';
import 'package:peptide_os/features/protocol/providers/notification_permission_provider.dart';
import 'package:peptide_os/features/protocol/widgets/reminders_blocked_banner.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/services/notification_service.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationPermissionProvider', () {
    test(
      'denied status reads as blocked; unknown and granted do not',
      () async {
        var status = NotificationPermissionStatus.denied;
        final provider = NotificationPermissionProvider(
          statusLoader: () async => status,
          openSettings: () async {},
          observeLifecycle: false,
        );
        addTearDown(provider.dispose);
        await provider.refresh();
        expect(provider.isBlocked, isTrue);

        status = NotificationPermissionStatus.unknown;
        await provider.refresh();
        expect(provider.isBlocked, isFalse);

        status = NotificationPermissionStatus.granted;
        await provider.refresh();
        expect(provider.isBlocked, isFalse);
      },
    );

    test('fires the regrant hook once when denied flips to granted', () async {
      var status = NotificationPermissionStatus.denied;
      var resyncs = 0;
      final provider = NotificationPermissionProvider(
        statusLoader: () async => status,
        openSettings: () async {},
        observeLifecycle: false,
      );
      addTearDown(provider.dispose);
      provider.onPermissionRegranted = () async => resyncs++;

      await provider.refresh();
      expect(resyncs, 0);

      // Simulates the user re-enabling notifications in system settings and
      // returning to the app.
      status = NotificationPermissionStatus.granted;
      await provider.refresh();
      expect(resyncs, 1);

      // Further refreshes with an unchanged status stay quiet.
      await provider.refresh();
      expect(resyncs, 1);
    });

    test('does not fire the regrant hook for unknown → granted', () async {
      var status = NotificationPermissionStatus.unknown;
      var resyncs = 0;
      final provider = NotificationPermissionProvider(
        statusLoader: () async => status,
        openSettings: () async {},
        observeLifecycle: false,
      );
      addTearDown(provider.dispose);
      provider.onPermissionRegranted = () async => resyncs++;

      await provider.refresh();
      status = NotificationPermissionStatus.granted;
      await provider.refresh();
      expect(resyncs, 0);
    });

    test('loader failures degrade to unknown instead of throwing', () async {
      final provider = NotificationPermissionProvider(
        statusLoader: () async => throw StateError('plugin unavailable'),
        openSettings: () async {},
        observeLifecycle: false,
      );
      addTearDown(provider.dispose);
      await provider.refresh();
      expect(provider.status, NotificationPermissionStatus.unknown);
      expect(provider.isBlocked, isFalse);
    });

    test('openSystemSettings delegates to the injected launcher', () async {
      var opened = 0;
      final provider = NotificationPermissionProvider(
        statusLoader: () async => NotificationPermissionStatus.denied,
        openSettings: () async => opened++,
        observeLifecycle: false,
      );
      addTearDown(provider.dispose);
      await provider.openSystemSettings();
      expect(opened, 1);
    });
  });

  group('RemindersBlockedBanner', () {
    Future<
      ({
        SettingsProvider settings,
        NotificationPermissionProvider permission,
        void Function(NotificationPermissionStatus) setStatus,
        List<int> opens,
      })
    >
    pumpBanner(
      WidgetTester tester, {
      required bool notificationsEnabled,
      required NotificationPermissionStatus initialStatus,
    }) async {
      var status = initialStatus;
      final opens = <int>[];
      final settings = SettingsProvider(
        UserSettingsRepository(firestore: FakeFirebaseFirestore()),
        uid: '',
      );
      final permission = NotificationPermissionProvider(
        statusLoader: () async => status,
        openSettings: () async => opens.add(1),
        observeLifecycle: false,
      );
      addTearDown(settings.dispose);
      addTearDown(permission.dispose);
      await settings.update(
        (s) => s.notificationsEnabled = notificationsEnabled,
      );
      await permission.refresh();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: settings),
            ChangeNotifierProvider.value(value: permission),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.dark,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(body: RemindersBlockedBanner()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return (
        settings: settings,
        permission: permission,
        setStatus: (next) => status = next,
        opens: opens,
      );
    }

    testWidgets(
      'shows recovery card with Open Settings when reminders are wanted '
      'but the OS permission is denied',
      (tester) async {
        final harness = await pumpBanner(
          tester,
          notificationsEnabled: true,
          initialStatus: NotificationPermissionStatus.denied,
        );

        expect(find.text('Reminders are blocked'), findsOneWidget);
        expect(find.text('Open Settings'), findsOneWidget);

        await tester.tap(find.text('Open Settings'));
        await tester.pump();
        expect(harness.opens, hasLength(1));
      },
    );

    testWidgets('hides when the user keeps reminders off', (tester) async {
      await pumpBanner(
        tester,
        notificationsEnabled: false,
        initialStatus: NotificationPermissionStatus.denied,
      );
      expect(find.text('Reminders are blocked'), findsNothing);
    });

    testWidgets('hides for granted and unknown permission states', (
      tester,
    ) async {
      for (final status in [
        NotificationPermissionStatus.granted,
        NotificationPermissionStatus.unknown,
      ]) {
        await pumpBanner(
          tester,
          notificationsEnabled: true,
          initialStatus: status,
        );
        expect(
          find.text('Reminders are blocked'),
          findsNothing,
          reason: 'status=$status',
        );
      }
    });

    testWidgets('disappears after the permission is re-granted', (
      tester,
    ) async {
      final harness = await pumpBanner(
        tester,
        notificationsEnabled: true,
        initialStatus: NotificationPermissionStatus.denied,
      );
      expect(find.text('Reminders are blocked'), findsOneWidget);

      harness.setStatus(NotificationPermissionStatus.granted);
      await harness.permission.refresh();
      await tester.pumpAndSettle();
      expect(find.text('Reminders are blocked'), findsNothing);
    });
  });
}
