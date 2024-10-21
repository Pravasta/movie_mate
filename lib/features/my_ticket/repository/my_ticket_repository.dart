import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/datasources/order_datasource/order_remote_datasource.dart';
import 'package:movie_mate/data/model/response/order_model.dart';

import '../../../core/exception/exception.dart';

abstract class MyTicketRepository {
  Future<Either<Failure, List<OrderModel>>> getAllOrders();
}

class MyTicketRepositoryImpl implements MyTicketRepository {
  final OrderRemoteDatasource _remoteDatasource;

  MyTicketRepositoryImpl({required OrderRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, List<OrderModel>>> getAllOrders() async {
    try {
      final data = await _remoteDatasource.getAllOrder();
      return Right(data);
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    }
  }

  factory MyTicketRepositoryImpl.create() {
    return MyTicketRepositoryImpl(
      remoteDatasource: OrderRemoteDatasourceImpl.create(),
    );
  }
}
