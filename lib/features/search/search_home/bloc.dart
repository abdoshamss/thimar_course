import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class SearchHomeBloc extends Bloc<SearchHomeEvents, SearchHomeStates> {
  final DioHelper dioHelper;
  SearchHomeBloc(this.dioHelper) : super(SearchHomeStates()) {
    on<GetSearchHomeDataEvent>(_getData);
  }
  final searchController = TextEditingController();
  late List<SearchResult> list;
  Future<void> _getData(
      GetSearchHomeDataEvent event, Emitter<SearchHomeStates> emit) async {
    emit(SearchHomeLoadingState());
    final response = await dioHelper.get("search", params: {
      if (searchController.text.isNotEmpty) "keyword": event.value,
    });

    if (response.isSuccess) {
      list = SearchHomeData.fromJson(response.response!.data).data.searchResult;
      emit(SearchHomeSuccessState());
    } else {
      emit(SearchHomeErrorState());
    }
  }
}
