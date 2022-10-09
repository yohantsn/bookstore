import 'dart:convert';

import 'package:bookstore/data/models/models.dart';
import 'package:bookstore/data/persistence/book_store_persistence.dart';
import 'package:bookstore/tools/injection.dart';
import 'package:flutter/material.dart';

abstract class IFavoritesController extends ChangeNotifier {
  Future<void> getBooks();
  void removeFavorite(int index);
  List<BookModel> get listBooks;
  bool get isLoading;
}

class FavoritesController extends ChangeNotifier implements IFavoritesController {
  final IBookStorePersistence _bookStorePersistence;

  FavoritesController({
    IBookStorePersistence? bookStorePersistence,
  }) : _bookStorePersistence = bookStorePersistence ?? Injection.instance.bookStorePersistence;

  @override
  List<BookModel> get listBooks => _listBooks;
  @override
  bool get isLoading => _isLoading;

  final _listBooks = <BookModel>[];
  bool _isLoading = false;

  @override
  Future<void> getBooks() async {
    _isLoading = true;
    notifyListeners();

    _listBooks.clear();
    final books = _bookStorePersistence.read(key: "books") ?? "";
    _listBooks.addAll(_stringToBookModel(books));
    _isLoading = false;
    notifyListeners();
  }

  @override
  void removeFavorite(int index) async {
    _listBooks.removeAt(index);
    _bookStorePersistence.write(key: "books", data: _bookModelToString(_listBooks)).then((value) => notifyListeners());
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
