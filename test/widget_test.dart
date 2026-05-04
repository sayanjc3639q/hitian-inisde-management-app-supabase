// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:hitian_inside/main.dart';

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HITianInsideApp());

    // Verify that our brand name is present in the header.
    expect(find.text('HITian Inside'), findsOneWidget);
    
    // Verify that the greeting is present.
    expect(find.textContaining('Hello,'), findsOneWidget);
    
    // Verify that the sections are present.
    expect(find.text('Announcements'), findsOneWidget);
    expect(find.text('Task Count'), findsOneWidget);
    expect(find.text('My Tasks'), findsOneWidget);
  });
}
