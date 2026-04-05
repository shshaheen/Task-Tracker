// Smoke test — verifies the app renders the Task Tracker AppBar title.

import 'package:flutter_test/flutter_test.dart';
import 'package:task_tracker/main.dart';

void main() {
  testWidgets('App renders Task Tracker title', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskTrackerApp());
    // The HomeScreen AppBar should show 'Task Tracker'.
    expect(find.text('Task Tracker'), findsOneWidget);
  });
}
