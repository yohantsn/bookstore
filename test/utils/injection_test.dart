import 'package:bookstore/data/persistence/book_store_persistence.dart';
import 'package:bookstore/data/repositories.dart';
import 'package:bookstore/tools/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group("Injection", () {
    test("not instantiated", () {
      expect(() => Injection.instance.bookStoreApi, throwsA(isA<InjectionException>()));
    });
    test("instantiated with success", () {
      final persistence = BookStorePersistence();
      final api = BookStoreApi();
      Injection(bookStoreApi: api, bookStorePersistence: persistence);

      expect(Injection.instance.bookStoreApi, api);
      expect(Injection.instance.bookStorePersistence, persistence);
    });
  });
}
