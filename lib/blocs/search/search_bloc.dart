import 'package:bloc/bloc.dart';
import 'package:imovies/blocs/search/search_event.dart';
import 'package:imovies/blocs/search/search_state.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../services/api_service.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchStateEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  final service = ApiService();

  void _onTextChanged(
    TextChanged event,
    Emitter<SearchState> emit,
  ) async {
    final searchTerm = event.query;

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {
      final results = await service.getSearchResult(event.query);
      emit(SearchStateSuccess(results));
    } catch (error) {
      emit(SearchStateError(error.toString()));
    }
  }
}
