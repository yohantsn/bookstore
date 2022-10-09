import 'package:bookstore/data/repositories.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'utils/example_response.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();
  late IBookStoreApi bookStoreApi;
  final path = "${BaseEndpoints.baseUrl}${BaseEndpoints.volumesPath}";
  final queryParameters = {
    "q": "test",
    "maxResults": 20,
    "startIndex": 0,
  };

  setUpAll(() {
    bookStoreApi = BookStoreApi(dio: mockDio);
    when(() => mockDio.get(path, queryParameters: queryParameters)).thenAnswer(
        (_) => Future.value(Response(requestOptions: RequestOptions(path: path), data: ExampleResponse.success)));
  });

  group("BookStoreApi", () {
    test("when return success", () async {
      when(() => mockDio.get(path, queryParameters: queryParameters)).thenAnswer(
        (_) => Future.value(
          Response(
            requestOptions: RequestOptions(path: path),
            data: ExampleResponse.success,
          ),
        ),
      );
      final books = await bookStoreApi.getBooks(query: "test", index: 0);

      expect(books?.length, 5);
      expect(books?.first.volumeInfo?.title, "IEEE VLSI Test Symposium");
    });

    test("when throw", () async {
      when(() => mockDio.get(path, queryParameters: queryParameters)).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
            requestOptions: RequestOptions(path: path),
            data: ExampleResponse.erro,
          ),
          error: 400,
        ),
      );
      expectLater(bookStoreApi.getBooks(query: "test", index: 0), throwsException);
    });

    test("when return success , but items is empty", () async {
      when(() => mockDio.get(path, queryParameters: queryParameters)).thenAnswer(
        (_) => Future.value(
          Response(
            requestOptions: RequestOptions(path: path),
            data: ExampleResponse.itemsEmpty,
          ),
        ),
      );
      final books = await bookStoreApi.getBooks(query: "test", index: 0);

      expect(books?.length, 0);
    });
  });
}
