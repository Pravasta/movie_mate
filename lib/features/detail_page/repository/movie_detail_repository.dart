import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/datasources/movie_datasource/movie_remote_datasource.dart';
import 'package:movie_mate/data/datasources/watchlist_movie_datasource/watchlist_movie_remote_datasource.dart';
import 'package:movie_mate/data/model/response/movie_detail_response_model.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';

import '../../../core/exception/exception.dart';

abstract class MovieDetailRepository {
  Future<Either<Failure, MovieDetailResponseModel>> getDetailMovie(int id);
  Future<Either<String, String>> addWatchlistMovie(Result data);
  Future<Either<String, String>> removeWatchlistMovie(int id);
  Future<bool> isAddedToWatchlist(int id);
}

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieRemoteDatasource _remoteDatasource;
  final WatchlistMovieRemoteDatasource _watchlistMovieRemoteDatasource;

  MovieDetailRepositoryImpl({
    required MovieRemoteDatasource remoteDatasource,
    required WatchlistMovieRemoteDatasource watchlistMovieRemoteDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _watchlistMovieRemoteDatasource = watchlistMovieRemoteDatasource;

  @override
  Future<Either<Failure, MovieDetailResponseModel>> getDetailMovie(
      int id) async {
    try {
      final call = await _remoteDatasource.getDetailMovie(id);
      return Right(call);
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    }
  }

  @override
  Future<Either<String, String>> addWatchlistMovie(Result data) async {
    try {
      await _watchlistMovieRemoteDatasource.insertWatchlistMovie(data);
      return const Right('Movie added to Watchlistt.');
    } catch (e) {
      throw Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    try {
      final call = await _watchlistMovieRemoteDatasource.getMovieById(id);
      return call != null;
    } catch (e) {
      throw Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<String, String>> removeWatchlistMovie(int id) async {
    try {
      await _watchlistMovieRemoteDatasource.deleteWatchlistMovie(id);
      return const Right('Movie removed from Watchlistt.');
    } catch (e) {
      throw Left(ApiException(message: e.toString()));
    }
  }

  factory MovieDetailRepositoryImpl.create() {
    return MovieDetailRepositoryImpl(
      remoteDatasource: MovieRemoteDatasourceImpl.create(),
      watchlistMovieRemoteDatasource:
          WatchlistMovieRemoteDatasourceImpl.create(),
    );
  }
}
