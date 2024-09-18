import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/exception/exception.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/datasources/watchlist_movie_datasource/watchlist_movie_remote_datasource.dart';

abstract class WatchlistMovieRepository {
  Future<Either<Failure, List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
      getWatchlistMovie();
}

class WatchlistMovieRepositoryImpl implements WatchlistMovieRepository {
  final WatchlistMovieRemoteDatasource _remoteDatasource;

  WatchlistMovieRepositoryImpl({
    required WatchlistMovieRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
      getWatchlistMovie() async {
    try {
      final call = await _remoteDatasource.getAllWatchlistMovie();
      return Right(call.docs);
    } on SocketException {
      throw Left(ConnectionFailure());
    } on ApiException catch (e) {
      throw Left(ServerFailure(message: '${e.message}'));
    }
  }

  factory WatchlistMovieRepositoryImpl.create() {
    return WatchlistMovieRepositoryImpl(
      remoteDatasource: WatchlistMovieRemoteDatasourceImpl.create(),
    );
  }
}
