part of'bloc.dart';
class GiveAdviceStates {}

class GiveAdviceLoadingState extends GiveAdviceStates{}
class GiveAdviceSuccessState extends GiveAdviceStates{
 final  String  message;

  GiveAdviceSuccessState({required this.message}){
    showMessage(message);
  }
}
class GiveAdviceErrorState extends GiveAdviceStates{
  final String message;
  final int statusCode;

  GiveAdviceErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error,);
  }
}