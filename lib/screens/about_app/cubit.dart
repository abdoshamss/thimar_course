import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';
import 'package:thimar_course/screens/about_app/states.dart';

class AboutAppCubit extends Cubit<AboutAppStates> {
  AboutAppCubit() : super(AboutAppStates());

  var data;
  Future<void> getAboutData() async {
    emit(GetAboutDetailsLoadingState());
    final response = await DioHelper.getData("about");

    data = response.response!.data["data"]["about"];
    if (response.isSuccess) {
      emit(GetAboutDetailsSuccessState());
      print(response.message);
    } else {
      emit(GetAboutDetailsErrorState());
      print(response.message);
    }
  }
}
