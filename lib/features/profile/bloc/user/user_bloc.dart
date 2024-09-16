import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';
import 'package:movie_mate/features/profile/repository/profile_repository.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ProfileRepository _repository;

  UserBloc(this._repository) : super(const _Initial()) {
    on<_User>((event, emit) async {
      emit(const _Loading());
      final call = await _repository.userData();

      call.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
