import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_course/core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class TermsBloc extends Bloc<TermsDataEvents, TermsStates> {
  final DioHelper dioHelper;
  TermsBloc(this.dioHelper) : super(TermsStates()) {
    on<GetTermsDataEvent>(_getAboutData);
  }

  var data;

  Future<void> _getAboutData(
      GetTermsDataEvent event, Emitter<TermsStates> emit) async {
    emit(TermsDataLoadingState());
    final response = await dioHelper.get("terms");

    data = response.response!.data["data"]["terms"];

    if (response.isSuccess) {
      emit(TermsDataSuccessState());

    } else {
      emit(TermsDataErrorState());
      debugPrint(response.message);
    }
  }
}
