import 'package:bookstore/tools/tools.dart';
import 'package:bookstore/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeError extends StatelessWidget {
  const HomeError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageAssetDefault(
          imageSrc: AssetsUtil.errorImage,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: TextDefault(
                  text: StringUtil.erroToSearchBook,
                  opacity: 0.9,
                  size: TextSize.large,
                  align: TextAlign.center,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
