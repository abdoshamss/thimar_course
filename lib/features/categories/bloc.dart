import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
part 'states.dart';
part 'models.dart';
part 'events.dart';

class CategoriesBloc extends Bloc<CategoriesEvents, CategoriesStates> {
  final DioHelper dioHelper;
  CategoriesBloc(this.dioHelper) : super(CategoriesStates()) {
    on<GetCategoriesDataEvent>(_getData);
  }

  Future<void> _getData(
      CategoriesEvents events, Emitter<CategoriesStates> emitter) async {
    emit(CategoriesLoadingState());
    final response = await dioHelper.get("categories");
    CategoriesModels.fromJson(response.response!.data);
    final list = CategoriesModels.fromJson(response.response!.data);

    if (response.isSuccess) {
      emit(CategoriesSuccessState(list: list));
    } else {
      emit(CategoriesErrorState());
    }
  }
}
