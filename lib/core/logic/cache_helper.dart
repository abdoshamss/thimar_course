import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/login/bloc.dart';

class CacheHelper {
  static late SharedPreferences _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void saveCount(int count) {
    _prefs.setInt("count", count);
  }

  static int getCount() {
    return _prefs.getInt("count") ?? 1;
  }

  static String getFullName() {
    return _prefs.getString("fullname") ?? "";
  }

  static String? getToken() {
    return _prefs.getString("token") ?? '';
  }

  static String getCity() {
    return _prefs.getString("cityName") ?? "";
  }

  static String getPhone() {
    return _prefs.getString("phone") ?? "";
  }

  static int getCityId() {
    return int.parse(_prefs.getString("cityId") ?? "0");
  }

  static String getImage() {
    return _prefs.getString("image") ??
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80";
  }

  static Future setImage(UserData user) async {
    await _prefs.setString("image", user.data.image ?? "");
  }

  // static setFCMToken(String token) async {
  //   await _prefs.setString("fcm_token", token);
  // }
  //
  // static String getFCMToken() {
  //   return _prefs.getString("fcm_token") ?? "";
  // }

  static String getCityName() {
    return _prefs.getString("cityName") ?? "";
  }

  static Future saveLoginData(UserData user) async {
    await _prefs.setString("image", user.data.image);
    await _prefs.setInt("id", user.data.id);
    await _prefs.setString("phone", user.data.phone);
    await _prefs.setString("email", user.data.email);
    await _prefs.setString("fullname", user.data.fullname);
    await _prefs.setString("token", user.data.token);
    await _prefs.setString("cityId", user.data.city.id);
    await _prefs.setString("cityName", user.data.city.name);
    await _prefs.setBool("isActive", user.data.isActive);
    await _prefs.setInt("userCartCount", user.data.userCartCount);
    await _prefs.setInt("unreadNotifications", user.data.unreadNotifications);
  }

  static Future clearLoginData() async {
    await _prefs.clear();
  }

  static Future removeLoginData() async {
    await _prefs.remove("image");
    await _prefs.remove("id");
    await _prefs.remove("phone");
    await _prefs.remove("email");
    await _prefs.remove("fullname");
    await _prefs.remove("token");
    await _prefs.remove("cityId");
    await _prefs.remove("cityName");
    await _prefs.remove("isActive");
    await _prefs.remove("userCartCount");
    await _prefs.remove("unreadNotifications");
  }
}

// import 'package:shared_preferences/shared_preferences.dart';
//
// class CacheHelper {
//   static late SharedPreferences _preferences;
//
//   static init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }
//
//   static setFCMToken(String token) async {
//     await _preferences.setString("fcm_token", token);
//   }
//   static String getFCMToken() {
//     return _preferences.getString("fcm_token") ?? "";
//   }
//
//   static setUserToken(String token) async {
//     await _preferences.setString("token", token);
//   }
//
//   static String getUserToken() {
//     return _preferences.getString("token") ?? "";
//   }
//
//   static setUserId(int id) async {
//     await _preferences.setInt("user_id", id);
//   }
//
//   static int getUserId() {
//     return _preferences.getInt("user_id") ?? 0;
//   }
//
//   static setFullName(String fullName) async {
//     await _preferences.setString("fullname", fullName);
//   }
//
//   static String getFullName() {
//     return _preferences.getString("fullname") ?? "";
//   }
//
//   static setPhone(String phone) async {
//     await _preferences.setString("phone", phone);
//   }
//
//   static String getPhone() {
//     return _preferences.getString("phone") ?? "";
//   }
//
//   static setEmail(String email) async {
//     await _preferences.setString("email", email);
//   }
//
//   static String getEmail() {
//     return _preferences.getString("email") ?? "";
//   }
//
//   static setImage(String image) async {
//     await _preferences.setString("image", image);
//   }
//
//   static String getImage() {
//     return _preferences.getString("image") ?? "";
//   }
//
//   static setIsBan(int isBan) async {
//     await _preferences.setInt("isBan", isBan);
//   }
//
//   static int getIsBan() {
//     return _preferences.getInt("isBan") ?? 0;
//   }
//
//   static setIsActive(bool value) async {
//     await _preferences.setBool("isActive", value);
//   }
//
//   static bool getIIsActive() {
//     return _preferences.getBool("isActive") ?? false;
//   }
//
//   static setUnreadNotifications(int unreadNotifications) async {
//     await _preferences.setInt("unreadNotifications", unreadNotifications);
//   }
//
//   static int getUnreadNotifications() {
//     return _preferences.getInt("unreadNotifications") ?? 0;
//   }
//
//   static String getCountryIdcountryId() {
//     return _preferences.getString("country_idcountry_id") ?? "";
//   }
//
//   static setCountryIdcountryId(String countryIdcountryId) async {
//     await _preferences.setString("country_idcountry_id", countryIdcountryId);
//   }
//
//   static String getUserType() {
//     return _preferences.getString("userType") ?? "";
//   }
//
//   static setUserType(String userType) async {
//     await _preferences.setString("userType", userType);
//   }
//
//   static setCountryId(String countryId) async {
//     await _preferences.setString("country_id", countryId);
//   }
//
//   static String getCountryId() {
//     return _preferences.getString("country_id") ?? "";
//   }
//
//   static setlLang(String token) async {
//     await _preferences.setString("lang", token);
//   }
//
//   static String getCountryName() {
//     return _preferences.getString("country_name") ?? "";
//   }
//
//   static setCountryNationality(String nationality) async {
//     await _preferences.setString("nationality", nationality);
//   }
//
//   static String getCountryNationality() {
//     return _preferences.getString("nationality") ?? "";
//   }
//
//   static setCountryKey(String countryKey) async {
//     await _preferences.setString("country_key", countryKey);
//   }
//
//   static String getCountryKey() {
//     return _preferences.getString("country_key") ?? "";
//   }
//
//   static setCountryFlag(String countryFlag) async {
//     await _preferences.setString("country_flag", countryFlag);
//   }
//
//   static String getCountryFlag() {
//     return _preferences.getString("country_flag") ?? "";
//   }
//
//   static setCityName(String cityName) async {
//     await _preferences.setString("city_name", cityName);
//   }
//
//   static String getCityName() {
//     return _preferences.getString("city_name") ?? "";
//   }
//
//   static setCityId(String cityId) async {
//     await _preferences.setString("city_id", cityId);
//   }
//
//   static String getCityId() {
//     return _preferences.getString("city_id") ?? "";
//   }
//
//   static setUserCartCount(int userCartCount) async {
//     await _preferences.setInt("userCartCount", userCartCount);
//   }
//
//   static int getUserCartCount() {
//     return _preferences.getInt("userCartCount") ?? 0;
//   }
//
//   static String getLang() {
//     return _preferences.getString("lang") ?? "";
//   }
//
//   static Future setIfIsVisitor(bool isVisitor) async {
//     await _preferences.setBool("isVisitor", isVisitor);
//   }
//
//   static bool getIfIsVisitor() {
//     return _preferences.getBool("isVisitor") ?? true;
//   }
// }
