import 'package:bookstore/controllers/home_controller.dart';
import 'package:bookstore/tools/tools.dart';
import 'package:bookstore/views/home_view.dart';
import 'package:bookstore/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../controllers/util/example_model.dart';

class MockHomeController extends Mock implements IHomeController {}

void main() {
  final controller = MockHomeController();

  setUpAll(() {
    when(() => controller.getBooks(page: any(named: "page"), q: any(named: "q")))
        .thenAnswer((_) => Future.value(ExampleModel.books));
    when(() => controller.query).thenReturn("ios");
    when(() => controller.currentPage).thenReturn(0);
  });

  testWidgets("Home View", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BookStoreTheme.light,
        home: Scaffold(
          body: HomeView(
            controller: controller,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    final findText = find.text(StringUtil.homeTitle);
    expect(findText, findsOneWidget);
  });
}
