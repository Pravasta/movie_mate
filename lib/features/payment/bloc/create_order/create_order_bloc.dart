import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/features/payment/repository/order_repository.dart';

import '../../../../data/model/response/order_model.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';
part 'create_order_bloc.freezed.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  final OrderRepository _repository;

  CreateOrderBloc(this._repository) : super(const _Initial()) {
    on<_CreateOrder>((event, emit) async {
      emit(const _Loading());
      final result = await _repository.createOrderMovie(event.orderData);

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
