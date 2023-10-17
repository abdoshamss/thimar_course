part of'bloc.dart';

class ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
  final String message;

  ForgetPasswordSuccessState({required this.message}){
    showMessage(message);
  }
}

class ForgetPasswordErrorState extends ForgetPasswordStates {
  final String message;
  final int statusCode;

  ForgetPasswordErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error);
  }
}