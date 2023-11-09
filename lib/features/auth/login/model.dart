part of 'bloc.dart';

class UserData {
  late final UserModel list;


  UserData.fromJson(Map<String, dynamic> json) {
    list = UserModel.fromJson(json['data']??[]);

  }
}

class UserModel {
  late final int id;
  late final String fullname;
  late final String phone;
  late final String email;
  late final String image;
  late final bool isBan;
  late final bool isActive;
  late final int unreadNotifications;
  late final String userType;
  late final String token;
  late final Country country;
  late final City city;
  late final int userCartCount;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    fullname = json['fullname']??"";
    phone = json['phone']??"";
    email = json['email']??"";
    image = json['image']??"";
    isBan = json['is_ban']==1;
    isActive = json['is_active']??false;
    unreadNotifications = json['unread_notifications']??0;
    userType = json['user_type']??"";
    token = json['token']??"";
    country = Country.fromJson(json['country']);
    city = City.fromJson(json['city']);
    userCartCount = json['user_cart_count']??0;
  }
}

class Country {
  late final String id;
  late final String name;
  late final String nationality;
  late final String key;
  late final String flag;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    name = json['name']??"";
    nationality = json['nationality']??"";
    key = json['key']??"";
    flag = json['flag']??"";
  }
}

class City {
  late final String id;
  late final String name;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"";
  }
}
