part of 'generate_qris_bloc.dart';

@freezed
class GenerateQrisState with _$GenerateQrisState {
  const factory GenerateQrisState.initial() = _Initial;
  const factory GenerateQrisState.loading() = _Loading;
  const factory GenerateQrisState.error(String error) = _Error;
  const factory GenerateQrisState.success(QrisResponseModel data) = _Success;
}
