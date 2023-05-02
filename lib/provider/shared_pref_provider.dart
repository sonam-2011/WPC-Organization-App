import 'package:flutter/cupertino.dart';
import 'package:freelancer_internal_app/models/response/registered_user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShraredPrefProvider extends ChangeNotifier {
  RegisteredUserDetails? user;

  bool isLogin = false;

  bool get isLoggedIn => isLogin;

  RegisteredUserDetails? get loggedInUser => user;

  Future<void> saveLoginResponse(RegisteredUserDetails loginResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", loginResponse.id ?? -1);
    prefs.setString("mobile", loginResponse.mobile ?? "empty string");
    prefs.setString("username", loginResponse.username ?? "empty string");
    prefs.setString("sts", loginResponse.sts ?? "empty string");
    prefs.setString("role", loginResponse.role ?? "empty string");
    prefs.setString("reporter_id", loginResponse.reporterId ?? "empty string");
    prefs.setString(
        "reporter_name", loginResponse.reporterName ?? "empty string");
    prefs.setString(
        "reporter_mob", loginResponse.reporterMob ?? "empty string");
    prefs.setString("zone", loginResponse.zone ?? "empty string");
    prefs.setString("emp_id", loginResponse.empId ?? "empty string");
    prefs.setString("location", loginResponse.location ?? "empty string");
    user = loginResponse;
    notifyListeners();
  }

  //  Future<Map<String, String?>> fetchSharedPrefData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   RegisteredUserDetails? userDetails;
  //   // userDetails?.id= prefs.getInt("id") ?? "";
  //   //
  //   int? id = prefs.getInt("id");
  //
  //   String? usrname = prefs.getString("username");
  //   String? mobile = prefs.getString("mobile");
  //   String? sts = prefs.getString("sts");
  //   String? role = prefs.getString("role");
  //
  //   Map<String, String?> sharedPrefsData = {
  //     "id": id.toString(),
  //     "usrname": usrname,
  //     "mobile": mobile,
  //     "sts": sts,
  //     "role": role,
  //   };
  //   print("in shared pref");
  //   print(usrname);
  //
  //   return sharedPrefsData;
  // }

  Future<void> readSharedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(usrname);

    RegisteredUserDetails? userDetails = RegisteredUserDetails(
      id: prefs.getInt("id"),
      username: prefs.getString("username"),
      role: prefs.getString("role"),
      mobile: prefs.getString("mobile"),
      reporterId: prefs.getString("reporter_id"),
      reporterName: prefs.getString("reporter_name"),
      reporterMob: prefs.getString("reporter_mob"),
      zone: prefs.getString("zone"),
      empId: prefs.getString("emp_id"),
      location: prefs.getString("location"),
    );
    print("executing read func");
    user = userDetails;
    print(user?.empId);
    notifyListeners();
  }

  Future clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("before clear");
    await prefs.clear();
    user = null;

    print(user?.username);
    notifyListeners();
  }
}
