import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovies/blocs/movie_detail/movie_detail_event.dart';
import 'package:imovies/blocs/movie_detail/movie_detail_state.dart';
import 'package:imovies/services/api_service.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailLoading()) {
    on<MovieDetailEventStated>(_onMovieDetailEventStated);
  }
  Future<void> _onMovieDetailEventStated(MovieDetailEventStated event,
      Emitter<MovieDetailState> emit) async {
    final service = ApiService();
    emit(MovieDetailLoading());
    try {
      final movieDetail = await service.getMovieDetail(event.id);
      emit(MovieDetailLoaded(movieDetail));
    } on Exception catch (e) {
      print(e);
      emit(MovieDetailError());
    }
  }

}

