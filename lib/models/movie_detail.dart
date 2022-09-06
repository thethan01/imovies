import 'package:imovies/models/cast.dart';

class MovieDetail {
  final String id;
  final String title;
  final String backdropPath;
  final String posterPath;
  final String budget;
  final String homePage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String runtime;
  final String voteAverage;
  final String voteCount;

  String? trailerId;

  List<Cast>? castList;

  MovieDetail(
      {required this.id,
      required this.posterPath,
      required this.title,
      required this.backdropPath,
      required this.budget,
      required this.homePage,
      required this.originalTitle,
      required this.overview,
      required this.releaseDate,
      required this.runtime,
      required this.voteAverage,
      required this.voteCount});

  factory MovieDetail.fromJson(dynamic json) {
    return MovieDetail(
        id: json['id'].toString(),
        title: json['title'],
        backdropPath: json['backdrop_path'],
        budget: json['budget'].toString(),
        homePage: json['home_page'].toString(),
        originalTitle: json['original_title'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        runtime: json['runtime'].toString(),
        voteAverage: json['vote_average'].toStringAsFixed(1),
        voteCount: json['vote_count'].toString(),
        posterPath: json['poster_path']);
  }
}
