part of'bloc.dart';

class CancelOrderStates {}

class CancelOrderLoadingState extends CancelOrderStates {}

class CancelOrderSuccessState extends CancelOrderStates {
  final String message;

  CancelOrderSuccessState({required this.message}){
    showMessage(message);
  }
}

class CancelOrderErrorState extends CancelOrderStates {

  final String message;
final int statusCode;
  CancelOrderErrorState( {required this.statusCode, required this.message}){
    showMessage(message);
  }
}