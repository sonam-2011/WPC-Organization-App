import 'package:shared_preferences/shared_preferences.dart';

import 'models/response/registered_user_details.dart';

class SharedPreferencesData {
  static Future<void> saveLoginResponse(
      RegisteredUserDetails loginResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", loginResponse.id ?? -1);
    prefs.setString("mobile", loginResponse.mobile ?? "empty string");
    prefs.setString("username", loginResponse.username ?? "empty string");
    prefs.setString("sts", loginResponse.sts ?? "empty string");
    prefs.setString("role", loginResponse.role ?? "empty string");
  }

  static Future<Map<String, String?>> fetchSharedPrefData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    RegisteredUserDetails? userDetails;
    // userDetails?.id= prefs.getInt("id") ?? "";
    //
    int? id = prefs.getInt("id");

    String? usrname = prefs.getString("username");
    String? mobile = prefs.getString("mobile");
    String? sts = prefs.getString("sts");
    String? role = prefs.getString("role");

    Map<String, String?> sharedPrefsData = {
      "id": id.toString(),
      "usrname": usrname,
      "mobile": mobile,
      "sts": sts,
      "role": role,
    };
    print("in shared pref");
    print(usrname);

    return sharedPrefsData;
  }

  static Future<RegisteredUserDetails?> readSharedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(usrname);

    RegisteredUserDetails? userDetails = RegisteredUserDetails(
        id: prefs.getInt("id"),
        username: prefs.getString("username"),
        role: prefs.getString("role"),
        mobile: prefs.getString("mobile"));

    return userDetails;
  }

  static Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("before clear");
    await prefs.clear();
    print("After clear");
  }
}
