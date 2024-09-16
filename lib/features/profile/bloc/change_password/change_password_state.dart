part of 'change_password_bloc.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.initial() = _Initial;
  const factory ChangePasswordState.loading() = _Loading;
  const factory ChangePasswordState.error(String message) = _Error;
  const factory ChangePasswordState.success(String success) = _Success;
}
