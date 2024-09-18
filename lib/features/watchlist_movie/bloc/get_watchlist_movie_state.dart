part of 'get_watchlist_movie_bloc.dart';

@freezed
class GetWatchlistMovieState with _$GetWatchlistMovieState {
  const factory GetWatchlistMovieState.initial() = _Initial;
  const factory GetWatchlistMovieState.loading() = _Loading;
  const factory GetWatchlistMovieState.error(String message) = _Error;
  const factory GetWatchlistMovieState.loaded(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) = _Loaded;
}
