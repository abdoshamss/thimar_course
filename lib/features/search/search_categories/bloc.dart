import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class SearchCategoriesBloc
    extends Bloc<SearchCategoriesEvents, SearchCategoriesStates> {
  final DioHelper dioHelper;

  SearchCategoriesBloc(this.dioHelper) : super(SearchCategoriesStates()) {
    on<GetSearchCategoriesDataEvent>(_getData);
  }
  final searchController = TextEditingController();
 late List<SearchResult> list;
  Future<void> _getData(GetSearchCategoriesDataEvent event,
      Emitter<SearchCategoriesStates> emit) async {
    emit(SearchCategoriesLoadingState());
    final response =
        await dioHelper.get("search_category/${event.id}", params: {
      if (searchController.text.isNotEmpty) "keyword": event.value,
      // "filter": "",
      // "min_price": "",
      // "max_price": "",
    });
    if (response.isSuccess) {
      list=SearchCategoriesData.fromJson(response.response!.data).data.searchResult;
      emit(SearchCategoriesSuccessState());
    } else {
      emit(SearchCategoriesErrorState());
    }
  }
}
