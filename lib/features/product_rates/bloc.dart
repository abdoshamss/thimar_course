import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class ProductRatesBloc extends Bloc<ProductRatesEvents, ProductRatesStates> {
  final DioHelper dioHelper;
  ProductRatesBloc(this.dioHelper) : super(ProductRatesStates()) {
    on<GetProductRatesEvent>(_getData);
    on<PostProductRatesEvent>(_postData);
  }
  Future<void> _getData(
      GetProductRatesEvent event, Emitter<ProductRatesStates> emit) async {
    emit(ProductRatesLoadingState());
    final response = await dioHelper.get("products/2/rates");
    if (response.isSuccess) {
      final list = ProductRatesData.fromJson(response.response!.data).list;
      emit(ProductRatesSuccessState(list: list));
    } else {
      emit(ProductRatesErrorState());
    }
  }

  Future<void> _postData(
      PostProductRatesEvent event, Emitter<ProductRatesStates> emit) async {
    emit(AddProductRatesLoadingState());
    final map = {
      'value': event.value,
      'comment': event.comment,
    };
    final response = await dioHelper.post("client/products/${event.id}/rate", data: map);
    if (response.isSuccess) {
      emit(AddProductRatesSuccessState(message: response.message));
    } else {
      emit(AddProductRatesErrorState(
          statusCode: response.response!.statusCode ?? 200,
          message: response.message));
    }
  }
}
