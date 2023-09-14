part of 'bloc.dart';

class RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final String message;

  RegisterSuccessState({required this.message}) {
    showMessage(message);
  }
}

class RegisterErrorState extends RegisterStates {
  final String message;
  final int statusCode;

  RegisterErrorState({required this.message, required this.statusCode}) {
    showMessage(message, messageType: MessageType.error);
  }
}
