part of 'get_all_ticket_orders_bloc.dart';

@freezed
class GetAllTicketOrdersState with _$GetAllTicketOrdersState {
  const factory GetAllTicketOrdersState.initial() = _Initial;
  const factory GetAllTicketOrdersState.loading() = _Loading;
  const factory GetAllTicketOrdersState.error(String error) = _Error;
  const factory GetAllTicketOrdersState.loaded(List<OrderModel> data) = _Loaded;
}
