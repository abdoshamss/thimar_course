import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/logic/dio_helper.dart';
part 'states.dart';
part 'events.dart';

class PrivacyBloc extends Bloc<PrivacyEvents, PrivacyStates> {
  final DioHelper dioHelper;
  PrivacyBloc(this.dioHelper) : super(PrivacyStates()) {
    on<GetPrivacyDataEvent>(_getData);
  }
  var data;

  void _getData(GetPrivacyDataEvent event, Emitter<PrivacyStates> emitter) async {
    emit(PrivacyLoadingState());
    final response = await dioHelper.get("policy");
    if (response.isSuccess) {
      data = response.response!.data["data"]["policy"];
      debugPrint(response.response!.data["data"]["policy"]);
      emit(PrivacySuccessState());
    } else {
      emit(PrivacyErrorState());
    }
  }
}
