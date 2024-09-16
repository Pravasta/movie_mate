import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/features/auth/repository/auth_repository.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository _repository;

  LogoutBloc(this._repository) : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      emit(const _Loading());

      final call = await _repository.logout();
      call.fold(
        (l) => emit(_Error(l.toString())),
        (r) => emit(_Success(r)),
      );
    });
  }
}
