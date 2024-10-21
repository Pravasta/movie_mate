import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/response/order_model.dart';
import 'package:movie_mate/features/my_ticket/repository/my_ticket_repository.dart';

part 'get_all_ticket_orders_event.dart';
part 'get_all_ticket_orders_state.dart';
part 'get_all_ticket_orders_bloc.freezed.dart';

class GetAllTicketOrdersBloc
    extends Bloc<GetAllTicketOrdersEvent, GetAllTicketOrdersState> {
  final MyTicketRepository _repository;

  GetAllTicketOrdersBloc(this._repository) : super(const _Initial()) {
    on<_GetAllTicketOrders>((event, emit) async {
      emit(const _Loading());

      final result = await _repository.getAllOrders();

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
