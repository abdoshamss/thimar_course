import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';
import 'package:thimar_course/features/get_cities/model.dart';
import 'states.dart';

class GetCitiesScreenCubit extends Cubit<GetCitiesScreenStates> {
  GetCitiesScreenCubit() : super(GetCitiesScreenStates());

  Future<void> getCities() async {
    emit(GetCitiesScreenLoadingState());

    final response = await DioHelper.getData("cities/1");
    if (response.isSuccess) {
      final list =CitiesData.fromJson(response.response!.data).list;
      emit(GetCitiesScreenSuccessState(list: list));

    } else {
      emit(GetCitiesScreenErrorState());
    }
  }
}
