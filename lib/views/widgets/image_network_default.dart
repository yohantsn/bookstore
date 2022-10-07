import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

enum ImageSize {
  /// w-> 163.00 x h 139.00
  small,

  /// w-> 209.00 x h 336.00
  large,
}

extension ImageSizeUtil on ImageSize {
  double get height {
    switch (this) {
      case ImageSize.small:
        return 139.0;
      case ImageSize.large:
        return 336.0;
    }
  }

  double get width {
    switch (this) {
      case ImageSize.small:
        return 163.0;
      case ImageSize.large:
        return 209.0;
    }
  }
}

class ImageNetworkDefault extends StatelessWidget {
  final String imageSrc;
  final ImageSize size;
  final BoxFit fit;

  const ImageNetworkDefault({
    Key? key,
    required this.imageSrc,
    this.size = ImageSize.small,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Image.network(
        imageSrc,
        height: size.height,
        width: size.width,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return FadeShimmer(
            height: size.height,
            width: size.width,
            baseColor: Theme.of(context).primaryColor,
            highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          height: size.height,
          width: size.width,
          color: Colors.grey,
        ),
      ),
    );
  }
}
