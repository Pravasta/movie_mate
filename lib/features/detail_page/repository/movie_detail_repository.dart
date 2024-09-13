import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/datasources/movie_datasource/movie_remote_datasource.dart';
import 'package:movie_mate/data/model/response/movie_detail_response_model.dart';

import '../../../core/exception/exception.dart';

abstract class MovieDetailRepository {
  Future<Either<Failure, MovieDetailResponseModel>> getDetailMovie(int id);
}

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieRemoteDatasource _remoteDatasource;

  MovieDetailRepositoryImpl({required MovieRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

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

  factory MovieDetailRepositoryImpl.create() {
    return MovieDetailRepositoryImpl(
      remoteDatasource: MovieRemoteDatasourceImpl.create(),
    );
  }
}
