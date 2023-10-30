import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class CartDataBloc extends Bloc<CartDataEvents, CartDataStates> {
  final DioHelper dioHelper;

  CartDataBloc(this.dioHelper) : super(CartDataStates()) {
    on<GetCartDataEvent>(_getData);
    on<DeleteFromCartDataEvent>(_deleteData);
    on<CartUpdateEvent>(_updateData);
    on<ApplyCouponEvent>(_applyCoupon);
  }
  List<Data> cartData = [];
  bool loading = true;
  Future<void> _getData(
      GetCartDataEvent event, Emitter<CartDataStates> emit) async {
    if (loading) {
      emit(CartDataLoadingState());
    }
    final response = await dioHelper.get("client/cart");
    if (response.isSuccess) {
      final list = CartData.fromJson(response.response!.data);
      cartData = CartData.fromJson(response.response!.data).data;
      loading = false;
      emit(CartDataSuccessState(list: list));
    } else {
      emit(CartDataErrorState());
    }
  }

  Future<void> _deleteData(
      DeleteFromCartDataEvent event, Emitter<CartDataStates> emit) async {
    // emit(DeleteFromCartLoadingState());
    final response =
        await dioHelper.delete("client/cart/delete_item/${event.id}");
    if (response.isSuccess) {
      cartData.removeAt(event.index);
      add(GetCartDataEvent());
      // emit(DeleteFromCartSuccessState());
    } else {
      emit(DeleteFromCartErrorState());
    }
  }

  Future<void> _updateData(
      CartUpdateEvent event, Emitter<CartDataStates> emit) async {
    // emit(UpdateFromCartLoadingState());

    final response = await dioHelper.post("client/cart/${event.id}",
        data: {"_method": "PUT", "amount": event.amount});
    if (response.isSuccess) {
      emit(UpdateFromCartSuccessState());
      add(GetCartDataEvent());
    } else {
      emit(UpdateFromCartErrorState());
    }
  }
  final couponController=TextEditingController();
  Future<void> _applyCoupon(
      ApplyCouponEvent event, Emitter<CartDataStates> emit) async {
    final data = {
      "code": couponController.text,
    };
    emit(ApplyCouponLoadingState());
    final response =
    await dioHelper.post("client/cart/apply_coupon", data: data);
    if (response.isSuccess) {
      emit(ApplyCouponSuccessState(message: response.message));
      add(GetCartDataEvent());
    } else {
      emit(ApplyCouponErrorState(message: response.message));
    }
  }
}
