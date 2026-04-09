import 'package:flutter_test/flutter_test.dart';
import 'package:duck_swan/main.dart';
import 'package:duck_swan/injection_container.dart' as di;

void main() {
  setUp(() async {
    await di.initDependencies();
  });

  tearDown(() async {
    await di.sl.reset();
  });

  testWidgets('Starts on BirdWatching — action button is disabled',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Picker shows placeholder, not a bird name
    expect(find.text('Select a bird'), findsOneWidget);

    // Action button is dimmed with placeholder label
    expect(find.text('· · ·'), findsOneWidget);
    expect(find.text('QUACK'), findsNothing);
    expect(find.text('FLY'), findsNothing);
  });
}
