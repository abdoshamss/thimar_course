import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class MyOrdersDetailsBloc
    extends Bloc<MyOrdersDetailsEvents, MyOrdersDetailsStates> {
  final DioHelper dioHelper;

  MyOrdersDetailsBloc(this.dioHelper) : super(MyOrdersDetailsStates()) {
    on<GetMyOrdersDetailsDataEvent>(_getData);
  }

  Future<void> _getData(GetMyOrdersDetailsDataEvent event,
      Emitter<MyOrdersDetailsStates> emit) async {
    emit(MyOrdersDetailsLoadingState());
    final response = await dioHelper.get("client/orders/${event.id}");
    if (response.isSuccess) {
      final list = MyOrdersDetailsData.fromJson(response.response!.data);
      emit(MyOrdersDetailsSuccessState(list: list));
    } else {
      emit(MyOrdersDetailsErrorState());
    }
  }
}
