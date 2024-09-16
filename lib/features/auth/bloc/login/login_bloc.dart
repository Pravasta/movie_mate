import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/request/login_request_model.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';
import 'package:movie_mate/features/auth/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _repository;

  LoginBloc(this._repository) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());

      final call = await _repository.login(event.data);

      call.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
