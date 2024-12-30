// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';


import 'package:bookly/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Bookly());

    // Ensure the widget has been fully rendered.
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    // Check if there's a widget displaying '0'
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); // Ensure the widget rebuilds after the tap

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);  // '0' should no longer be found
    expect(find.text('1'), findsOneWidget); // '1' should now be displayed
  });
}


