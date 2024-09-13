import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/core/exception/failure.dart';
import 'package:movie_mate/data/model/response/movie_detail_response_model.dart';
import 'package:movie_mate/features/detail_page/repository/movie_detail_repository.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';
part 'movie_detail_bloc.freezed.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailRepository _repository;

  MovieDetailBloc(this._repository) : super(const _Initial()) {
    on<_GetMovieDetail>((event, emit) async {
      emit(const _Loading());

      final data = await _repository.getDetailMovie(event.id);

      data.fold(
        (l) => emit(_Error(Failure(message: l.message))),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
