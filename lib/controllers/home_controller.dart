import 'dart:convert';

import 'package:bookstore/data/api/book_store_api.dart';
import 'package:bookstore/data/models/models.dart';
import 'package:bookstore/data/persistence/book_store_persistence.dart';
import 'package:bookstore/tools/injection.dart';
import 'package:flutter/material.dart';

abstract class IHomeController extends ChangeNotifier {
  Future<List<BookModel>> getBooks({String? q, required int page});
  void saveFavorite(int index);
  String get query;
  int get currentPage;
  @override
  void dispose();
}

class HomeController extends ChangeNotifier implements IHomeController {
  final IBookStoreApi _bookStoreApi;
  final IBookStorePersistence _bookStorePersistence;

  HomeController({
    IBookStoreApi? bookStoreApi,
    IBookStorePersistence? bookStorePersistence,
  })  : _bookStoreApi = bookStoreApi ?? Injection.instance.bookStoreApi,
        _bookStorePersistence = bookStorePersistence ?? Injection.instance.bookStorePersistence;

  final _listBooks = <BookModel>[];

  String _query = "";
  int _currentPage = 0;

  @override
  String get query => _query;

  @override
  int get currentPage => _currentPage;

  @override
  Future<List<BookModel>> getBooks({String? q, required int page}) async {
    final listBooks = <BookModel>[];
    _currentPage = page;
    if (q != null && q.isNotEmpty) {
      if (_query != q) {
        _query = q;
        _listBooks.clear();
      }
      try {
        final books = await _bookStoreApi.getBooks(query: _query, index: page);
        if (books != null) {
          listBooks.addAll(books);
          _listBooks.addAll(books);
        }
      } on Object catch (_) {
        throw (Exception());
      }
    }

    return listBooks;
  }

  @override
  void saveFavorite(int index) {
    final favoritesBooks = _stringToBookModel(_bookStorePersistence.read(key: "books") ?? "");
    favoritesBooks.add(_listBooks[index]);
    _bookStorePersistence.write(key: "books", data: _bookModelToString(favoritesBooks));
  }

  @override
  void dispose() {
    _query = "";
    _currentPage = 0;
    super.dispose();
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
