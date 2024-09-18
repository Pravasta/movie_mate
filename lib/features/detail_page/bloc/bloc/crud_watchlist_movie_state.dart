part of 'crud_watchlist_movie_bloc.dart';

@freezed
class CrudWatchlistMovieState with _$CrudWatchlistMovieState {
  const factory CrudWatchlistMovieState.initial() = _Initial;
  const factory CrudWatchlistMovieState.loading() = _Loading;
  const factory CrudWatchlistMovieState.error(String message) = _Error;
  const factory CrudWatchlistMovieState.success(String message) = _Success;
  const factory CrudWatchlistMovieState.isAdded(bool isAdded) = _IsAdded;
}
