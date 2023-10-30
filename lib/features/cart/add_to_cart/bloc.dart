import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/screens/cart.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../gen/assets.gen.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class AddToCartBloc extends Bloc<AddToCartEvents, AddToCartStates> {
  final DioHelper dioHelper;
  AddToCartBloc(this.dioHelper) : super(AddToCartStates()) {
    on<PostAddToCartDataEvent>(_postData);
  }
  Future<void> _postData(
      PostAddToCartDataEvent event, Emitter<AddToCartStates> emitter) async {
    emit(AddToCartLoadingState());
    final map = {
      "product_id": event.id,
      "amount": event.amount,
    };
    final response = await dioHelper.post("client/cart", data: map);
    if (response.isSuccess) {
      final list = AddToCarData.fromJson(response.response!.data);

      emit(AddToCartSuccessState(message: response.message, list: list));
    } else {
      emit(AddToCartErrorState(
        message: response.message,
        statusCode: response.response!.statusCode ?? 200,
      ));
    }
  }
}
