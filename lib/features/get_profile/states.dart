part of 'bloc.dart';

class GetProfileDataStates {}

class GetProfileDataLoadingState extends GetProfileDataStates {}

class GetProfileDataSuccessState extends GetProfileDataStates {
  ProfileData list;
  GetProfileDataSuccessState({required this .list}){
    CacheHelper.setImage(list.data.image);

  }

}

class GetProfileDataErrorState extends GetProfileDataStates {

}
