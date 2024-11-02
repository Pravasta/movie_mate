part of 'check_payment_status_bloc.dart';

@freezed
class CheckPaymentStatusEvent with _$CheckPaymentStatusEvent {
  const factory CheckPaymentStatusEvent.started() = _Started;
  const factory CheckPaymentStatusEvent.checkPaymentStatus(String orderId) =
      _CheckPaymentStatus;
}
