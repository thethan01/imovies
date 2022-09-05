import 'package:equatable/equatable.dart';

abstract class MovieGenreEvent extends Equatable {
  const MovieGenreEvent();
}

class MovieGenreEventStart extends MovieGenreEvent {
  final int movieId;
  final String query;

  const MovieGenreEventStart(this.movieId, this.query);
  @override
  List<Object> get props => [];
}
