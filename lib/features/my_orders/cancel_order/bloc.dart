import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';

part 'events.dart';

class CancelOrderBloc extends Bloc<CancelOrderEvents, CancelOrderStates> {
  final DioHelper dioHelper;

  CancelOrderBloc(this.dioHelper) : super(CancelOrderStates()) {
    on<PostCancelOrderDataEvent>(_cancelOrder);
  }

  Future<void> _cancelOrder(
      PostCancelOrderDataEvent event, Emitter<CancelOrderStates> emit) async {
    emit(CancelOrderLoadingState());
    final response = await dioHelper.post("client/orders/${event.id}/cancel");
    if (response.isSuccess) {
      emit(CancelOrderSuccessState(message: response.message

      ));

    } else {
      emit(CancelOrderErrorState());
    }
  }
}
