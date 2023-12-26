import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/helper_methods.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class ChargeBloc extends Bloc<ChargeEvents, ChargeStates> {
  final DioHelper dioHelper;

  ChargeBloc(this.dioHelper) : super(ChargeStates()) {
    on<PostChargeDataEvent>(_charge);
  }
final amountController=TextEditingController();
  Future<void> _charge(
      PostChargeDataEvent event, Emitter<ChargeStates> emit) async {
    emit(ChargeLoadingState());
    final response = await dioHelper.post("wallet/charge", data: {
      "amount": amountController.text,
      "transaction_id": 1111,
    });
    if(response.isSuccess){
      emit(ChargeSuccessState(message: response.message));
      amountController.clear();
    }else{
      emit(ChargeErrorState());
    }
  }
}
