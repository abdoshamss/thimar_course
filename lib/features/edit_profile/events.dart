part of'bloc.dart';

class EditProfileEvents {}

class PostEditProfileDataEvent extends EditProfileEvents {
final  File image;
   final   String name, phone;
    final  int cityId;

  PostEditProfileDataEvent({required this.image, required this.name, required this.phone, required this.cityId});
}