import 'dart:convert';

import 'package:bookstore/controllers/home_controller.dart';
import 'package:bookstore/data/api/book_store_api.dart';
import 'package:bookstore/data/persistence/book_store_persistence.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'util/example_model.dart';

class MockApi extends Mock implements IBookStoreApi {}

class MockPersistence extends Mock implements IBookStorePersistence {}

void main() {
  final mockApi = MockApi();
  final mockPersistence = MockPersistence();
  late final HomeController homeController;
  const query = "test";

  setUpAll(() {
    homeController = HomeController(
      bookStoreApi: mockApi,
      bookStorePersistence: mockPersistence,
    );
  });

  group("HomeController getBooks", () {
    test("getBooks with success", () async {
      when(() => mockApi.getBooks(query: query, index: 0)).thenAnswer((invocation) => Future.value(ExampleModel.books));
      final books = await homeController.getBooks(q: query, page: 0);

      expect(books.length, 1);
      expect(books.first.volumeInfo!.title, "IEEE VLSI Test Symposium");
      expect(homeController.query, query);
      expect(homeController.currentPage, 0);
    });

    test("getBooks with exception", () async {
      when(() => mockApi.getBooks(query: query, index: 0)).thenThrow(Exception());

      expectLater(homeController.getBooks(q: query, page: 0), throwsException);
    });
  });

  group("HomeController save favorites", () {
    test("save book like favorite", () async {
      when(() => mockApi.getBooks(query: query, index: 0)).thenAnswer((invocation) => Future.value(ExampleModel.books));
      when(() => mockPersistence.read(key: "books"))
          .thenAnswer((invocation) => jsonEncode([ExampleModel.books.first.toJson()]));
      when(() => mockPersistence.write(key: "books", data: any(named: "data")))
          .thenAnswer((invocation) => Future.value(jsonEncode([ExampleModel.books.first.toJson()])));

      final books = await homeController.getBooks(q: query, page: 0);

      expect(books.length, 1);
      expect(books.first.volumeInfo!.title, "IEEE VLSI Test Symposium");

      homeController.saveFavorite(0);
    });
  });
}
