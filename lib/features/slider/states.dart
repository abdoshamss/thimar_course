part of 'bloc.dart';

class SliderDataStates {}

class SliderDataLoadingState extends SliderDataStates {}

class SliderDataSuccessState extends SliderDataStates {
  List<SliderModel> list;

  SliderDataSuccessState({required this.list});
}

class SliderDataErrorState extends SliderDataStates {}
