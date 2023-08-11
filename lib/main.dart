import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_project_flutter/di/di.dart';
import 'package:movie_project_flutter/presentation/cubit/movie_cubit.dart';
import 'package:movie_project_flutter/presentation/popular_movies/popular_movies_page.dart';

void main() {
  // Initialise GetIt here
  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieCubit>(
      create: (context) => getIt.get<MovieCubit>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PopularMoviesPage(),
      ),
    );
  }
}
