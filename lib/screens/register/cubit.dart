import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';
import '../../core/logic/helper_methods.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterStates());

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  Future<void> register() async {
    emit(RegisterLoadingState());
    final response = await DioHelper.post("client_register", data: {
      "fullname": fullNameController,
      "phone": phoneController,
      "password": passwordController,
      "password_confirmation": passwordConfirmController,
    });
    if (response.isSuccess) {
      emit(RegisterSuccessState());
      print(response.message);
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(response.message),
        ),
      );
    } else {
      emit(RegisterErrorState());
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(response.message),
        ),
      );
    }
  }
}
