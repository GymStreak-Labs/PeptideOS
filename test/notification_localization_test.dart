import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/services/notification_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('notification copy follows the requested German locale', () async {
    final copy = await loadNotificationCopy(const Locale('de'));

    expect(copy.channelName, 'Dosiserinnerungen');
    expect(copy.doseTitle, 'Zeit für deine Dosis');
    expect(copy.cycleBody, contains('Zyklusfenster'));
    expect(copy.phaseBody, contains('Tracking-Phase'));
  });

  test(
    'notification copy falls back to English for unsupported locales',
    () async {
      final copy = await loadNotificationCopy(const Locale('zh'));

      expect(copy.channelName, 'Dose Reminders');
      expect(copy.doseTitle, 'Time for your dose');
    },
  );
}
