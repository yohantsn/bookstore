import 'package:bookstore/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ImageAssetDefault extends StatelessWidget {
  final String imageSrc;
  final ImageSize size;
  final BoxFit fit;

  const ImageAssetDefault({
    Key? key,
    required this.imageSrc,
    this.size = ImageSize.large,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Image.asset(
        imageSrc,
        height: size.height,
        width: size.width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Container(
          height: size.height,
          width: size.width,
          color: Colors.grey,
        ),
      ),
    );
  }
}
