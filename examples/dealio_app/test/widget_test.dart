import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic smoke test renders a screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Dealio'))),
      ),
    );

    expect(find.text('Dealio'), findsOneWidget);
  });
}
