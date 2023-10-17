part of'bloc.dart';

class CategoryProductStates {}

class CategoryProductLoadingState extends CategoryProductStates {}

class CategoryProductSuccessState extends CategoryProductStates {
  final CategoryProductModel list;

  CategoryProductSuccessState({required this.list});
}

class CategoryProductErrorState extends CategoryProductStates {}