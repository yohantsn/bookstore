import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextSize {
  ///10
  xsmall,

  /// 12.0
  small,

  /// 14.0
  medium,

  /// 16.0
  large,

  /// 24.0
  xlarge,
}

enum TextWeight {
  /// w300
  small,

  /// w400
  medium,

  /// w500
  large,
}

extension TextSizeUtil on TextSize {
  double get toDouble {
    switch (this) {
      case TextSize.xsmall:
        return 10.0;
      case TextSize.small:
        return 12.0;
      case TextSize.medium:
        return 14.0;
      case TextSize.large:
        return 16.0;
      case TextSize.xlarge:
        return 24.0;
    }
  }
}

extension TextWeightUtil on TextWeight {
  FontWeight get toFontWeight {
    switch (this) {
      case TextWeight.small:
        return FontWeight.w300;
      case TextWeight.medium:
        return FontWeight.w400;
      case TextWeight.large:
        return FontWeight.w500;
    }
  }
}

class TextDefault extends StatelessWidget {
  final TextSize size;
  final String text;
  final TextWeight weight;
  final TextAlign align;
  final double opacity;
  final TextOverflow overflow;
  const TextDefault({
    Key? key,
    required this.text,
    this.size = TextSize.small,
    this.weight = TextWeight.medium,
    this.align = TextAlign.left,
    this.opacity = 1,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      style: GoogleFonts.lora(
        fontSize: size.toDouble,
        fontWeight: weight.toFontWeight,
        color: const Color(0xFF000000).withOpacity(opacity),
      ),
    );
  }
}
