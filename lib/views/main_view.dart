import 'package:bookstore/views/favorites_view.dart';
import 'package:bookstore/views/home_view.dart';
import 'package:bookstore/views/widgets/scaffold_default.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldDefault(
      title: "",
      hasAppBar: false,
      bodyItems: [
        HomeView(),
        FavoritesView(),
      ],
    );
  }
}
