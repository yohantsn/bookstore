import 'package:bookstore/tools/strings_util.dart';
import 'package:bookstore/views/widgets/image_network_default.dart';
import 'package:bookstore/views/widgets/text_default.dart';
import 'package:flutter/material.dart';

class FavoriteItemListing extends StatelessWidget {
  final String imageSrc;
  final String title;
  final String subTitle;
  final VoidCallback onFavoriteTap;
  final VoidCallback onItemTap;

  final bool isFavorite;

  const FavoriteItemListing({
    Key? key,
    required this.imageSrc,
    required this.subTitle,
    required this.title,
    required this.onFavoriteTap,
    required this.onItemTap,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              key: key,
              constraints: const BoxConstraints(
                minHeight: 153.0,
                maxHeight: 160.0,
              ),
              child: Row(
                children: [
                  ImageNetworkDefault(
                    imageSrc: imageSrc,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
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
                  )),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0.1,
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: 24,
                ),
                onPressed: onFavoriteTap,
              ),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
