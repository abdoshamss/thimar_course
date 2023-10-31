import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class ProductDetailsBLoc
    extends Bloc<ProductDetailsEvents, ProductDetailsStates> {
  final DioHelper dioHelper;

  ProductDetailsBLoc(this.dioHelper) : super(ProductDetailsStates()) {
    on<GetProductDetailsEvent>(_getData);
    on<ProductUpdateEvent>(_updateData);
  }



  Future<void> _getData(
      GetProductDetailsEvent event, Emitter<ProductDetailsStates> emit) async {
    emit(ProductDetailsLoadingState());
    final response = await dioHelper.get("products/${event.id}");
    if (response.isSuccess) {
      final list = ProductData.fromJson(response.response!.data);
      emit(ProductDetailsSuccessState(list: list));
    } else {
      emit(ProductDetailsErrorState());
    }
  }

  Future<void> _updateData(
      ProductUpdateEvent event, Emitter<ProductDetailsStates> emit) async {
    emit(ProductCountUpdateLoadingState());

    final response = await dioHelper.post("client/cart/${event.id}",
        data: {"_method": "PUT", "amount": event.amount});
    if (response.isSuccess) {
       emit(ProductCountUpdateSuccessState());

    } else {
      emit(ProductDetailsErrorState());
    }
  }
}
