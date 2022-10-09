import 'package:bookstore/controllers/controllers.dart';
import 'package:bookstore/data/models/models.dart';
import 'package:bookstore/tools/tools.dart';
import 'package:bookstore/views/views.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget {
  final IFavoritesController controller;
  const FavoritesView({Key? key, required this.controller}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    widget.controller.getBooks();
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
          animation: widget.controller,
          builder: (context, child) {
            final books = widget.controller.listBooks;
            if (widget.controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (widget.controller.listBooks.isEmpty) {
              return Center(
                child: TextDefault(
                  text: StringUtil.favoriteListEmpty,
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(12),
              children: books.map((book) {
                final index = books.indexWhere(
                  (element) => element == book,
                );
                return FavoriteItemListing(
                  key: UniqueKey(),
                  imageSrc: book.volumeInfo?.imageLinks?.thumbnail ?? "",
                  subTitle: book.volumeInfo?.authors ?? "",
                  title: book.volumeInfo?.title ?? "",
                  onDismissed: (_) => deleteBook(index),
                  onItemTap: () => goToDetails(book),
                );
              }).toList(),
            );
          },
        ))
      ],
    );
  }

  void deleteBook(int bookIndex) {
    widget.controller.removeFavorite(bookIndex);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarDefault.favoriteRemoved);
  }

  void goToDetails(BookModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsView(
          controller: DetailsController(),
          book: item,
        ),
      ),
    );
  }
}
