part of 'payment_bank_bloc.dart';

@freezed
class PaymentBankState with _$PaymentBankState {
  const factory PaymentBankState.initial() = _Initial;
  const factory PaymentBankState.loading() = _Loading;
  const factory PaymentBankState.error(String error) = _Error;
  const factory PaymentBankState.success(BankTransferResponseModel data) =
      _Success;
}
