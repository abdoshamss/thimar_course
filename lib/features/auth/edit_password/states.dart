part of'bloc.dart';

class EditPasswordStates {}

class EditPasswordLoadingState extends EditPasswordStates {}

class EditPasswordSuccessState extends EditPasswordStates {
  final String message;

  EditPasswordSuccessState({required this.message}){
    showMessage(message);
  }
}

class EditPasswordErrorState extends EditPasswordStates {
  final String message;
  final int statueCode;

  EditPasswordErrorState({required this.message, required this.statueCode}){
    showMessage(message,messageType: MessageType.error);
  }
}