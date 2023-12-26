part of'bloc.dart';

class MyFinishedOrdersStates {}

class MyFinishedOrdersLoadingState extends MyFinishedOrdersStates {}

class MyFinishedOrdersSuccessState extends MyFinishedOrdersStates {
  MyFinishedOrdersData list;
  MyFinishedOrdersSuccessState({required this .list});
}

class MyFinishedOrdersErrorState extends MyFinishedOrdersStates {
  final String? text;

  MyFinishedOrdersErrorState({required this.text});
}