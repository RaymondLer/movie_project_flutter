import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_project_flutter/models/movie.dart';
import 'package:movie_project_flutter/presentation/cubit/movie_cubit.dart';

import '../shared_mock.mocks.dart';

void main() {
  final MockMovieRepository mockMovieRepository = MockMovieRepository();

  // Mock Data
  List<Movie> movies = [
    Movie(
      title: 'John Wick: Chapter 4',
      imageUrl: 'https://via.placeholder.com/160?text=IMAGE',
    ),
    Movie(
      title: 'Transformer',
      imageUrl: 'https://via.placeholder.com/160?text=IMAGE',
    ),
  ];

  late MovieCubit movieCubit;

  setUp(() => movieCubit = MovieCubit(mockMovieRepository));

  blocTest<MovieCubit, MovieState>(
    'Test Get Movies Success State',
    build: () {
      when(mockMovieRepository.getPopularMovie(1)).thenAnswer((_) async {
        return movies;
      });

      return movieCubit;
    },
    act: (cubit) => cubit.getPopularMovies(1),
    expect: () => <MovieState>[
      LoadingState(),
      LoadedState(),
    ],
  );

  blocTest<MovieCubit, MovieState>(
    'Test Get Movies Failed State',
    build: () {
      when(mockMovieRepository.getPopularMovie(1)).thenAnswer((_) async {
        return [];
      });

      return movieCubit;
    },
    act: (cubit) => cubit.getPopularMovies(1),
    expect: () => <MovieState>[
      LoadingState(),
      const FailedState(message: 'Unable to get movie list'),
    ],
  );
}
