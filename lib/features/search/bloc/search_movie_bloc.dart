import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/data/model/response/movie_response_model.dart';
import 'package:movie_mate/features/search/repository/search_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';
part 'search_movie_bloc.freezed.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchRepository _repository;

  SearchMovieBloc(this._repository) : super(const _Initial()) {
    on<_SearchMovie>(
      (event, emit) async {
        emit(const _Loading());

        final call = await _repository.getSearchMovies(event.query);

        call.fold(
          (l) => emit(_Error(l.message)),
          (r) => emit(_Success(r)),
        );
      },
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .flatMap(mapper);
      },
    );
  }
}
