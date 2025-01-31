import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/presentation/manger/newset_books_cubit/newest_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'best_seller_list_view_item.dart';

class BestSellerListView extends StatefulWidget {
  const BestSellerListView({super.key, required this.books});

  final List<BookEntity> books;

  @override
  State<BestSellerListView> createState() => _BestSellerListViewState();
}

class _BestSellerListViewState extends State<BestSellerListView> {
  late final ScrollController _scrollController;

  int nextPage = 1;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    var currentPositions = _scrollController.position.pixels;

    var maxScrollLength = _scrollController.position.maxScrollExtent;

    if (currentPositions >= 0.7 * maxScrollLength) {
      if (!isLoading) {
        isLoading = true;
        await BlocProvider.of<NewestBooksCubit>(context)
            .fetchNewestBooks(pageNumber: nextPage++);
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .38,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.books.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          final book = widget.books[index];
          final image = book.image;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () {
                final imageUrl = image ?? "https://via.placeholder.com/150";
                final encodedImageUrl = Uri.encodeComponent(imageUrl);
                final path = '/bookDetailsView/$encodedImageUrl';

                GoRouter.of(context).push(path);
              },
              child: BookListViewItem(
                image: image ?? "https://via.placeholder.com/150",
                authorName: widget.books[index].authorName.toString(),
                price: widget.books[index].price.toString(),
                rate: widget.books[index].rating ?? 0.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
