import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class ProductsDataBloc extends Bloc<ProductsDataEvents, GetProductsDataStates> {
  final DioHelper dioHelper;
  ProductsDataBloc(this.dioHelper) : super(GetProductsDataStates()) {
    on<GetProductsDataEvent>(_getData);
  } final searchController = TextEditingController();
  Future<void> _getData(
      GetProductsDataEvent event, Emitter<GetProductsDataStates> emit) async {
    emit(GetProductsDataLoadingState());
    final response = await dioHelper.get("products",params: {
      if(event.id!=null) "category_id":event.id,
      if (searchController.text.isNotEmpty) "keyword": event.value,
      if (event.filter!= null) "filter": event.filter,
      if (event.minPrice != null) "min_price": event.minPrice,
      if (event.maxPrice != null) "max_price": event.maxPrice,
    });
    if (response.isSuccess) {
      final list = ProductsData.fromJson(response.response!.data).list;
      emit(GetProductsDataSuccessState(list: list));
    } else {
      emit(GetProductsDataErrorState(text: response.message));
    }
  }
}
