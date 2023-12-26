import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';

part 'events.dart';

class ContactUsBloc extends Bloc<ContactUsEvents, ContactUsStates> {
  final DioHelper dioHelper;

  ContactUsBloc(this.dioHelper) : super(ContactUsStates()) {
    on<GetContactUsDataEvent>(_getData);
    on<PostContactUsDataEvent>(_postData);
  }

  Future<void> _getData(
      GetContactUsDataEvent event, Emitter<ContactUsStates> emit) async {
    emit(GetContactUsDataLoadingState());
    final response = await dioHelper.get("contact");
    final list = ContactUsData.fromJson(response.response!.data);
    if (response.isSuccess) {
      emit(GetContactUsDataSuccessState(list: list));
    } else {
      emit(GetContactUsDataErrorState(message: response.message,statusCode: response.response!.statusCode??200));
    }
  }
  final nameController =TextEditingController();
  final phoneController =TextEditingController();
  final contentController =TextEditingController();
Future<void> _postData(
      PostContactUsDataEvent event, Emitter<ContactUsStates> emit) async {
    emit(PostContactUsDataLoadingState());
    final response = await dioHelper.post("contact",data: {
      "fullname":nameController.text,
      "phone":phoneController.text,
      "title":"test",
      "content":contentController.text,
    });

    if (response.isSuccess) {
      emit(PostContactUsDataSuccessState(message: response.message));
      nameController.clear();
      phoneController.clear();
      contentController.clear();
    } else {
      emit(PostContactUsDataErrorState(message: response.message,statusCode: response.response!.statusCode??200));
    }
  }


}
