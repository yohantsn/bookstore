import 'package:bookstore/data/api/base_endpoints.dart';
import 'package:bookstore/data/models/models.dart';
import 'package:dio/dio.dart';

abstract class IBookStoreApi {
  Future<List<BookModel>?> getBooks({required String query, int? index});
}

class BookStoreApi implements IBookStoreApi {
  late final Dio _dio;

  BookStoreApi({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<List<BookModel>?> getBooks({required String query, int? index}) async {
    final path = "${BaseEndpoints.baseUrl}${BaseEndpoints.volumesPath}";
    final queryParameters = {
      "q": query,
      "maxResults": 20,
      "startIndex": index,
    };

    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      final books = <BookModel>[];
      if (response.data["items"] != null && response.data["items"] is List) {
        for (var i = 0; i < (response.data["items"] as List).length; i++) {
          final jsonBook = response.data["items"][i];
          books.add(BookModel.fromJson(jsonBook));
        }
      }

      return books;
    } on Object catch (_) {
      rethrow;
    }
  }
}
