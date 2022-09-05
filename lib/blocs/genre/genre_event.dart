import 'package:equatable/equatable.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();
}

class GenreEventStart extends GenreEvent {
  const GenreEventStart();
  @override
  List<Object> get props => [];
}
