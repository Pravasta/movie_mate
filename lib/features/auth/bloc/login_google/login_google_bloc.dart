import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';
import 'package:movie_mate/features/auth/repository/auth_repository.dart';

part 'login_google_event.dart';
part 'login_google_state.dart';
part 'login_google_bloc.freezed.dart';

class LoginGoogleBloc extends Bloc<LoginGoogleEvent, LoginGoogleState> {
  final AuthRepository _repository;

  LoginGoogleBloc(this._repository) : super(const _Initial()) {
    on<_LoginGoogle>((event, emit) async {
      emit(const _Loading());
      final call = await _repository.googleSignIn();

      call.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
