import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swap_app/main.dart';
void main() {
  testWidgets('foundation is runnable without feature screens', (tester) async {
    await tester.pumpWidget(const DalilFoundation());
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
