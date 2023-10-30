import 'package:flutter_bloc/flutter_bloc.dart';
 
import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';
part 'events.dart';

class MyFinishedOrdersBloc
    extends Bloc<MyFinishedOrdersEvents, MyFinishedOrdersStates> {
  final DioHelper dioHelper;

  MyFinishedOrdersBloc(this.dioHelper) : super(MyFinishedOrdersStates()) {
    on<GetMyFinishedOrdersDataEvent>(_getData);
  }

  Future<void> _getData(GetMyFinishedOrdersDataEvent event ,Emitter<MyFinishedOrdersStates>emit) async {
    emit(MyFinishedOrdersLoadingState());
    final response = await dioHelper.get("client/orders/finished");
    if (response.isSuccess){
        final list =MyFinishedOrdersData.fromJson(response.response!.data);
        emit(MyFinishedOrdersSuccessState(list: list));

    }else{
     emit(MyFinishedOrdersErrorState()); 
    }
  }
}