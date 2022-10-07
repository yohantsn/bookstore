import 'package:bookstore/controllers/home_controller.dart';
import 'package:bookstore/data/models/book_model.dart';
import 'package:bookstore/views/book_details_view.dart';
import 'package:bookstore/views/widgets/home/home_header.dart';
import 'package:bookstore/views/widgets/home/home_item_listing.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();
  final scrollController = ScrollController();
  final _pagingController = PagingController<int, BookModel>(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _fetchPage(0, query: "ios");

    super.initState();
  }

  Future<void> _fetchPage(int pageKey, {String? query}) async {
    try {
      if (pageKey == 0) {
        _pagingController.refresh();
      }
      final newItems = await controller.getBooks(page: pageKey, q: query);
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(newItems, nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: HomeHeader(
            onChanged: (value) => _fetchPage(0, query: value),
          ),
        ),
        const Divider(),
        Expanded(
          flex: 5,
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
                imageSrc: item.volumeInfo?.imageLinks?.thumbnail ?? "",
                subTitle: item.volumeInfo?.authors ?? "",
                title: item.volumeInfo?.title ?? "",
                onFavoriteTap: () => controller.saveFavorite(index),
                onItemTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailsView(
                      book: item,
                    ),
                  ),
                ),
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
            ),
          ),
        ),
      ],
    );
  }
}
