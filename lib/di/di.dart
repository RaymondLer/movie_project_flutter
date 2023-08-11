import 'package:get_it/get_it.dart';
import 'package:movie_project_flutter/api/movie_api.dart';
import 'package:movie_project_flutter/presentation/cubit/movie_cubit.dart';
import 'package:movie_project_flutter/repository/movie_repository.dart';
import 'package:movie_project_flutter/repository/movie_repository_impl.dart';
import 'package:movie_project_flutter/service/network_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<NetworkService>(NetworkService());

  getIt.registerLazySingleton<MovieApi>(() => MovieApiImpl());

  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getIt.get<MovieApi>()));

  getIt.registerLazySingleton<MovieCubit>(
      () => MovieCubit(getIt.get<MovieRepository>()));
}
