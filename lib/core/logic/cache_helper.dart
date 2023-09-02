import 'package:shared_preferences/shared_preferences.dart';
import 'package:thimar_course/screens/login/model/model.dart';

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

  static String getToken() {
    return _prefs.getString("token") ?? "";
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
}
