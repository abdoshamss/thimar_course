part of 'bloc.dart';
class CategoriesStates {}
class CategoriesLoadingState extends CategoriesStates {}
class CategoriesSuccessState extends CategoriesStates {
 CategoriesData list;

  CategoriesSuccessState({required this.list});
}
class CategoriesErrorState extends CategoriesStates {}