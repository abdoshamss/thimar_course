part of'bloc.dart';

class ProductRatesStates {}

class ProductRatesLoadingState extends ProductRatesStates {}

class ProductRatesSuccessState extends ProductRatesStates {
  final List<Data> list;

  ProductRatesSuccessState({required this.list});
}

class ProductRatesErrorState extends ProductRatesStates {}
class AddProductRatesLoadingState extends ProductRatesStates {}
class AddProductRatesSuccessState extends ProductRatesStates {
  final String message;

  AddProductRatesSuccessState({required this.message}){
    showMessage(message);
  }


}
class AddProductRatesErrorState extends ProductRatesStates {
  final String message;
  final int statusCode;

  AddProductRatesErrorState({required this.message, required this.statusCode}){
    showMessage(message,messageType: MessageType.error);
  }
}
