import 'package:bookstore/data/models/book_model.dart';
import 'package:bookstore/tools/strings_util.dart';
import 'package:bookstore/views/widgets/image_network_default.dart';
import 'package:bookstore/views/widgets/scaffold_default.dart';
import 'package:bookstore/views/widgets/text_default.dart';
import 'package:flutter/material.dart';

class BookDetailsView extends StatefulWidget {
  final BookModel book;

  const BookDetailsView({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      title: StringUtil.detailsTitle,
      hasBottomNavigator: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
                child: Column(
                  children: [
                    ImageNetworkDefault(
                      imageSrc: widget.book.volumeInfo?.imageLinks?.thumbnail ?? "",
                      fit: BoxFit.contain,
                      size: ImageSize.large,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 10),
                          child: TextDefault(
                            text: widget.book.volumeInfo?.title ?? "",
                            size: TextSize.xlarge,
                            weight: TextWeight.large,
                            align: TextAlign.left,
                            overflow: TextOverflow.visible,
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: TextDefault(
                              text: widget.book.volumeInfo?.authors ?? "",
                              size: TextSize.large,
                              weight: TextWeight.large,
                              align: TextAlign.left,
                              overflow: TextOverflow.visible,
                              opacity: 0.75,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextDefault(
                      text: widget.book.volumeInfo?.description ?? "",
                      size: TextSize.medium,
                      weight: TextWeight.small,
                      align: TextAlign.left,
                      overflow: TextOverflow.visible,
                      opacity: 0.8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 38, 14, 14),
            child: MaterialButton(
              minWidth: 350,
              height: 50,
              onPressed: () {},
              color: Theme.of(context).primaryColor,
              child: TextDefault(
                text: StringUtil.detailsButtonBuy,
                size: TextSize.medium,
                weight: TextWeight.large,
                align: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
