import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';
import 'package:movie_mate/features/home/repository/movie_home_repository.dart';

import '../../../../core/exception/failure.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';
part 'now_playing_movies_bloc.freezed.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final MovieHomeRepository _repository;

  NowPlayingMoviesBloc(this._repository) : super(const _Initial()) {
    on<_GetNowPlayingMovies>((event, emit) async {
      emit(const _Loading());
      final response = await _repository.getNowPlayingMovies();

      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
