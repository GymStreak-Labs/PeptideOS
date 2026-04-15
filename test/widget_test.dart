import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/main.dart';

void main() {
  testWidgets('App launches and shows Protocol tab', (WidgetTester tester) async {
    await tester.pumpWidget(const PeptideOSApp());
    await tester.pumpAndSettle();

    // Verify the Protocol screen is displayed.
    expect(find.text('Your Protocol'), findsOneWidget);

    // Verify the tab bar is visible.
    expect(find.text('Protocol'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('You'), findsOneWidget);
  });
}
