import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class AboutAppBloc extends Bloc<AboutDataEvents, AboutAppStates> {
  final DioHelper dioHelper;
  AboutAppBloc(this.dioHelper) : super(AboutAppStates()) {
    on<GetAboutDataEvent>(_getAboutData);
  }

  var data;

  Future<void> _getAboutData(
      GetAboutDataEvent event, Emitter<AboutAppStates> emitter) async {
    emit(GetAboutDetailsLoadingState());
    final response = await dioHelper.get("about");

    data = response.response!.data["data"]["about"];

    if (response.isSuccess) {
      emit(GetAboutDetailsSuccessState());
      debugPrint(response.message);
    } else {
      emit(GetAboutDetailsErrorState());
      debugPrint(response.message);
    }
  }
}
