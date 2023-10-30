part of 'bloc.dart';

class ProductDetailsStates {}

class ProductDetailsLoadingState extends ProductDetailsStates {}

class ProductDetailsSuccessState extends ProductDetailsStates {
  ProductData list;

  ProductDetailsSuccessState({required this.list});
}

class ProductDetailsErrorState extends ProductDetailsStates {}

class ProductCountUpdateLoadingState extends ProductDetailsStates {}

class ProductCountUpdateSuccessState extends ProductDetailsStates {}

class ProductCountUpdateErrorState extends ProductDetailsStates {}
