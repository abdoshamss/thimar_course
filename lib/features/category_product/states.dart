part of'bloc.dart';

class CategoryProductStates {}

class CategoryProductLoadingState extends CategoryProductStates {}

class CategoryProductSuccessState extends CategoryProductStates {
    List<ProductItemModel> list;

  CategoryProductSuccessState({required this.list});
}

class CategoryProductErrorState extends CategoryProductStates {}