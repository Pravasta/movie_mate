import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/response/qris_response_model.dart';
import 'package:movie_mate/features/payment/repository/qris_repository.dart';

part 'generate_qris_event.dart';
part 'generate_qris_state.dart';
part 'generate_qris_bloc.freezed.dart';

class GenerateQrisBloc extends Bloc<GenerateQrisEvent, GenerateQrisState> {
  final QrisRepository _qrisRepository;

  GenerateQrisBloc(this._qrisRepository) : super(const _Initial()) {
    on<_GenerateQrCode>((event, emit) async {
      emit(const _Loading());

      final result =
          await _qrisRepository.generateQris(event.orderId, event.grossAmount);

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
