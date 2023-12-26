part of 'bloc.dart';

class ContactUsStates {}

class GetContactUsDataLoadingState extends ContactUsStates {}

class GetContactUsDataSuccessState extends ContactUsStates {
  ContactUsData list;
  GetContactUsDataSuccessState({required this.list});
}

class GetContactUsDataErrorState extends ContactUsStates {
  final String message;
  final int statusCode;

  GetContactUsDataErrorState(
      {required this.message, required this.statusCode}) {
    showMessage(message, messageType: MessageType.error);
  }
}

class PostContactUsDataLoadingState extends ContactUsStates {}

class PostContactUsDataSuccessState extends ContactUsStates {
  final String message;

  PostContactUsDataSuccessState({required this.message}) {
    showMessage(message);
  }
}

class PostContactUsDataErrorState extends ContactUsStates {
  final String message;
  final int statusCode;

  PostContactUsDataErrorState(
      {required this.message, required this.statusCode}) {
    showMessage(message, messageType: MessageType.error);
  }
}
