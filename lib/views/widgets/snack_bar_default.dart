import 'package:bookstore/tools/tools.dart';
import 'package:bookstore/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SnackBarDefault {
  static SnackBar get favoriteSuccess => _snackbar(StringUtil.favoritesSaveSuccess);
  static SnackBar get favoriteRemoved => _snackbar(StringUtil.favoritesRemoved);

  static SnackBar _snackbar(String text) => SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: BookStoreTheme.light.primaryColor,
        content: TextDefault(text: text),
      );
}
