import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/screens/home/view.dart';

import '../../core/logic/dio_helper.dart';
import '../../core/logic/helper_methods.dart';
import '../../gen/assets.gen.dart';

part 'states.dart';
part 'events.dart';

class CompleteOrderBloc extends Bloc<CompleteOrderEvents, CompleteOrderStates> {
  final DioHelper dioHelper;

  CompleteOrderBloc(this.dioHelper) : super(CompleteOrderStates()) {
    on<PostCompleteOrderDataEvent>(_postData);
  }
  final noteController = TextEditingController();
  Future<void> _postData(PostCompleteOrderDataEvent event,
      Emitter<CompleteOrderStates> emit) async {
    emit(CompleteOrderLoadingState());
    final data = {
      "address_id": event.addressId,
      if (event.time != null) "time": event.time,
      // if(event.date!=null)  "date": DateFormat.yMd().format(event.date!),
      if (event.date != null)
        "date":event.date,
      // "date":"2023-11-30",
      // "time":"14:34",
      "note": noteController.text,
      "pay_type": "cash",
      "transaction_id": "123",
      "coupon_code": event.coupon,
      "city_id": CacheHelper.getCityId(),
    };

    final response = await dioHelper.post("/client/orders", data: data);
    if (response.isSuccess) {
      emit(CompleteOrderSuccessState());
    } else {
      emit(CompleteOrderErrorState(statusCode: response.response!.statusCode,message: response.message));
    }
  }
}
