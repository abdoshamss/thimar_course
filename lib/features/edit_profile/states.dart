part of 'bloc.dart';

class EditProfileStates {}

class EditProfileLoadingState extends EditProfileStates {}

class EditProfileSuccessState extends EditProfileStates {
  final String message;

  EditProfileSuccessState({required this.message}){
    showMessage(message);
  }
}

class EditProfileErrorState extends EditProfileStates {
  final String message;

  EditProfileErrorState({required this.message}){
    showMessage(message,messageType: MessageType.error);
  }
}
