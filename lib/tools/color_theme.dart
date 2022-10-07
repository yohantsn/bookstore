import 'package:flutter/material.dart';

class BookStoreTheme {
  static ThemeData get light => ThemeData(
        primaryColor: const Color(0xFFBEEDE2),
        backgroundColor: const Color(0xFFDFDFDF),
        brightness: Brightness.light,
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Color(0xFFBEEDE2)),
      );
}
