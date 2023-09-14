import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class ResendCodeBloc extends Bloc<ResendCodeEvents,ResendCodeStates> {
  final DioHelper dioHelper;
  ResendCodeBloc(this.dioHelper) : super(ResendCodeStates()){
    on<PostResendCodeDataEvent>(_postData);
  }
  var phone;
  Future<void>  _postData(ResendCodeEvents events,Emitter<ResendCodeStates>emitter) async {
    emit(ResendCodeLoadingState());
     final  map = {
      "phone": phone,
    };
    final response = await dioHelper.post("resend_code", data: map);

    if (response.isSuccess) {
      emit(ResendCodeSuccessState(
        message: response.message,
      ));
      debugPrint(response.message);
    } else {
      emit(ResendCodeErrorState(
          message: response.message,
          statusCode: response.response?.statusCode ?? 200));
    }
    debugPrint(response.message);
  }
}
