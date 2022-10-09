import 'package:bookstore/controllers/controllers.dart';
import 'package:bookstore/tools/tools.dart';
import 'package:bookstore/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../controllers/util/example_model.dart';

class MockFavoritesController extends Mock implements IFavoritesController {}

void main() {
  final controller = MockFavoritesController();

  setUpAll(() {
    when(() => controller.isLoading).thenReturn(false);
    when(() => controller.getBooks()).thenAnswer((_) => Future.value());
  });

  testWidgets("Favorite View", (tester) async {
    when(() => controller.listBooks).thenReturn(ExampleModel.books);
    when(() => controller.removeFavorite(0)).thenReturn(null);
    await tester.pumpWidget(
      MaterialApp(
        theme: BookStoreTheme.light,
        home: Scaffold(
          body: FavoritesView(
            controller: controller,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    final findText = find.text(ExampleModel.books.first.volumeInfo!.title!);
    expect(findText, findsOneWidget);

    await tester.drag(findText, const Offset(500.0, 0.0));
    await tester.pump();
    final findNothing = find.text(ExampleModel.books.first.volumeInfo!.title!);
    expect(findNothing, findNothing);
  });

  testWidgets("Favorite View empty", (tester) async {
    when(() => controller.listBooks).thenReturn([]);
    await tester.pumpWidget(
      MaterialApp(
        theme: BookStoreTheme.light,
        home: Scaffold(
          body: FavoritesView(
            controller: controller,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    final findText = find.text(StringUtil.favoriteListEmpty);
    expect(findText, findsOneWidget);
  });
}
