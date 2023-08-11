import 'package:movie_project_flutter/models/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovie(int page);
}
