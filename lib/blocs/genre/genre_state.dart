import 'package:equatable/equatable.dart';
import 'package:imovies/models/genre.dart';

abstract class GenreState extends Equatable {
  const GenreState();
  @override
  List<Object> get props => [];
}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<Genre> genreList;

  const GenreLoaded(this.genreList);
  @override
  List<Object> get props => [genreList];
  @override
  String toString() {
    return 'GenreLoaded{List<Genre>: $genreList}';
  }
}

class GenreError extends GenreState {}
