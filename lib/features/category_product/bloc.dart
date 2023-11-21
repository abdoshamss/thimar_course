
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
import '../products/bloc.dart';

part 'states.dart';
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

    final list = ProductsData.fromJson(response.response!.data).list;

    if (response.isSuccess) {
      emit(CategoryProductSuccessState(list: list));
    } else {
      emit(CategoryProductErrorState());
    }
  }
}
