part of'bloc.dart';

class CategoryProductStates {}

class CategoryProductLoadingState extends CategoryProductStates {}

class CategoryProductSuccessState extends CategoryProductStates {
  final CategoryProductData list;

  CategoryProductSuccessState({required this.list});
}

class CategoryProductErrorState extends CategoryProductStates {}