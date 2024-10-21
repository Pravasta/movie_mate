part of 'get_all_ticket_orders_bloc.dart';

@freezed
class GetAllTicketOrdersEvent with _$GetAllTicketOrdersEvent {
  const factory GetAllTicketOrdersEvent.started() = _Started;
  const factory GetAllTicketOrdersEvent.getAllTicketOrders() =
      _GetAllTicketOrders;
}
