import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/request/register_request_model.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';

import '../../repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _repository;

  RegisterBloc(this._repository) : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());

      final call = await _repository.register(event.data);

      call.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
