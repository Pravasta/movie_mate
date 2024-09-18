import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/exception/api_exception.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/datasources/movie_datasource/movie_remote_datasource.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Result>>> getSearchMovies(String query);
}

class SearchRepositoryImpl implements SearchRepository {
  final MovieRemoteDatasource _remoteDatasource;

  SearchRepositoryImpl({required MovieRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, List<Result>>> getSearchMovies(String query) async {
    try {
      final call = await _remoteDatasource.searchMovie(query);
      return Right(call.results!);
    } on SocketException {
      throw Left(ConnectionFailure());
    } on ApiException catch (e) {
      throw Left(ServerFailure(message: '${e.message}'));
    }
  }

  factory SearchRepositoryImpl.create() {
    return SearchRepositoryImpl(
      remoteDatasource: MovieRemoteDatasourceImpl.create(),
    );
  }
}
