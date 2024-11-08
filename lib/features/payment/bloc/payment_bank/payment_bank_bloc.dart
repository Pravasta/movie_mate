import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/response/bank_transfer_response_model.dart';
import 'package:movie_mate/features/payment/repository/payment_repository.dart';

part 'payment_bank_event.dart';
part 'payment_bank_state.dart';
part 'payment_bank_bloc.freezed.dart';

class PaymentBankBloc extends Bloc<PaymentBankEvent, PaymentBankState> {
  final PaymentRepository _repository;

  PaymentBankBloc(this._repository) : super(const _Initial()) {
    on<_PaymentBank>((event, emit) async {
      emit(const _Loading());

      final result = await _repository.paymentBank(
          event.orderId, event.grossAmount, event.bankName);

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
