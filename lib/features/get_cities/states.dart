import 'model.dart';

class GetCitiesScreenStates {}

class GetCitiesScreenLoadingState extends GetCitiesScreenStates {}

class GetCitiesScreenSuccessState extends GetCitiesScreenStates {
  List<CityModel> list;

  GetCitiesScreenSuccessState({required this.list});
}

class GetCitiesScreenErrorState extends GetCitiesScreenStates {}