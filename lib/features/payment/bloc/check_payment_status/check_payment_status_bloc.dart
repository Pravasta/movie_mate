import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/response/qris_status_response_model.dart';
import 'package:movie_mate/features/payment/repository/qris_repository.dart';

part 'check_payment_status_event.dart';
part 'check_payment_status_state.dart';
part 'check_payment_status_bloc.freezed.dart';

class CheckPaymentStatusBloc
    extends Bloc<CheckPaymentStatusEvent, CheckPaymentStatusState> {
  final QrisRepository _repository;

  CheckPaymentStatusBloc(this._repository) : super(const _Initial()) {
    on<_CheckPaymentStatus>((event, emit) async {
      emit(const _Loading());

      final result = await _repository.checkStatusQris(event.orderId);

      if (result.transactionStatus == 'settlement') {
        emit(const _Success('Payment Success'));
      } else if (result.transactionStatus == 'pending') {
        emit(const _Pending('Payment Pending'));
      }
    });
  }
}
