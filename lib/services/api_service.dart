import 'package:dio/dio.dart';
import 'package:imovies/models/cast.dart';
import 'package:imovies/models/genre.dart';
import 'package:imovies/models/movie.dart';
import 'package:imovies/models/movie_detail.dart';
import 'package:imovies/models/reviews.dart';

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
      throw Exception('$error');
    }
  }

  Future<List<Movie>> getMovieGenre(int movieId) async {
    try {
      final url = '$baseUrl/discover/movie?with_genres=$movieId&$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieGenreList =
          movies.map((m) => Movie.fromJson(m)).toList();
      return movieGenreList;
    } catch (error) {
      throw Exception('$error');
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

      movieDetail.trailerId = await getYoutubeId(movieId);

      movieDetail.castList = await getCastList(movieId);

      movieDetail.reviewList = await getReviews(movieId);

      return movieDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$id/videos?$apiKey');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Cast>> getCastList(int movieId) async {
    try {
      final response =
          await _dio.get('$baseUrl/movie/$movieId/credits?$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> castList = list
          .map((c) => Cast(
              name: c['name'],
              profilePath: c['profile_path'],
              character: c['character']))
          .toList();
      return castList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Review>> getReviews(int movieId) async {
    try {
      final response =
          await _dio.get('$baseUrl/movie/$movieId/reviews?$apiKey');
      var list = response.data['results'] as List;
      List<Review> reviewList = list
          .map((r) => Review(
              author: r['author'],
              rating: r['rating'],
              createdAt: r['created_at'],
              content: r['content'],
              avatarPath: r['avatar_path']))
          .toList();
      return reviewList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getSearchResult(String query) async {
    try {
      final response =
          await _dio.get('$baseUrl/search/movie?$apiKey&query=$query&page=1');
      var list = response.data['results'] as List;
      List<Movie> searchMovieList = list
          .map((m) => Movie(
                id: m['id'],
                posterPath: m['poster_path'],
                voteAverage: m['vote_average'],
                voteCount: m['vote_count'],
                originalLanguage: m['original_language'],
                popularity: m['popularity'],
                title: m['title'],
                releaseDate: m['release_date'],
                video: m['video'],
                overview: m['overview'],
                originalTitle: m['original_title'],
                backdropPath: m['backdrop_path'],
              ))
          .toList();
      return searchMovieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
