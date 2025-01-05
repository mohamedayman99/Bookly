import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/presentation/manger/newset_books_cubit/newest_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.books.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BookListViewItem(
            image:
                widget.books[index].image ?? "https://via.placeholder.com/150",
            authorName: widget.books[index].authorName.toString(),
            price: widget.books[index].price.toString(),
            rate: widget.books[index].rating ?? 0.0,
          ),
        );
      },
    );
  }
}
