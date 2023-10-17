import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class ProductsDataBloc extends Bloc<ProductsDataEvents, GetProductsDataStates> {
  final DioHelper dioHelper;
  ProductsDataBloc(this.dioHelper) : super(GetProductsDataStates()) {
    on<GetProductsDataEvent>(_getData);
  }
  Future<void> _getData(
      ProductsDataEvents event, Emitter<GetProductsDataStates> emit) async {
    emit(GetProductsDataLoadingState());
    final response = await dioHelper.get("products");
    if (response.isSuccess) {
      final list = ProductsData.fromJson(response.response!.data).data;
      emit(GetProductsDataSuccessState(list: list));
    } else {
      emit(GetProductsDataErrorState());
    }
  }
}
