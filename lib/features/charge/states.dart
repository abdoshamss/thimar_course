part of'bloc.dart';

class ChargeStates {}

class ChargeLoadingState extends ChargeStates {}

class ChargeSuccessState extends ChargeStates {
  final String message;

  ChargeSuccessState({required this.message}){
    showMessage(message);
  }
}

class ChargeErrorState extends ChargeStates {}