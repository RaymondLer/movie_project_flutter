import 'package:dio/dio.dart';
import 'package:movie_project_flutter/models/movie_response.dart';

abstract class MovieApi {
  Future<List<MovieResponse>> fetchPopularMovie(int page);
}

class MovieApiImpl implements MovieApi {
  @override
  Future<List<MovieResponse>> fetchPopularMovie(int page) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/movie/popular?page=$page',
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0Mzc0MjMwOTEwYWMzNDJjNTEzNDJkMGJkMmQ1ZmMwNCIsInN1YiI6IjY0ODJlNzE2OTkyNTljMDBjNWIzY2UxMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5ZrA73Hk_eo6bimg6SWCirW3-_HDzKIF8nST8d5ykuE',
          },
        ),
      );

      if (response.data['results'] != null) {
        final result = response.data['results'] as List<dynamic>;
        List<MovieResponse> movies =
            result.map((value) => MovieResponse.fromJson(value)).toList();

        return movies;
      } else {
        return <MovieResponse>[];
      }
    } catch (e) {
      rethrow;
      // Exception(e.toString());
    }
  }
}
