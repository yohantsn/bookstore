import 'package:bookstore/controllers/controllers.dart';
import 'package:bookstore/tools/tools.dart';
import 'package:bookstore/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../controllers/util/example_model.dart';

class MockDetailsController extends Mock implements IDetailsController {}

void main() {
  final controller = MockDetailsController();

  testWidgets("Details View", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BookStoreTheme.light,
        home: BookDetailsView(
          controller: controller,
          book: ExampleModel.books.first,
        ),
      ),
    );

    await tester.pumpAndSettle();
    final findText = find.text(ExampleModel.books.first.volumeInfo!.title!);
    expect(findText, findsOneWidget);
  });
}
