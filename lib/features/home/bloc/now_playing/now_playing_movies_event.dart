part of 'now_playing_movies_bloc.dart';

@freezed
class NowPlayingMoviesEvent with _$NowPlayingMoviesEvent {
  const factory NowPlayingMoviesEvent.started() = _Started;
  const factory NowPlayingMoviesEvent.getNowPlayingMovies() =
      _GetNowPlayingMovies;
}
