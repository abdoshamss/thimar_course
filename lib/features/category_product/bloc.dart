
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvents, CategoryProductStates> {
  final DioHelper dioHelper;
  CategoryProductBloc(this.dioHelper) : super(CategoryProductStates()) {
    on<GetCategoryProductEvent>(_getData);
  }

  Future<void> _getData(GetCategoryProductEvent event,
      Emitter<CategoryProductStates> emit) async {
    emit(CategoryProductLoadingState());
    final response = await dioHelper.get("categories/${event.id}");

    final list = CategoryProductModel.fromJson(response.response!.data);

    if (response.isSuccess) {
      emit(CategoryProductSuccessState(list: list));
    } else {
      emit(CategoryProductErrorState());
    }
  }
}
