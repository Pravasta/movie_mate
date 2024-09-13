import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/exception/failure.dart';
import '../../../../data/model/response/movie_response_model.dart';
import '../../repository/movie_home_repository.dart';

part 'coming_soon_movies_event.dart';
part 'coming_soon_movies_state.dart';
part 'coming_soon_movies_bloc.freezed.dart';

class ComingSoonMoviesBloc
    extends Bloc<ComingSoonMoviesEvent, ComingSoonMoviesState> {
  final MovieHomeRepository _repository;
  ComingSoonMoviesBloc(this._repository) : super(const _Initial()) {
    on<_GetComingSoonMovies>((event, emit) async {
      emit(const _Loading());
      final response = await _repository.getUpComingMovies();

      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
