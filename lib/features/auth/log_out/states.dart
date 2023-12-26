part of'bloc.dart';

class LogOutStates {}

class LogOutLoadingState extends LogOutStates {}

class LogOutSuccessState extends LogOutStates {
  final String text;

  LogOutSuccessState({required this.text}){
    showMessage(text);
  }
}

class LogOutErrorState extends LogOutStates {
  final String text;

  LogOutErrorState({required this.text}){
    showMessage(text);
  }
}