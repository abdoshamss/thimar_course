import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';

part 'events.dart';

class MyCurrentOrdersBloc
    extends Bloc<MyCurrentOrdersEvents, MyCurrentOrdersStates> {
  final DioHelper dioHelper;

  MyCurrentOrdersBloc(this.dioHelper) : super(MyCurrentOrdersStates()) {
    on<GetMyCurrentOrdersDataEvent>(_getData);
  }

  Future<void> _getData(GetMyCurrentOrdersDataEvent event,Emitter<MyCurrentOrdersStates>emit) async {
    emit(MyCurrentOrdersLoadingState());
    final response =await dioHelper.get("client/orders/current");
    if(response.isSuccess){
      final list =MyCurrentOrdersData.fromJson(response.response!.data);
      emit(MyCurrentOrdersSuccessState(list: list));
    }else{
      emit(MyCurrentOrdersErrorState());
    }
    
    
  }
}
