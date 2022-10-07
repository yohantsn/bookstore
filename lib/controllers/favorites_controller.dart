import 'dart:convert';

import 'package:bookstore/data/models/models.dart';
import 'package:bookstore/data/persistence/book_store_persistence.dart';
import 'package:bookstore/tools/injection.dart';
import 'package:flutter/material.dart';

class FavoritesController extends ChangeNotifier {
  final IBookStorePersistence _bookStorePersistence;

  FavoritesController({
    IBookStorePersistence? bookStorePersistence,
  }) : _bookStorePersistence = bookStorePersistence ?? Injection.instance.bookStorePersistence;

  final listBooks = <BookModel>[];
  bool isLoading = false;
  bool isError = false;

  Future<void> getBooks() async {
    isLoading = true;
    notifyListeners();

    listBooks.clear();
    final books = _bookStorePersistence.read(key: "books") ?? "";
    listBooks.addAll(_stringToBookModel(books));
    isLoading = false;
    notifyListeners();
  }

  void setError() {
    isLoading = false;
    isError = true;

    notifyListeners();
  }

  void removeFavorite(int index) {
    final favoritesBooks = _stringToBookModel(_bookStorePersistence.read(key: "books") ?? "");
    favoritesBooks.removeWhere((element) => listBooks[index] == element);
    _bookStorePersistence.write(key: "books", data: _bookModelToString(favoritesBooks));
    getBooks();
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
