import 'dart:convert';

import 'package:bookstore/controllers/home_controller.dart';
import 'package:bookstore/data/api/book_store_api.dart';
import 'package:bookstore/data/models/models.dart';
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
  final favorites = <BookModel>[];

  setUpAll(() {
    homeController = HomeController(
      bookStoreApi: mockApi,
      bookStorePersistence: mockPersistence,
    );
  });

  group("HomeController getBooks", () {
    test("getBooks with success", () async {
      when(() => mockApi.getBooks(query: query, index: 0)).thenAnswer((invocation) => Future.value(ExampleModel.books));
      await homeController.getBooks(query: query, isFirst: true);

      expect(homeController.isListLoading, false);
      expect(homeController.isError, false);
      expect(homeController.isLoading, false);
      expect(homeController.listBooks.length, 1);
      expect(homeController.listBooks.first.volumeInfo!.title, "IEEE VLSI Test Symposium");
    });

    test("getBooks not first with success", () async {
      when(() => mockApi.getBooks(query: query, index: 1)).thenAnswer((invocation) => Future.value(ExampleModel.books));
      when(() => mockApi.getBooks(query: query, index: 2)).thenAnswer((invocation) => Future.value(ExampleModel.books));
      await homeController.getBooks(query: query, isFirst: false);
      await homeController.getBooks(query: query, isFirst: false);

      expect(homeController.isListLoading, false);
      expect(homeController.isError, false);
      expect(homeController.isLoading, false);
      expect(homeController.listBooks.length, 3);
      expect(homeController.listBooks.first.volumeInfo!.title, "IEEE VLSI Test Symposium");
    });

    test("getBooks with error", () async {
      when(() => mockApi.getBooks(query: query, index: 0)).thenAnswer((invocation) => Future.value(null));
      await homeController.getBooks(query: query, isFirst: true);

      expect(homeController.isListLoading, false);
      expect(homeController.isError, true);
      expect(homeController.isLoading, false);
      expect(homeController.listBooks.length, 0);
    });
  });
}
