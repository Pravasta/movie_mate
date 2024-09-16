import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/request/edit_user_request_model.dart';
import 'package:movie_mate/data/model/response/user_response_model.dart';

import '../repository/edit_profile_repository.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';
part 'edit_user_bloc.freezed.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final EditProfileRepository _repository;

  EditUserBloc(this._repository) : super(const _Initial()) {
    on<_EditUser>((event, emit) async {
      emit(const _Loading());

      final reqData = EditUserRequestModel(
        uid: event.data.uid,
        name: event.data.name,
        phoneNumber: event.data.phoneNumber,
        photoUrl: event.data.photoUrl,
      );

      final call = await _repository.updateUser(reqData);

      call.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
