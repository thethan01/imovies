import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class TextChanged extends SearchEvent {
  const TextChanged({required this.query});

  final String query;

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'TextChanged { text: $query }';
}
