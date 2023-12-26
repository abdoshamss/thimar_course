part of'bloc.dart';

class MyCurrentOrdersStates {}

class MyCurrentOrdersLoadingState extends MyCurrentOrdersStates {}

class MyCurrentOrdersSuccessState extends MyCurrentOrdersStates {
  MyCurrentOrdersData list;
  MyCurrentOrdersSuccessState({required this.list});

}

class MyCurrentOrdersErrorState extends MyCurrentOrdersStates {
  final String? text;

  MyCurrentOrdersErrorState({required this.text});
}