import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
part 'states.dart';
part 'model.dart';
part 'events.dart';

class LoginBLoc extends Bloc<LoginEvents, LoginStates> {
  final DioHelper dioHelper;
  LoginBLoc(this.dioHelper) : super(LoginStates()) {
    on<PostLoginDataEvent>(_postData);
  }

  final phoneController = TextEditingController(text: "96655001122334455");
  final passwordController = TextEditingController(text: "123456789");

  //   96655001122334455
  //   123456789
  Future<void> _postData(LoginEvents events,Emitter<LoginStates>emitter) async {
    emit(LoginLoadingState());
    final response = await dioHelper.post(
      "login",
      data: {
        "phone": phoneController.text,
        "password": passwordController.text,
        "device_token": FirebaseMessaging.instance.getToken(),
        "type": Platform.operatingSystem,
        "user_type": "client",
      },
    );
    if (response.isSuccess) {
      final model = UserData.fromJson(response.response!.data);
      CacheHelper.saveLoginData(model);

      emit(LoginSuccessState(message: response.message));
    } else {
      emit(LoginErrorState(
          message: response.message,
          statusCode: response.response?.statusCode ?? 200));
    }
  }
}
