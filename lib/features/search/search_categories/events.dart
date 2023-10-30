part of 'bloc.dart';

class SearchCategoriesEvents {}

class GetSearchCategoriesDataEvent extends SearchCategoriesEvents {
  final int id;
  final String? value;
  final String filter;

  final double minPrice, maxPrice;
  GetSearchCategoriesDataEvent(
      {required this.id,
      required this.minPrice, required this.filter,
      required this.maxPrice,
      required this.value});
}
