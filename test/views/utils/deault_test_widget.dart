import 'package:bookstore/views/views.dart';
import 'package:flutter/material.dart';

class DefaultTestWidget extends StatefulWidget {
  final Widget widget;
  const DefaultTestWidget({Key? key, required this.widget}) : super(key: key);

  @override
  State<DefaultTestWidget> createState() => _DefaultTestWidgetState();
}

class _DefaultTestWidgetState extends State<DefaultTestWidget> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      title: "",
      body: widget.widget,
    );
  }
}
