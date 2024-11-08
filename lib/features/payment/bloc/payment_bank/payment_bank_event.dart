part of 'payment_bank_bloc.dart';

@freezed
class PaymentBankEvent with _$PaymentBankEvent {
  const factory PaymentBankEvent.started() = _Started;
  const factory PaymentBankEvent.paymentBank(
      String orderId, int grossAmount, String bankName) = _PaymentBank;
}
