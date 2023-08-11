import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_project_flutter/models/movie.dart';
import 'package:movie_project_flutter/repository/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository _movieRepository;

  MovieCubit(this._movieRepository) : super(MovieInitial());

  List<Movie> movies = [];

  void getPopularMovies(int page) async {
    emit(LoadingState());

    try {
      List<Movie> getMovies = await _movieRepository.getPopularMovie(page);

      if (getMovies.isNotEmpty) {
        movies.addAll(getMovies);

        emit(LoadedState());
      } else {
        emit(const FailedState(message: 'Unable to get movie list'));
      }
    } catch (e) {
      emit(const FailedState(message: 'Fetch api failed'));
    }
  }
}
