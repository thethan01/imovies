import 'package:equatable/equatable.dart';
import 'package:imovies/models/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movieList;

  const MovieLoaded(this.movieList);
  @override
  List<Object> get props => [movieList];
  @override
  String toString() {
    return 'MovieLoaded{List<Movie>: $movieList}';
  }
}

class MovieError extends MovieState {}
