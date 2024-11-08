import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/datasources/payment_remote_datasource/payment_remote_datasource.dart';
import 'package:movie_mate/data/model/response/bank_transfer_response_model.dart';
import 'package:movie_mate/data/model/response/qris_response_model.dart';
import 'package:movie_mate/data/model/response/payment_status_response_model.dart';

import '../../../core/exception/exception.dart';

abstract class PaymentRepository {
  Future<Either<Failure, QrisResponseModel>> generateQris(
      String orderId, int paymentGross);
  Future<PaymentStatusResponseModel> checkPaymentStatus(String orderId);
  Future<Either<Failure, BankTransferResponseModel>> paymentBank(
      String orderId, int grossAmount, String bank);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource _datasource;

  PaymentRepositoryImpl({
    required PaymentRemoteDatasource datasource,
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
  Future<PaymentStatusResponseModel> checkPaymentStatus(String orderId) async {
    try {
      final data = await _datasource.checkPaymentStatus(orderId);
      return data;
    } on SocketException {
      throw ConnectionFailure();
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<Either<Failure, BankTransferResponseModel>> paymentBank(
      String orderId, int grossAmount, String bank) async {
    try {
      final data =
          await _datasource.transferPayment(orderId, grossAmount, bank);
      return Right(data);
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    }
  }

  factory PaymentRepositoryImpl.create() {
    return PaymentRepositoryImpl(
      datasource: PaymentRemoteDatasourceImpl.create(),
    );
  }
}
