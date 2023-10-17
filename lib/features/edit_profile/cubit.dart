import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';

import 'states.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  final DioHelper dioHelper;

  EditProfileCubit(this.dioHelper) : super(EditProfileStates());
  Future<void> updateData(
      File image, String name, String phone, int cityId) async {
    emit(EditProfileLoadingState());
    final response = await dioHelper.post("client/profile", data: {
      "image": image == null
          ? null
          : MultipartFile.fromFileSync(image.path,
              filename: image.path.split("/").last),
      "fullname": name,
      "phone": phone,
      "city_id": cityId,
    });
    if (response.isSuccess) {
      emit(EditProfileSuccessState());
    } else {
      emit(EditProfileErrorState());
    }
  }
}
