part of'bloc.dart';

class AddToCartStates {}

class AddToCartLoadingState extends AddToCartStates {}

class AddToCartSuccessState extends AddToCartStates {
  final String message ;

  AddToCartSuccessState({required this.message}){
    showMessage(message);
  }
}

class AddToCartErrorState extends AddToCartStates {
  final String message;
  final int statusCode;

  AddToCartErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error);
  }
}