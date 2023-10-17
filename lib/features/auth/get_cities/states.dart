part of 'bloc.dart';
class CitiesScreenStates {}

class GetCitiesScreenLoadingState extends CitiesScreenStates {}

class GetCitiesScreenSuccessState extends CitiesScreenStates {
  List<CityModel> list;

  GetCitiesScreenSuccessState({required this.list});
}

class GetCitiesScreenErrorState extends CitiesScreenStates {}