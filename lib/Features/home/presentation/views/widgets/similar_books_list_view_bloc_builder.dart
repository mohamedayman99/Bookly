import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/presentation/manger/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly/Features/home/presentation/views/widgets/similar_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarListViewBlocBuilder extends StatefulWidget {
  const SimilarListViewBlocBuilder({
    super.key,
  });

  @override
  State<SimilarListViewBlocBuilder> createState() =>
      _FeatuedBooksListViewBlocBuilderState();
}

class _FeatuedBooksListViewBlocBuilderState
    extends State<SimilarListViewBlocBuilder> {
  List<BookEntity> books = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SimilarBooksCubit, SimilarBooksState>(
      listener: (context, state) {
        if (state is SimilarBooksSuccess) {
          books.addAll(state.books);
        }

        if (state is SimilarBooksPaginationFailure) {}
      },
      builder: (context, state) {
        if (state is SimilarBooksSuccess ||
            state is SimilarBooksPaginationLoading ||
            state is SimilarBooksPaginationFailure) {
          return SimilarBooksListview(
            books: books,
          );
        } else if (state is SimilarBooksFailure) {
          return Text(state.errMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
