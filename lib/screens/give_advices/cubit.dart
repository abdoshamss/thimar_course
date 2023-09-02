import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';
import 'package:thimar_course/screens/give_advices/states.dart';

import '../../core/logic/dio_helper.dart';

class GiveAdviceCubit extends Cubit<GiveAdviceStates> {
  GiveAdviceCubit() : super(GiveAdviceStates());
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final titleController = TextEditingController();

  final contentController = TextEditingController();
  Future<void> sendData() async {
    emit(GiveAdviceLoadingState());

    final response = await DioHelper.sendData("contact", data: {
      "fullname": nameController.text,
      "phone": phoneController.text,
      "title": titleController.text,
      "content": contentController.text,
    });

    if (response.isSuccess) {
      nameController.clear();
      phoneController.clear();
      titleController.clear();
      contentController.clear();

      emit(GiveAdviceSuccessState());
    } else {
      emit(GiveAdviceErrorState());
      showMessage(response.message);
    }
  }
}
