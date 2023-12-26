part of 'bloc.dart';
class ProfileData {
   
  late final ProfileModel data;
  late final String status, message;


  ProfileData.fromJson(Map<String, dynamic> json){
    data = ProfileModel.fromJson(json['data']??{});
    status = json['status']??"";
    message = json['message']??"";
  }

   
}

class ProfileModel {
   
  late final int id;
  late final String fullname,image,phone;

  late final City city;
  late final int isVip;

  ProfileModel.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    fullname = json['fullname']??"";
    phone = json['phone']??"";
    image = json['image']??"";
    city = City.fromJson(json['city']??{});
    isVip = json['is_vip']??0;
  }


}

class City {

  late final int id;
  late final String name;

  City.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    name = json['name']??"";
  }


}