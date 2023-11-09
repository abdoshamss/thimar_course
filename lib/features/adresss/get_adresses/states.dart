part of 'bloc.dart';

class GetAddressesStates {}

class GetAddressesLoadingState extends GetAddressesStates {}

class GetAddressesSuccessState extends GetAddressesStates {
  final List<AddressModel> list;

  GetAddressesSuccessState({required this.list});
}

class GetAddressesErrorState extends GetAddressesStates {}

class EditAddressesLoadingState extends GetAddressesStates {}

class EditAddressesSuccessState extends GetAddressesStates {
  final String message;
  EditAddressesSuccessState({required this.message, }){
    showMessage( message);
  }
}

class EditAddressesErrorState extends GetAddressesStates {
  final String message;
  final int statusCode;

  EditAddressesErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error);
  }
}

class RemoveAddressesLoadingState extends GetAddressesStates {}

class RemoveAddressesSuccessState extends GetAddressesStates {
  final String message;


  RemoveAddressesSuccessState({required this.message,  }){
    showMessage( message);
  }
}

class RemoveAddressesErrorState extends GetAddressesStates {
  final String message;
  final int statusCode;

  RemoveAddressesErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error);
  }
}

class AddAddressesLoadingState extends GetAddressesStates {}

class AddAddressesSuccessState extends GetAddressesStates { final String message;


AddAddressesSuccessState({required this.message,  }){
  showMessage( message);
}}

class AddAddressesErrorState extends GetAddressesStates {
  final String message;final int statusCode;

  AddAddressesErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error);
  }

}
