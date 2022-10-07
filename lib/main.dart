import 'package:bookstore/data/api/book_store_api.dart';
import 'package:bookstore/data/persistence/book_store_persistence.dart';
import 'package:bookstore/tools/color_theme.dart';
import 'package:bookstore/tools/injection.dart';
import 'package:bookstore/views/main_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Injection(
    bookStoreApi: BookStoreApi(),
    bookStorePersistence: BookStorePersistence(),
  );

  runApp(MaterialApp(
    home: const MainView(),
    theme: BookStoreTheme.light,
  ));
}
