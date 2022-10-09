import 'package:bookstore/tools/tools.dart';
import 'package:bookstore/views/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FavoriteItemListing extends StatelessWidget {
  final String imageSrc;
  final String title;
  final String subTitle;
  final Function(DismissDirection) onDismissed;
  final VoidCallback onItemTap;

  const FavoriteItemListing({
    required Key key,
    required this.imageSrc,
    required this.subTitle,
    required this.title,
    required this.onDismissed,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 24,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        constraints: const BoxConstraints(
          minHeight: 153.0,
          maxHeight: 160.0,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ImageNetworkDefault(
                  imageSrc: imageSrc,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 12,
                              ),
                              child: TextDefault(
                                text: title,
                                overflow: title.length < 28 ? TextOverflow.visible : TextOverflow.ellipsis,
                                opacity: 0.9,
                                size: TextSize.large,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 12,
                              ),
                              child: TextDefault(
                                text: subTitle,
                                weight: TextWeight.small,
                                opacity: 0.6,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: MaterialButton(
                          minWidth: 163,
                          height: 37,
                          onPressed: onItemTap,
                          color: Theme.of(context).primaryColor,
                          child: TextDefault(
                            text: StringUtil.detailsButton,
                            size: TextSize.medium,
                            weight: TextWeight.large,
                            align: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
