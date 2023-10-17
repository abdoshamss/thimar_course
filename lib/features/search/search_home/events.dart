part of'bloc.dart';

class SearchHomeEvents {}

class GetSearchHomeDataEvent extends SearchHomeEvents {
  final String value;

  GetSearchHomeDataEvent({required this.value});

}