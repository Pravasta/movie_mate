part of 'movie_detail_bloc.dart';

@freezed
class MovieDetailState with _$MovieDetailState {
  const factory MovieDetailState.initial() = _Initial;
  const factory MovieDetailState.loading() = _Loading;
  const factory MovieDetailState.error(Failure error) = _Error;
  const factory MovieDetailState.loaded(MovieDetailResponseModel data) =
      _Loaded;
}
