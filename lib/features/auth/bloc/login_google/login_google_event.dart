part of 'login_google_bloc.dart';

@freezed
class LoginGoogleEvent with _$LoginGoogleEvent {
  const factory LoginGoogleEvent.started() = _Started;
  const factory LoginGoogleEvent.loginGoogle() = _LoginGoogle;
}
