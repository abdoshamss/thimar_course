part of 'bloc.dart';

class CartDataStates {}

class CartDataLoadingState extends CartDataStates {}

class CartDataSuccessState extends CartDataStates {
  CartData list;
  CartDataSuccessState({required this.list});
}

class CartDataErrorState extends CartDataStates {}

class DeleteFromCartLoadingState extends CartDataStates {}

class DeleteFromCartSuccessState extends CartDataStates {}

class DeleteFromCartErrorState extends CartDataStates {}

class UpdateFromCartLoadingState extends CartDataStates {}

class UpdateFromCartSuccessState extends CartDataStates {}

class UpdateFromCartErrorState extends CartDataStates {}

class ApplyCouponLoadingState extends CartDataStates {

}

class ApplyCouponSuccessState extends CartDataStates {
  final String message;

  ApplyCouponSuccessState({required this.message}){
    showMessage(message);
  }
}

class ApplyCouponErrorState extends CartDataStates {
  final String message;

  ApplyCouponErrorState({required this.message}){
    showMessage(message,messageType: MessageType.error);
  }
}
