part of 'login_google_bloc.dart';

@freezed
class LoginGoogleState with _$LoginGoogleState {
  const factory LoginGoogleState.initial() = _Initial;
  const factory LoginGoogleState.loading() = _Loading;
  const factory LoginGoogleState.error(String message) = _Error;
  const factory LoginGoogleState.success(UserResponseModel user) = _Success;
}
