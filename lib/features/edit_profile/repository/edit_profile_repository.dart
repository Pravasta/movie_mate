import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/data/datasources/user_datasource/user_remote_datasource.dart';

import '../../../core/exception/exception.dart';
import '../../../core/exception/failure.dart';
import '../../../data/model/request/edit_user_request_model.dart';
import '../../../data/model/response/user_response_model.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, UserResponseModel>> updateUser(
      EditUserRequestModel data);
}

class EditProfileRepositoryImpl implements EditProfileRepository {
  final UserRemoteDatasource _remoteDatasource;

  EditProfileRepositoryImpl({required UserRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, UserResponseModel>> updateUser(
      EditUserRequestModel data) async {
    try {
      await _remoteDatasource.editUser(data);
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

  factory EditProfileRepositoryImpl.create() {
    return EditProfileRepositoryImpl(
      remoteDatasource: UserRemoteDatasourceImpl.create(),
    );
  }
}
