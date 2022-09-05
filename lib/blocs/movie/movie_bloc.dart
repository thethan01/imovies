import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovies/blocs/movie/movie_event.dart';
import 'package:imovies/blocs/movie/movie_state.dart';
import 'package:imovies/models/movie.dart';
import 'package:imovies/services/api_service.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading()) {
    on<MovieEventStart>(_onMovieEventStart);
  }
  Future<void> _onMovieEventStart(MovieEventStart event,
      Emitter<MovieState> emit) async {
    final service = ApiService();
    emit(MovieLoading());
      try {
        List<Movie> movieList;
          movieList = await service.getNowPlayingMovie();
          emit(MovieLoaded(movieList));
      } on Exception catch (e) {
        print(e);
        emit(MovieError());
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
