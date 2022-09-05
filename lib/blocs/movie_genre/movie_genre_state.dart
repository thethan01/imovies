import 'package:equatable/equatable.dart';
import 'package:imovies/models/movie.dart';

abstract class MovieGenreState extends Equatable {
  const MovieGenreState();
  @override
  List<Object> get props => [];
}

class MovieGenreLoading extends MovieGenreState {}

class MovieGenreLoaded extends MovieGenreState {
  final List<Movie> movieGenreList;

  const MovieGenreLoaded(this.movieGenreList);
  @override
  List<Object> get props => [movieGenreList];
  @override
  String toString() {
    return 'MovieLoaded{List<Movie>: $movieGenreList}';
  }
}

class MovieGenreError extends MovieGenreState {}
