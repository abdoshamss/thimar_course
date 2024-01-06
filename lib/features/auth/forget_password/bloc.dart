import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';
part 'events.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvents,ForgetPasswordStates> {
  final DioHelper dioHelper;
  ForgetPasswordBloc(this.dioHelper) : super(ForgetPasswordStates()){
    on<PostForgetPasswordDataEvent>(_postData);
  }
  final phoneController = TextEditingController(text: "966512345188");

   var code;
  Future<void> _postData(ForgetPasswordEvents event,Emitter<ForgetPasswordStates>emit) async {
    emit(ForgetPasswordLoadingState());
    final map = {
      "phone": phoneController.text,
    };
    final response = await dioHelper.post("forget_password", data: map);
    code = response.response!.data["dev_message"].toString();
    if (response.isSuccess) {
      emit(ForgetPasswordSuccessState(message: response.message));
      debugPrint(response.message);
    } else {
      emit(ForgetPasswordErrorState(
          message: response.message,
          statusCode: response.response?.statusCode ?? 200));
      debugPrint("Failed" * 30);
    }
  }
}
