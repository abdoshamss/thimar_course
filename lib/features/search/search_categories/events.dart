part of'bloc.dart';

class SearchCategoriesEvents {}

class GetSearchCategoriesDataEvent extends SearchCategoriesEvents {
  final int id;
final String value;
  GetSearchCategoriesDataEvent( {required this.id,required this.value});

}