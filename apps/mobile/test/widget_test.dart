import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/app.dart';

void main() {
  testWidgets('mobile shell reports restored session state', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MobileFoundationScreen(
          environment: 'local',
          hasRestoredSession: true,
        ),
      ),
    );

    expect(find.text('Mobile foundation ready'), findsOneWidget);
    expect(find.text('Environment: local'), findsOneWidget);
    expect(find.text('Secure session ditemukan.'), findsOneWidget);
  });
}
