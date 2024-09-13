part of 'movie_detail_bloc.dart';

@freezed
class MovieDetailEvent with _$MovieDetailEvent {
  const factory MovieDetailEvent.started() = _Started;
  const factory MovieDetailEvent.getMovieDetail(int id) = _GetMovieDetail;
}
