import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/datasources/movie_datasource/movie_remote_datasource.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';

import '../../../core/exception/exception.dart';

abstract class MovieHomeRepository {
  Future<Either<Failure, List<Result>>> getNowPlayingMovies();
  Future<Either<Failure, List<Result>>> getUpComingMovies();
}

class MovieHomeRepositoryImpl implements MovieHomeRepository {
  final MovieRemoteDatasource _remoteDatasource;

  MovieHomeRepositoryImpl({required MovieRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, List<Result>>> getNowPlayingMovies() async {
    try {
      final call = await _remoteDatasource.getNowPlayingMovies();
      return Right(call.results!);
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Result>>> getUpComingMovies() async {
    try {
      final call = await _remoteDatasource.getUpComingMovies();
      return Right(call.results!);
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    }
  }

  factory MovieHomeRepositoryImpl.create() {
    return MovieHomeRepositoryImpl(
      remoteDatasource: MovieRemoteDatasourceImpl.create(),
    );
  }
}
