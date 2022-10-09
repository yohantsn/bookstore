import 'dart:convert';

import 'package:bookstore/data/persistence/book_store_persistence.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/example_response.dart';

class MockPrefs extends Mock implements SharedPreferences {}

void main() {
  final mockPrefs = MockPrefs();
  late IBookStorePersistence bookStorePersistence;
  const key = "books";
  const data = "books";
  final value = jsonEncode(ExampleResponse.success["items"]);

  setUpAll(() {
    bookStorePersistence = BookStorePersistence(persistence: mockPrefs);
  });

  group("BookStorePersistence", () {
    test("getString when return success", () async {
      when(() => mockPrefs.getString(key)).thenAnswer((_) => value);
      final booksStr = bookStorePersistence.read(key: key);

      expect(booksStr, jsonEncode(ExampleResponse.success["items"]));
    });

    test("getString when success but persistence return null", () async {
      when(() => mockPrefs.getString(key)).thenAnswer((_) => null);
      final booksStr = bookStorePersistence.read(key: key);

      expect(booksStr, "");
    });

    test("getString when occur error", () async {
      when(() => mockPrefs.getString(key)).thenThrow(Exception());
      final booksStr = bookStorePersistence.read(key: key);

      expect(booksStr, null);
    });

    test("setString when occur error", () async {
      when(() => mockPrefs.setString(key, data)).thenThrow(Exception());
      expectLater(bookStorePersistence.write(key: key, data: data), throwsException);
    });
    test("delete when occur error", () async {
      when(() => mockPrefs.remove(key)).thenThrow(Exception());
      expectLater(bookStorePersistence.delete(key: key), throwsException);
    });
  });
}
