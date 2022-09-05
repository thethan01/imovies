import 'package:dio/dio.dart';
import 'package:imovies/models/genre.dart';
import 'package:imovies/models/movie.dart';
import 'package:imovies/models/movie_detail.dart';


class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=0838a6d69c027208dce3f603ef99f74f';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final url = '$baseUrl/movie/now_playing?$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error) {
      throw Exception(
          '$error');
    }
  }
  Future<List<Movie>> getMovieGenre(int movieId ) async {
    try {
      final url = '$baseUrl/discover/movie?with_genres=$movieId&$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieGenreList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieGenreList;
    } catch (error) {
      throw Exception(
          '$error');
    }
  }
  Future<List<Genre>> getGenreList() async {
    try {
      final response = await _dio.get('$baseUrl/genre/movie/list?$apiKey');
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g) => Genre.fromJson(g)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId?$apiKey');
      MovieDetail movieDetail = MovieDetail.fromJson(response.data);
      //
      // movieDetail.trailerId = await getYoutubeId(movieId);
      //
      // movieDetail.movieImage = await getMovieImage(movieId);
      //
      // movieDetail.castList = await getCastList(movieId);

      return movieDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}

