
part of'bloc.dart';
class LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String message;

  LoginSuccessState({required this.message}){
    showMessage(message);
  }
}

class LoginErrorState extends LoginStates {
  final String message;
  final int statusCode;

  LoginErrorState({required this.message,required this.statusCode}){
    showMessage(message,messageType: MessageType.error);
  }
}