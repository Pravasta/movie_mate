import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/features/profile/repository/profile_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';
part 'change_password_bloc.freezed.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ProfileRepository _repository;

  ChangePasswordBloc(this._repository) : super(const _Initial()) {
    on<_ChangePassword>((event, emit) async {
      emit(const _Loading());

      final call = await _repository.changePassword(event.newPassword);

      call.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
