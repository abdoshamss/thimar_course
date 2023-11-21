import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';
part 'events.dart';

class ActivationBloc
    extends Bloc<ActivationAccountEvents, ActivationAccountStates> {
  final DioHelper dioHelper;
  ActivationBloc(this.dioHelper) : super(ActivationAccountStates()) {
    on<PostActivationAccountDataEvent>(_postData);
  }
  var phone;
  final codeController = TextEditingController();
  Future<void> _postData(PostActivationAccountDataEvent event,
      Emitter<ActivationAccountStates> emit) async {
    final map = {
      "phone": phone,
      "code": codeController.text,
      "device_token": FirebaseMessaging.instance.getToken(),
      "type": Platform.operatingSystem,
    };
    emit(ActivationAccountLoadingState());
    final response = await dioHelper.post("verify", data: map);
    if (response.isSuccess) {
      emit(ActivationAccountSuccessState(message: response.message));
    } else {
      emit(ActivationAccountErrorState(
          message: response.message,
          statusCode: response.response?.statusCode ?? 200));
    }
  }
}
