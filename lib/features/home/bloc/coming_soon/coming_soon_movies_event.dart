part of 'coming_soon_movies_bloc.dart';

@freezed
class ComingSoonMoviesEvent with _$ComingSoonMoviesEvent {
  const factory ComingSoonMoviesEvent.started() = _Started;
  const factory ComingSoonMoviesEvent.getComingSoonMovies() =
      _GetComingSoonMovies;
}
