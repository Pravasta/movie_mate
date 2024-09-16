import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/datasources/auth_datasource/auth_remote_datasource.dart';
import 'package:movie_mate/data/model/request/login_request_model.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';

import '../../../core/exception/exception.dart';
import '../../../data/model/request/register_request_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserResponseModel>> login(LoginRequestModel data);
  Future<Either<Failure, UserResponseModel>> register(
      RegisterRequestModel data);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, UserResponseModel>> googleSignIn();
  Future<Either<Failure, String>> forgotPassword(String email);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;

  AuthRepositoryImpl({
    required AuthRemoteDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Failure, UserResponseModel>> login(
      LoginRequestModel data) async {
    try {
      final call = await _datasource.login(data);
      return Right(call);
    } on SocketException {
      return Left(ConnectionFailure());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserResponseModel>> register(
      RegisterRequestModel data) async {
    try {
      final call = await _datasource.register(data);
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
  Future<Either<Failure, bool>> logout() async {
    try {
      final call = await _datasource.logout();
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
  Future<Either<Failure, UserResponseModel>> googleSignIn() async {
    try {
      final call = await _datasource.googleSignIn();
      return Right(call);
    } on SocketException {
      return Left(ConnectionFailure());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    try {
      await _datasource.forgotPassword(email);

      return const Right('please check email for Forgot password');
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  factory AuthRepositoryImpl.create() {
    return AuthRepositoryImpl(
      datasource: AuthRemoteDatasourceImpl.create(),
    );
  }
}
