import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/movie_repository.dart';
import '../../models/movie.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc({required this.repository}) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async =>
        emit(MovieLoaded(await repository.fetchMovies())));
    on<MovieWasTapped>((event, emit) async => emit(
        MovieLoaded(await repository.fetchMovies(tappedName: event.name))));
    on<PulledToRefresh>((event, emit) async =>
        emit(MovieLoaded(await repository.fetchMovies(shuffle: true))));
    on<RemoveAllTappedMovies>((event, emit) async =>
        emit(MovieLoaded(await repository.fetchMovies(untapMovie: true))));
  }
}
