import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/features/auth/repository/auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';
part 'forgot_password_bloc.freezed.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _repository;

  ForgotPasswordBloc(this._repository) : super(const _Initial()) {
    on<_ForgotPassword>((event, emit) async {
      emit(const _Loading());

      final call = await _repository.forgotPassword(event.email);
      call.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
