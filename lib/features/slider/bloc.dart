import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class SliderDataBloc extends Bloc<SliderEvents, SliderDataStates> {
  final DioHelper dioHelper;
  SliderDataBloc(this.dioHelper) : super(SliderDataStates()) {
    on<GetSliderEvent>(_getData);
  }
  int currentPage = 0;
  final pageController = PageController(initialPage: 0);
  Future<void> _getData(
      SliderEvents event, Emitter<SliderDataStates> emit) async {
    emit(SliderDataLoadingState());
    final response = await dioHelper.get("sliders");

    if (response.isSuccess) {
      final list = SliderData.fromJson(response.response!.data).list;
      emit(SliderDataSuccessState(list: list));
    } else {
      emit(SliderDataErrorState());
    }
  }
}
