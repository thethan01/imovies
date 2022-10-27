import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imovies/models/movie.dart';
import 'package:imovies/services/api_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> informInitial() async {
    if (kDebugMode) {
      print("Search page is loading");
    }
  }

  Future<void> loadSearch(String query) async {
    final service = ApiService();
    print(query);
    try {
      if (query.length > 0) {
        await Future.delayed(const Duration(milliseconds: 500));
        final search_list = await service.getSearchResult(query);
        emit(SearchLoadedState(search_list));
        print('Search loaded');
      } else {
        emit(SearchInitial());
      }
    } catch (e) {
      if (isClosed == false) {
        emit(SearchErrorState());
      }
    }
  }

  Future<void> reloadSearch() async {
    if (isClosed == false) {
      print("reload");
      emit(SearchInitial());
    }
  }
}
