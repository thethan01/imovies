import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class MovieEventStart extends MovieEvent {
  final int movieId;
  final String query;

  const MovieEventStart(this.movieId, this.query);
  @override
  List<Object> get props => [];
}
