import 'package:flutter_test/flutter_test.dart';
import 'package:mini_market/main.dart';

void main() {
  testWidgets('Mini Market home screen smoke test', (WidgetTester tester) async {
    // 1. Build the MiniMarketApp widget tree
    await tester.pumpWidget(const MiniMarketApp());

    // 2. Verify that the app title 'Mini Market' appears on the app bar
    expect(find.text('Mini Market'), findsOneWidget);

    // 3. Verify that product items are present on screen
    expect(find.text('Phone X'), findsOneWidget);
    expect(find.text('Headphones'), findsOneWidget);
  });
}