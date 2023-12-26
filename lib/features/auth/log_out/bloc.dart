import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class LogOutBLoc extends Bloc<LogOutEvents, LogOutStates> {
  final DioHelper dioHelper;
  LogOutBLoc(this.dioHelper) : super(LogOutStates()) {
    on<PostLogOutDataEvent>(_postData);
  }
  Future<void> _postData(
      LogOutEvents events, Emitter<LogOutStates> emitter) async {
    final map = {
      "device_token": FirebaseMessaging.instance.getToken(),
      "type": Platform.operatingSystem,
    };
    emit(LogOutLoadingState());
    final response = await dioHelper.post("logout", data: map);
    if (response.isSuccess) {
      emit(LogOutSuccessState(text: response.message));
    } else {
      emit(LogOutErrorState(text:  response.message));
    }
  }
}
