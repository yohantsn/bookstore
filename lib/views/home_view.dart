import 'package:bookstore/controllers/controllers.dart';
import 'package:bookstore/data/models/models.dart';
import 'package:bookstore/views/views.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeView extends StatefulWidget {
  final IHomeController controller;
  const HomeView({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scrollController = ScrollController();
  final _pagingController = PagingController<int, BookModel>(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, query: widget.controller.query);
    });
    _fetchPage(
      0,
      query: "IOS",
    );

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey, {String? query}) async {
    if (pageKey != widget.controller.currentPage || query != widget.controller.query) {
      try {
        if (pageKey == 0) {
          _pagingController.refresh();
        }
        final newItems = await widget.controller.getBooks(page: pageKey, q: query);

        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      } catch (error) {
        _pagingController.error = error;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(
          key: const Key("home_header"),
          onSubmitted: (value) => _fetchPage(0, query: value),
        ),
        const Divider(),
        Expanded(
          child: PagedGridView<int, BookModel>(
            pagingController: _pagingController,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16,
            ),
            builderDelegate: PagedChildBuilderDelegate<BookModel>(
              itemBuilder: (context, item, index) => HomeItemListing(
                key: Key("home_item_listing_$index"),
                imageSrc: item.volumeInfo?.imageLinks?.thumbnail ?? "",
                subTitle: item.volumeInfo?.authors ?? "",
                title: item.volumeInfo?.title ?? "",
                onFavoriteTap: () => saveFavorite(index),
                onItemTap: () => goToDetails(item),
              ),
              firstPageProgressIndicatorBuilder: (context) => Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(maxHeight: 350),
                child: const CircularProgressIndicator.adaptive(),
              ),
              newPageProgressIndicatorBuilder: (context) => Container(
                height: 20,
                child: Row(
                  children: const [
                    Expanded(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ],
                ),
              ),
              firstPageErrorIndicatorBuilder: (_) => const HomeError(),
            ),
          ),
        ),
      ],
    );
  }

  void saveFavorite(int bookIndex) {
    widget.controller.saveFavorite(bookIndex);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarDefault.favoriteSuccess);
  }

  void goToDetails(BookModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsView(
          book: item,
          controller: DetailsController(),
        ),
      ),
    );
  }
}
