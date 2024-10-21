import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/data/datasources/auth_datasource/auth_remote_datasource.dart';
import 'package:movie_mate/data/datasources/user_datasource/user_remote_datasource.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';

import '../../../core/exception/exception.dart';
import '../../../core/exception/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserResponseModel>> userData();
  Future<Either<Failure, String>> changePassword(String password);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final UserRemoteDatasource _remoteDatasource;
  final AuthRemoteDatasource _authRemoteDatasource;

  ProfileRepositoryImpl(
      {required UserRemoteDatasource remoteDatasource,
      required AuthRemoteDatasource authRemoteDatasource})
      : _remoteDatasource = remoteDatasource,
        _authRemoteDatasource = authRemoteDatasource;

  @override
  Future<Either<Failure, UserResponseModel>> userData() async {
    try {
      final call = await _remoteDatasource.getUser();
      return Right(call);
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(String password) async {
    try {
      await _authRemoteDatasource.changePassword(password);
      String message =
          'Password Success Changes, you can re-login with new password';

      return Right(message);
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  factory ProfileRepositoryImpl.create() {
    return ProfileRepositoryImpl(
      remoteDatasource: UserRemoteDatasourceImpl.create(),
      authRemoteDatasource: AuthRemoteDatasourceImpl.create(),
    );
  }
}
