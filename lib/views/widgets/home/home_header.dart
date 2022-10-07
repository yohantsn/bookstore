import 'package:bookstore/tools/strings_util.dart';
import 'package:bookstore/views/widgets/text_default.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HomeHeader extends StatelessWidget {
  ValueChanged<String>? onSubmitted;
  ValueChanged<String>? onChanged;

  HomeHeader({Key? key, this.onSubmitted, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.fromLTRB(24.0, 56, 24.0, 20.0),
      height: 181,
      child: Card(
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 1,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 23.5, 12, 4),
                    child: TextDefault(
                      text: StringUtil.homeTitle,
                      size: TextSize.xlarge,
                      opacity: 0.8,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 32.5),
                    child: TextDefault(
                      text: StringUtil.homeSubTitle,
                      size: TextSize.medium,
                      opacity: 0.6,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 35, 20),
              child: TextField(
                onSubmitted: onSubmitted,
                onChanged: onChanged,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Color(0xFFCBD2E0),
                      width: 1,
                    ),
                  ),
                  alignLabelWithHint: true,
                  constraints: const BoxConstraints(maxHeight: 44),
                  filled: true,
                  fillColor: const Color(0xFFFAFAFA),
                  prefixIcon: Icon(
                    Icons.search,
                    color: primaryColor,
                    size: 20,
                  ),
                  hintText: StringUtil.homeSearchHint,
                  hintTextDirection: TextDirection.ltr,
                  hintStyle: GoogleFonts.lora(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFBABABA),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
