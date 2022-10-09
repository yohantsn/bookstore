import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:bookstore/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('smoke test', () {
    testWidgets('init app and find for some book', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final findItem = find.byKey(const Key("home_header_field"));
      await tester.enterText(findItem, "got");
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
