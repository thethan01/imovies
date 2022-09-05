import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovies/blocs/genre/genre_event.dart';
import 'package:imovies/blocs/genre/genre_state.dart';
import 'package:imovies/models/genre.dart';
import 'package:imovies/services/api_service.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoading()) {
    on<GenreEventStart>(_onMovieEventStart);
  }
  Future<void> _onMovieEventStart(GenreEventStart event,
      Emitter<GenreState> emit) async {
    final service = ApiService();
    emit(GenreLoading());
    try {
      List<Genre> genreList = await service.getGenreList();
      emit(GenreLoaded(genreList));
    } on Exception catch (e) {
      print(e);
      emit(GenreError());
    }
  }

}
