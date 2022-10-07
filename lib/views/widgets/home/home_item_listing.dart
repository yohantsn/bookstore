import 'package:bookstore/views/widgets/image_network_default.dart';
import 'package:bookstore/views/widgets/text_default.dart';
import 'package:flutter/material.dart';

class HomeItemListing extends StatelessWidget {
  final String imageSrc;
  final String title;
  final String subTitle;
  final VoidCallback onFavoriteTap;
  final VoidCallback onItemTap;

  final bool isFavorite;

  const HomeItemListing({
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
    return Stack(
      children: [
        InkWell(
          onTap: onItemTap,
          child: Container(
            key: key,
            constraints: const BoxConstraints(minHeight: 220.0, maxHeight: 230.0),
            width: 163.0,
            child: Column(
              children: [
                ImageNetworkDefault(
                  imageSrc: imageSrc,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: TextDefault(
                          text: title,
                          opacity: 0.9,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: TextDefault(
                          text: subTitle,
                          weight: TextWeight.small,
                          opacity: 0.6,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 12,
          top: 0,
          child: IconButton(
            icon: Icon(
              Icons.favorite,
              color: isFavorite ? Colors.red : Colors.grey,
              size: 26,
            ),
            onPressed: onFavoriteTap,
          ),
        )
      ],
    );
  }
}
