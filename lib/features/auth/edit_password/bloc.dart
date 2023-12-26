import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';
part 'events.dart';

class EditPasswordBloc extends Bloc<EditPasswordEvents, EditPasswordStates> {
  final DioHelper dioHelper;
  EditPasswordBloc(this.dioHelper) : super(EditPasswordStates()) {
    on<PostEditPasswordDataEvent>(_postData);
  }

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  Future<void> _postData(
      EditPasswordEvents event, Emitter<EditPasswordStates> emit) async {
    emit(EditPasswordLoadingState());

    final response = await dioHelper.post("edit_password", data: {
    "old_password": oldPasswordController.text,
    "password": confirmNewPasswordController.text,
      "_method": "PUT",    });
    if (response.isSuccess) {
      emit(EditPasswordSuccessState(message: response.message));
    } else {
      emit(EditPasswordErrorState(
        message: response.message,
        statueCode: response.response?.statusCode ?? 200,
      ));
    }
  }
}
