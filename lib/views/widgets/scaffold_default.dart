import 'package:bookstore/tools/strings_util.dart';
import 'package:bookstore/views/widgets/text_default.dart';
import 'package:flutter/material.dart';

class ScaffoldDefault extends StatefulWidget {
  final String title;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool hasAppBar;
  final bool hasLeading;
  final bool hasBottomNavigator;
  final List<Widget>? bodyItems;
  const ScaffoldDefault({
    Key? key,
    required this.title,
    this.body,
    this.bottomNavigationBar,
    this.hasAppBar = true,
    this.hasLeading = true,
    this.hasBottomNavigator = true,
    this.bodyItems,
  }) : super(key: key);

  @override
  State<ScaffoldDefault> createState() => _ScaffoldDefaultState();
}

class _ScaffoldDefaultState extends State<ScaffoldDefault> {
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: widget.hasAppBar
          ? AppBar(
              title: TextDefault(
                text: widget.title,
                size: TextSize.xlarge,
                weight: TextWeight.large,
                align: TextAlign.center,
              ),
              backgroundColor: Colors.white,
              leading: widget.hasLeading
                  ? IconButton(
                      icon: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: Color(0xFF279F82),
                        size: 28,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  : Container(),
            )
          : null,
      body: widget.hasBottomNavigator
          ? widget.bodyItems != null
              ? widget.bodyItems![_selectedIndex]
              : Container()
          : widget.body,
      bottomNavigationBar: widget.hasBottomNavigator
          ? BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: StringUtil.bottomBarHome,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                  label: StringUtil.bottomBarFavorites,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              backgroundColor: const Color(0xFFF4F4F4),
              onTap: _onItemTapped,
            )
          : null,
    ));
  }
}
