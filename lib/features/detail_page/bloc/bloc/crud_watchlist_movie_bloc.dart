import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/features/detail_page/repository/movie_detail_repository.dart';

import '../../../../data/model/response/movie_response_model.dart';

part 'crud_watchlist_movie_event.dart';
part 'crud_watchlist_movie_state.dart';
part 'crud_watchlist_movie_bloc.freezed.dart';

class CrudWatchlistMovieBloc
    extends Bloc<CrudWatchlistMovieEvent, CrudWatchlistMovieState> {
  final MovieDetailRepository _repository;

  CrudWatchlistMovieBloc(this._repository) : super(const _Initial()) {
    on<_AddWatchlistMovie>((event, emit) async {
      emit(const _Loading());
      final call = await _repository.addWatchlistMovie(event.data);

      call.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );

      add(_IsAddedWatchlistMovie(event.data.id!));
    });

    on<_RemoveWatchlistMovie>((event, emit) async {
      emit(const _Loading());
      final call = await _repository.removeWatchlistMovie(event.id);

      call.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );

      add(_IsAddedWatchlistMovie(event.id));
    });

    on<_IsAddedWatchlistMovie>((event, emit) async {
      final call = await _repository.isAddedToWatchlist(event.id);
      emit(_IsAdded(call));
    });
  }
}
