import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class NotificationsBloc extends Bloc<NotificationsEvents, NotificationsStates> {
  final DioHelper dioHelper;
  NotificationsBloc(this.dioHelper) : super(NotificationsStates()) {
    on<GetNotificationsDataEvent>(_getData);
  }
  Future<void> _getData(
      GetNotificationsDataEvent event, Emitter<NotificationsStates> emit) async {
    emit(NotificationsLoadingState());
    final response = await dioHelper.get("notifications");

      final list =

      List.from(response.response!.data?['data']?['notifications'] ?? [])
          .map((e) => Notifications.fromJson(e))
          .toList();



    if (response.isSuccess) {

      emit(NotificationsSuccessState(list: list, message: response.message));
    } else {
      emit(NotificationsErrorState(message: response.message));
    }
  }
}
