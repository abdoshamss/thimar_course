part of'bloc.dart';

class MyOrdersDetailsStates {}

class MyOrdersDetailsLoadingState extends MyOrdersDetailsStates {}

class MyOrdersDetailsSuccessState extends MyOrdersDetailsStates {
  MyOrdersDetailsData list;
  MyOrdersDetailsSuccessState({required this .list});
}

class MyOrdersDetailsErrorState extends MyOrdersDetailsStates {}