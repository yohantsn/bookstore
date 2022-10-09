import 'dart:convert';

import 'package:bookstore/controllers/favorites_controller.dart';
import 'package:bookstore/data/persistence/book_store_persistence.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'util/example_model.dart';

class MockPersistence extends Mock implements IBookStorePersistence {}

void main() {
  final mockPersistence = MockPersistence();
  late final IFavoritesController favoritesController;

  setUpAll(() {
    favoritesController = FavoritesController(
      bookStorePersistence: mockPersistence,
    );
    when(() => mockPersistence.read(key: "books"))
        .thenAnswer((invocation) => jsonEncode([ExampleModel.books.first.toJson()]));
  });

  group("FavoritesController", () {
    test("read favorites", () async {
      await favoritesController.getBooks();

      expect(favoritesController.listBooks.length, 1);
      expect(favoritesController.listBooks.first.volumeInfo!.title, "IEEE VLSI Test Symposium");
    });

    test("delete one favorite", () async {
      when(() => mockPersistence.write(key: "books", data: any(named: "data")))
          .thenAnswer((invocation) => Future.value(jsonEncode([])));

      await favoritesController.getBooks();

      expect(favoritesController.listBooks.length, 1);
      expect(favoritesController.listBooks.first.volumeInfo!.title, "IEEE VLSI Test Symposium");

      favoritesController.removeFavorite(0);
      expect(favoritesController.listBooks.length, 0);
    });
  });
}
