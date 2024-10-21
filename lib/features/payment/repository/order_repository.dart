import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/data/datasources/order_datasource/order_remote_datasource.dart';

import 'package:movie_mate/data/model/response/order_model.dart';

import '../../../core/exception/exception.dart';
import '../../../core/exception/failure.dart';

abstract class OrderRepository {
  Future<Either<Failure, String>> createOrderMovie(OrderModel orderData);
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource _remoteDatasource;

  OrderRepositoryImpl({required OrderRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, String>> createOrderMovie(OrderModel orderData) async {
    try {
      await _remoteDatasource.createOrderMovie(orderData);
      return const Right('Create Order Success');
    } on SocketException {
      return Left(ConnectionFailure());
    } on ApiException catch (e) {
      return Left(ServerFailure(message: '${e.message}'));
    }
  }

  factory OrderRepositoryImpl.create() {
    return OrderRepositoryImpl(
      remoteDatasource: OrderRemoteDatasourceImpl.create(),
    );
  }
}
