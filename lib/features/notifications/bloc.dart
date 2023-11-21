import 'package:flutter/cupertino.dart';
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
      NotificationsEvents events, Emitter<NotificationsStates> emitter) async {
    emit(NotificationsLoadingState());
    final response = await dioHelper.get("notifications");



    if (response.isSuccess) {
      final list =
          NotificationData.fromJson(response.response!.data);
      debugPrint(response.message);

      emit(NotificationsSuccessState(list: list, message: response.message));
    } else {
      emit(NotificationsErrorState(message: response.message));
    }
  }
}
