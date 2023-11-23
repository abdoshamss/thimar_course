part of'bloc.dart';

class GetProductsDataStates {}

class GetProductsDataLoadingState extends GetProductsDataStates {


}

class GetProductsDataSuccessState extends GetProductsDataStates {
  final List<ProductItemModel> list;

  GetProductsDataSuccessState({required this.list});
}

class GetProductsDataErrorState extends GetProductsDataStates {
  final String? text;

  GetProductsDataErrorState({required this.text});
}