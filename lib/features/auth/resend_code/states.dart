part of'bloc.dart';

class ResendCodeStates {}

class ResendCodeLoadingState extends ResendCodeStates {}

class ResendCodeSuccessState extends ResendCodeStates {
  final String message;

  ResendCodeSuccessState({required this.message}) {
    showMessage(message);
  }
}

class ResendCodeErrorState extends ResendCodeStates {
  final String message;
  final int statusCode;

  ResendCodeErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error);

  }
}