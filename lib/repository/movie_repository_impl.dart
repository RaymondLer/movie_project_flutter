import 'package:movie_project_flutter/api/movie_api.dart';
import 'package:movie_project_flutter/di/di.dart';
import 'package:movie_project_flutter/models/movie.dart';
import 'package:movie_project_flutter/repository/movie_repository.dart';
import 'package:movie_project_flutter/service/network_service.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApi _movieApi;

  MovieRepositoryImpl(this._movieApi);

  @override
  Future<List<Movie>> getPopularMovie(int page) async {
    final NetworkService networkService = getIt.get<NetworkService>();

    if (await networkService.isConnected()) {
      try {
        final response = await _movieApi.fetchPopularMovie(page);

        final result = response.map((e) {
          String imagePath = 'https://image.tmdb.org/t/p/w500${e.posterPath}';

          return Movie(title: e.title, imageUrl: imagePath);
        }).toList();

        return result;
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      return <Movie>[];
    }
  }
}
