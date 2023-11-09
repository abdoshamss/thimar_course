import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';

part 'events.dart';

class CurrentLocationBloc
    extends Bloc<CurrentLocationEvents, CurrentLocationStates> {
  final DioHelper dioHelper;

  CurrentLocationBloc(this.dioHelper) : super(CurrentLocationStates()) {
    on<PostCurrentLocationDataEvent>(_postData);
  }

  Future<void> _postData(PostCurrentLocationDataEvent event,
      Emitter<CurrentLocationStates> emit) async {
    emit(CurrentLocationLoadingState());
    final data = {"lat": event.lat, "lng":event.lng};
    final response = await dioHelper.post("current_location", data: data);
    if (response.isSuccess) {
      emit(CurrentLocationSuccessState());
    } else {
      emit(CurrentLocationErrorState());
    }
  }
}
