import 'package:bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import 'package:bookly/core/errors/failure.dart';

import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:dio/dio.dart';

import '../../domain/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl(
      {required this.homeRemoteDataSource, required this.homeLocalDataSource});
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks(
      {int pageNumber = 0}) async {
    List<BookEntity> booksList;
    try {
      booksList = homeLocalDataSource.fetchFeaturedBooks(
        pageNumber: pageNumber,
      );
      if (booksList.isNotEmpty) {
        return right(booksList);
      }
      booksList =
          await homeRemoteDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      return right(booksList);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks({int pageNumber = 0}) async {
    try {
      List<BookEntity> books;
      books = homeLocalDataSource.fetchNewestBooks(pageNumber: pageNumber,);
      if (books.isNotEmpty) {
        return right(books);
      }
      books = await homeRemoteDataSource.fetchNewestBooks(pageNumber: pageNumber);
      return right(books);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchSimilarBooks({int pageNumber = 0}) async {
    try {
      List<BookEntity> books;
      books = homeLocalDataSource.fetchSimilarBooks(pageNumber: pageNumber,);
      if (books.isNotEmpty) {
        return right(books);
      }
      books = await homeRemoteDataSource.fetchSimilarBooks(pageNumber: pageNumber);
      return right(books);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
