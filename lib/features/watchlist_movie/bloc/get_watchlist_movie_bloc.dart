import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_mate/features/watchlist_movie/repository/watchlist_movie_repository.dart';

part 'get_watchlist_movie_event.dart';
part 'get_watchlist_movie_state.dart';
part 'get_watchlist_movie_bloc.freezed.dart';

class GetWatchlistMovieBloc
    extends Bloc<GetWatchlistMovieEvent, GetWatchlistMovieState> {
  final WatchlistMovieRepository _repository;

  GetWatchlistMovieBloc(this._repository) : super(const _Initial()) {
    on<GetWatchlistMovieEvent>((event, emit) async {
      emit(const _Loading());

      final call = await _repository.getWatchlistMovie();
      call.fold(
        (error) => emit(_Error(error.message)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
