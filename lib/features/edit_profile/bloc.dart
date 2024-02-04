import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

part 'events.dart';

part 'states.dart';

class EditProfileBloc extends Bloc<EditProfileEvents, EditProfileStates> {
  final DioHelper dioHelper;

  EditProfileBloc(this.dioHelper) : super(EditProfileStates()) {
    on<PostEditProfileDataEvent>(_updateData);
  }

  Future<void> _updateData(
      PostEditProfileDataEvent event, Emitter<EditProfileStates> emit) async {
    emit(EditProfileLoadingState());
    final response = await dioHelper.post("client/profile", data: {
      if (event.image != null)
        "image": MultipartFile.fromFileSync(event.image!.path,
            filename: event.image!.path.split("/").last),
      "fullname": event.name,
      "phone": event.phone,
      "city_id": event.cityId,
    });
    if (response.isSuccess) {
      emit(EditProfileSuccessState(message: response.message));
    } else {
      emit(EditProfileErrorState(message: response.message));
    }
  }
}
