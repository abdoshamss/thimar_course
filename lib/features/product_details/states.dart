part of'bloc.dart';

class ProductDetailsStates {}
class ProductDetailsLoadingState extends ProductDetailsStates {}
class ProductDetailsSuccessState extends ProductDetailsStates {
   ProductData list;

  ProductDetailsSuccessState({required this.list});

}
class ProductDetailsErrorState extends ProductDetailsStates {}
class ProductCountUpdateState extends ProductDetailsStates {}

