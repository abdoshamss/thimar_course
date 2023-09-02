import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/screens/login/model/model.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginStates());

  final phoneController = TextEditingController(text: "96655001122334455");
  final passwordController = TextEditingController(text: "123456789");

  //   96655001122334455
  //   123456789
  Future<void> postLogin( ) async {
    emit(LoginLoadingState());
    final response = await DioHelper.sendData(
      "login",
      data: {
        "phone": phoneController.text,
        "password": passwordController.text,
        "device_token": "test",
        "type": Platform.operatingSystem,
        "user_type": "client",
      },
    );
    if (response.isSuccess) {
      print(response.response!.data);
      final model = UserData.fromJson(response.response!.data);
      CacheHelper.saveLoginData(model);
      emit(LoginSuccessState());
    }else{
      print(response.message);
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(response.message),

      ),);
      emit(LoginErrorState());
    }
  }
}
