import 'dart:convert';

import 'package:bookstore/data/api/book_store_api.dart';
import 'package:bookstore/data/models/models.dart';
import 'package:bookstore/data/persistence/book_store_persistence.dart';
import 'package:bookstore/tools/injection.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final IBookStoreApi _bookStoreApi;
  final IBookStorePersistence _bookStorePersistence;

  HomeController({
    IBookStoreApi? bookStoreApi,
    IBookStorePersistence? bookStorePersistence,
  })  : _bookStoreApi = bookStoreApi ?? Injection.instance.bookStoreApi,
        _bookStorePersistence =
            bookStorePersistence ?? Injection.instance.bookStorePersistence;

  final _listBooks = <BookModel>[];
  bool isLoading = false;
  bool isListLoading = false;
  bool isError = false;
  String query = "";

  Future<List<BookModel>> getBooks({String? q, required int page}) async {
    final listBooks = <BookModel>[];
    if (q != null && query != q) {
      query = q;
      _listBooks.clear();
    }
    final books = await _bookStoreApi.getBooks(query: query, index: page);
    if (books != null) {
      listBooks.addAll(books);
      _listBooks.addAll(books);
    }

    return listBooks;
  }

  void setError() {
    isLoading = false;
    isListLoading = false;
    isError = true;

    notifyListeners();
  }

  void saveFavorite(int index) {
    final favoritesBooks =
        _stringToBookModel(_bookStorePersistence.read(key: "books") ?? "");
    favoritesBooks.add(_listBooks[index]);
    _bookStorePersistence.write(
        key: "books", data: _bookModelToString(favoritesBooks));
  }

  List<BookModel> _stringToBookModel(String strBooks) {
    final books = <BookModel>[];
    if (strBooks.isNotEmpty) {
      final items = jsonDecode(strBooks);
      for (var i = 0; i < (items as List).length; i++) {
        books.add(BookModel.fromJson(items[i]));
      }
    }

    return books;
  }

  String _bookModelToString(List<BookModel> books) {
    final listStrFavorite = <Map<String, dynamic>>[];
    for (var i = 0; i < books.length; i++) {
      listStrFavorite.add(books[i].toJson());
    }

    return jsonEncode(listStrFavorite);
  }
}
