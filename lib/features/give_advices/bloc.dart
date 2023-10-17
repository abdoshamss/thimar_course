import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

import '../../core/logic/dio_helper.dart';
part 'states.dart';
part 'events.dart';

class GiveAdviceBloc extends Bloc<GiveAdviceEvents,GiveAdviceStates> {
  final DioHelper dioHelper;
  GiveAdviceBloc(this.dioHelper) : super(GiveAdviceStates()){
    on<PostGiveAdviceDataEvent>(postData);
  }
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final titleController = TextEditingController();

  final contentController = TextEditingController();
  Future<void> postData(GiveAdviceEvents events,Emitter<GiveAdviceStates> emitter) async {
    emit(GiveAdviceLoadingState());

    final response = await dioHelper.post("contact", data: {
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

      emit(GiveAdviceSuccessState(message: response.message));
    } else {
      emit(GiveAdviceErrorState(message: response.message,statusCode:  response.response!.statusCode??200));

    }
  }
}
