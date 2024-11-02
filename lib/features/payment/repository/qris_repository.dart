import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/datasources/midtrans_datasource/midtrans_remote_datasource.dart';
import 'package:movie_mate/data/model/response/qris_response_model.dart';
import 'package:movie_mate/data/model/response/qris_status_response_model.dart';

import '../../../core/exception/exception.dart';

abstract class QrisRepository {
  Future<Either<Failure, QrisResponseModel>> generateQris(
      String orderId, int paymentGross);
  Future<QrisStatusResponseModel> checkStatusQris(String orderId);
}

class QrisRepositoryImpl implements QrisRepository {
  final MidtransRemoteDatasource _datasource;

  QrisRepositoryImpl({
    required MidtransRemoteDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Failure, QrisResponseModel>> generateQris(
      String orderId, int paymentGross) async {
    try {
      final data = await _datasource.generateQrCode(orderId, paymentGross);
      return Right(data);
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    }
  }

  @override
  Future<QrisStatusResponseModel> checkStatusQris(String orderId) async {
    try {
      final data = await _datasource.checkPaymentStatus(orderId);
      return data;
    } on SocketException {
      throw ConnectionFailure();
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  factory QrisRepositoryImpl.create() {
    return QrisRepositoryImpl(
      datasource: MidtransRemoteDatasourceImpl.create(),
    );
  }
}
