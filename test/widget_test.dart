import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noxcollect/main.dart';

void main() {
  testWidgets('NoxCollect app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: NoxCollectApp()));

    // Verify bootstrap loading screen renders
    expect(find.text('Preparing test database...'), findsOneWidget);
  });
}
