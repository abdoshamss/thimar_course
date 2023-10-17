part of'bloc.dart';

class ActivationAccountStates {}

class ActivationAccountLoadingState extends ActivationAccountStates {}

class ActivationAccountSuccessState extends ActivationAccountStates {
  final String message;

  ActivationAccountSuccessState({required this.message}){
    showMessage(message);
  }


}

class ActivationAccountErrorState extends ActivationAccountStates {
  final String message;
  final int statusCode;

  ActivationAccountErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error);
  }
}