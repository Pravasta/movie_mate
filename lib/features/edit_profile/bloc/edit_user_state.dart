part of 'edit_user_bloc.dart';

@freezed
class EditUserState with _$EditUserState {
  const factory EditUserState.initial() = _Initial;
  const factory EditUserState.loading() = _Loading;
  const factory EditUserState.error(String message) = _Error;
  const factory EditUserState.success(UserResponseModel user) = _Success;
}
