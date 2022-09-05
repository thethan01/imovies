import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovies/blocs/movie_genre/movie_genre_event.dart';
import 'package:imovies/blocs/movie_genre/movie_genre_state.dart';
import 'package:imovies/models/movie.dart';
import 'package:imovies/services/api_service.dart';

class MovieGenreBloc extends Bloc<MovieGenreEvent, MovieGenreState> {
  MovieGenreBloc() : super(MovieGenreLoading()) {
    on<MovieGenreEventStart>(_onMovieGenreEventStart);
  }
  Future<void> _onMovieGenreEventStart(MovieGenreEventStart event,
      Emitter<MovieGenreState> emit) async {
    final service = ApiService();
    emit(MovieGenreLoading());
    try {
      List<Movie> movieGenreList = await service.getMovieGenre(event.movieId);
      emit(MovieGenreLoaded(movieGenreList));
    } on Exception catch (e) {
      print(e);
      emit(MovieGenreError());
    }
  }

// MovieBloc() : super(MovieLoading());
//
// Stream<MovieState> mapEventToState(MovieEvent event) async* {
//   if (event is MovieEventStart) {
//     yield* _mapMovieEventStateToState(event.movieId, event.query);
//   }
// }
//
// Stream<MovieState> _mapMovieEventStateToState(
//     int movieId, String query) async* {
//   final service = ApiService();
//   yield MovieLoading();
//   try {
//     List<Movie> movieList;
//     if (movieId == 0) {
//       movieList = await service.getNowPlayingMovie();
//       yield MovieLoaded(movieList);
//     } else {}
//   } on Exception catch (e) {
//     print(e);
//     yield MovieError();
//   }
// }
}
