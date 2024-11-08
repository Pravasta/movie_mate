part of 'check_payment_status_bloc.dart';

@freezed
class CheckPaymentStatusState with _$CheckPaymentStatusState {
  const factory CheckPaymentStatusState.initial() = _Initial;
  const factory CheckPaymentStatusState.loading() = _Loading;
  const factory CheckPaymentStatusState.error(String error) = _Error;
  const factory CheckPaymentStatusState.loaded(
      PaymentStatusResponseModel data) = _Loaded;
  const factory CheckPaymentStatusState.success(String message) = _Success;
  const factory CheckPaymentStatusState.pending(String message) = _Pending;
}
