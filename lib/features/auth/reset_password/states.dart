part of'bloc.dart';

class ResetPasswordStates {}

class ResetPasswordLoadingState extends ResetPasswordStates {}

class ResetPasswordSuccessState extends ResetPasswordStates {
  final String message;

  ResetPasswordSuccessState({required this.message}){
    showMessage(message);
  }
}

class ResetPasswordErrorState extends ResetPasswordStates {
  final String message;
  final int statueCode;

  ResetPasswordErrorState({required this.message, required this.statueCode}){
    showMessage(message,messageType: MessageType.error);
  }
}