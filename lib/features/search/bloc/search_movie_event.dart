part of 'search_movie_bloc.dart';

@freezed
class SearchMovieEvent with _$SearchMovieEvent {
  const factory SearchMovieEvent.started() = _Started;
  const factory SearchMovieEvent.searchMovie(String query) = _SearchMovie;
}
