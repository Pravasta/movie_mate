part of 'crud_watchlist_movie_bloc.dart';

@freezed
class CrudWatchlistMovieEvent with _$CrudWatchlistMovieEvent {
  const factory CrudWatchlistMovieEvent.started() = _Started;
  const factory CrudWatchlistMovieEvent.addWatchlistMovie(Result data) =
      _AddWatchlistMovie;
  const factory CrudWatchlistMovieEvent.removeWatchlistMovie(int id) =
      _RemoveWatchlistMovie;
  const factory CrudWatchlistMovieEvent.isAddedWatchlistMovie(int id) =
      _IsAddedWatchlistMovie;
}
