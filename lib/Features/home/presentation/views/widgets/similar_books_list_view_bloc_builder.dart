import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/presentation/manger/newset_books_cubit/newest_books_cubit.dart';
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
    return BlocConsumer<NewestBooksCubit, NewestBooksState>(
      listener: (context, state) {
        if (state is NewestBooksSuccess) {
          books.addAll(state.books);
        }

        if (state is NewestBooksPaginationFailure) {}
      },
      builder: (context, state) {
        if (state is NewestBooksSuccess) {
          return SimilarBooksListview(
            books: state.books,
          );
        } else if (state is NewestBooksFailure) {
          return Text(state.errMessage);
        }
        // else {
        //   return const CircularProgressIndicator();
        // }
        return SimilarBooksListview(
          books: books,
        );
      },
    );
  }
}
