import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';
part 'events.dart';

class CheckCodeBloc extends Bloc<CheckCodeEvents,CheckCodeStates> {
  final DioHelper dioHelper;
  CheckCodeBloc(this.dioHelper) : super(CheckCodeStates()){
    on<PostCheckCodeDataEvent>(_postData);
  }
  final codeController = TextEditingController();
  late String phone;
  Future<void> _postData(PostCheckCodeDataEvent event,Emitter<CheckCodeStates>emit) async {
    emit(CheckCodeLoadingState());
    final map = {
      'code': codeController.text,
      'phone': phone,
    };
    final response = await dioHelper.post("check_code", data: map);
    if (response.isSuccess) {
      emit(CheckCodeSuccessState(message: "تم بنجاح"));
    } else {
      emit(CheckCodeErrorState(
          message: response.message,
          statueCode: response.response?.statusCode ?? 200));

     }
  }
}
