import 'package:bookstore/controllers/controllers.dart';
import 'package:bookstore/controllers/favorites_controller.dart';
import 'package:bookstore/controllers/home_controller.dart';
import 'package:bookstore/data/api/book_store_api.dart';
import 'package:bookstore/data/persistence/book_store_persistence.dart';

import 'package:bookstore/tools/tools.dart';
import 'package:bookstore/views/views.dart';
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
