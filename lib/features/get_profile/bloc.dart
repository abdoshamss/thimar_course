import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/cache_helper.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class GetProfileDataBloc extends Bloc<GetProfileDataEvents, GetProfileDataStates> {
  final DioHelper dioHelper;

  GetProfileDataBloc(this.dioHelper) : super(GetProfileDataStates()) {
    on<GetProfileDataEvent>(_getData);
  }
  Future<void> _getData(
      GetProfileDataEvent event, Emitter<GetProfileDataStates> emit) async {
    emit(GetProfileDataLoadingState());
    final response = await dioHelper.get("client/profile");
    final list =ProfileData.fromJson(response.response!.data);
    if (response.isSuccess) {
      emit(GetProfileDataSuccessState(list: list));
    await  CacheHelper.setIsVip(list.data.isVip);

    } else {
      emit(GetProfileDataErrorState());
    }
  }
}
