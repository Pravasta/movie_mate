part of 'get_watchlist_movie_bloc.dart';

@freezed
class GetWatchlistMovieEvent with _$GetWatchlistMovieEvent {
  const factory GetWatchlistMovieEvent.started() = _Started;
  const factory GetWatchlistMovieEvent.getWatchlistMovie() = _GetWatchlistMovie;
}
