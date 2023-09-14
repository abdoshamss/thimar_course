part of'bloc.dart';

class CheckCodeStates {}

class CheckCodeLoadingState extends CheckCodeStates {}

class CheckCodeSuccessState extends CheckCodeStates {
  final String message;

  CheckCodeSuccessState({required this.message}){
    showMessage(message);
  }
}

class CheckCodeErrorState extends CheckCodeStates {
  final String message ;
  final int statueCode;

  CheckCodeErrorState({required this.message, required this.statueCode}){
    showMessage(message,messageType: MessageType.error);
  }
}