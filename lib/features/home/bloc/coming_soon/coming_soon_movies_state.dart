part of 'coming_soon_movies_bloc.dart';

@freezed
class ComingSoonMoviesState with _$ComingSoonMoviesState {
  const factory ComingSoonMoviesState.initial() = _Initial;
  const factory ComingSoonMoviesState.loading() = _Loading;
  const factory ComingSoonMoviesState.loaded(List<Result> data) = _Loaded;
  const factory ComingSoonMoviesState.error(Failure message) = _Error;
}
