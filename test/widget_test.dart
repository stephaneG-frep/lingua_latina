import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_latina/screens/welcome_screen.dart';

void main() {
  testWidgets('Welcome screen displays app title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    expect(find.text('Lingua Latina'), findsOneWidget);
    expect(find.text('Commencer'), findsOneWidget);
  });
}
