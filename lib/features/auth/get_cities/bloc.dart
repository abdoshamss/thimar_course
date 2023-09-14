import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';
part 'states.dart';
part 'model.dart';
part 'events.dart';

class GetCitiesScreenBLoc extends Bloc<CitiesScreenEvents, CitiesScreenStates> {
  final DioHelper dioHelper;

  GetCitiesScreenBLoc(this.dioHelper) : super(CitiesScreenStates()) {
    on<GetCitiesScreenDataEvent>(_getData);
  }

  Future<void> _getData(
      CitiesScreenEvents events, Emitter<CitiesScreenStates> emitter) async {
    emit(GetCitiesScreenLoadingState());

    final response = await dioHelper.get("cities/1");
    if (response.isSuccess) {
      final list = CitiesData.fromJson(response.response!.data).list;
      emit(GetCitiesScreenSuccessState(list: list));
     } else {
      emit(GetCitiesScreenErrorState());
    }
  }
}
