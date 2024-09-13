part of 'now_playing_movies_bloc.dart';

@freezed
class NowPlayingMoviesState with _$NowPlayingMoviesState {
  const factory NowPlayingMoviesState.initial() = _Initial;
  const factory NowPlayingMoviesState.loading() = _Loading;
  const factory NowPlayingMoviesState.loaded(List<Result> data) = _Loaded;
  const factory NowPlayingMoviesState.error(Failure message) = _Error;
}
