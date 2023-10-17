import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';

import '../../../core/logic/helper_methods.dart';
part 'states.dart';
part 'events.dart';
class RegisterBloc extends Bloc<RegisterEvents,RegisterStates> {

  final DioHelper dioHelper;
  RegisterBloc(this.dioHelper) : super(RegisterStates()){
    on<PostRegisterDataEvent>(_postData);
  }

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  Future<void> _postData(RegisterEvents events, Emitter<RegisterStates>emitter) async {
    emit(RegisterLoadingState());

    final map = {
      "fullname": fullNameController.text,
      "phone": phoneController.text,
      "password": passwordController.text,
      "password_confirmation": passwordConfirmController.text,
    };

    final response = await dioHelper.post("client_register", data: map);
    if (response.isSuccess) {
      emit(RegisterSuccessState(message: response.message));
      debugPrint(response.message);
    } else {
      emit(RegisterErrorState(
          message: response.message,
          statusCode: response.response?.statusCode ?? 200));

      debugPrint("failed");
    }
  }
}
