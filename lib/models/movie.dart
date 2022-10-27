class Movie {
  final dynamic backdropPath;
  final dynamic id;
  final dynamic originalLanguage;
  final dynamic originalTitle;
  final dynamic overview;
  final dynamic popularity;
  final dynamic posterPath;
  final dynamic releaseDate;
  final dynamic title;
  final dynamic video;
  final dynamic voteCount;
  final dynamic voteAverage;

  String? error;

  Movie(
      {required this.backdropPath,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteCount,
      required this.voteAverage});

  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      return Movie(
          backdropPath: json['backdrop_path'],
          id: json['id'],
          originalLanguage: json['original_language'],
          originalTitle: json['original_title'],
          overview: json['overview'],
          popularity: json['popularity'],
          posterPath: json['poster_path'],
          releaseDate: json['release_date'],
          title: json['title'],
          video: json['video'],
          voteCount: json['vote_count'],
          voteAverage: json['vote_average'].toString());
    }

    return Movie(
        backdropPath: json['backdrop_path'],
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'].toString());
  }
}
