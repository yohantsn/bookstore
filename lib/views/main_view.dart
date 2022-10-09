import 'package:bookstore/controllers/controllers.dart';
import 'package:bookstore/views/views.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      title: "",
      hasAppBar: false,
      bodyItems: [
        HomeView(
          controller: HomeController(),
        ),
        FavoritesView(
          controller: FavoritesController(),
        ),
      ],
    );
  }
}
