import 'package:bookstore/controllers/favorites_controller.dart';
import 'package:bookstore/tools/strings_util.dart';
import 'package:bookstore/views/book_details_view.dart';
import 'package:bookstore/views/widgets/favorites/favorite_item_listing.dart';

import 'package:bookstore/views/widgets/text_default.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final controller = FavoritesController();

  @override
  void initState() {
    controller.getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextDefault(
                    text: StringUtil.favoritesTitle,
                    size: TextSize.xlarge,
                    weight: TextWeight.large,
                    align: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: controller.listBooks.length,
                itemBuilder: (context, index) {
                  final book = controller.listBooks[index];
                  return FavoriteItemListing(
                    imageSrc: book.volumeInfo?.imageLinks?.thumbnail ?? "",
                    subTitle: book.volumeInfo?.authors ?? "",
                    title: book.volumeInfo?.title ?? "",
                    isFavorite: true,
                    onFavoriteTap: () => controller.removeFavorite(index),
                    onItemTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsView(
                          book: book,
                        ),
                      ),
                    ),
                  );
                });
          },
        ))
      ],
    );
  }
}
