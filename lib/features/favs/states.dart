part of'bloc.dart';

class FAVSStates {}
class FAVSLoadingState extends FAVSStates {}
class FAVSSuccessState extends FAVSStates {
  final String message;
  // final FAVSData list;

  FAVSSuccessState({
   required this.message,
   // required this.list,
  }){
    showMessage(message);
  }

}
class FAVSErrorState extends FAVSStates {
  final String message;
  final int statusCode;

  FAVSErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error,);
  }
}

class AddToFAVSState extends FAVSStates {
  final String message;

  AddToFAVSState({required this.message}){
    showMessage(message);
  }

}
class RemoveFromFAVSState extends FAVSStates {
  final String message;
  final int statusCode;

  RemoveFromFAVSState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error);
  }
}
