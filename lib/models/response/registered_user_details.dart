// To parse this JSON data, do
//
//     final registeredUserDetails = registeredUserDetailsFromJson(jsonString);

import 'dart:convert';

RegisteredUserDetails registeredUserDetailsFromJson(String str) => RegisteredUserDetails.fromJson(json.decode(str));

String registeredUserDetailsToJson(RegisteredUserDetails data) => json.encode(data.toJson());

class RegisteredUserDetails {
  RegisteredUserDetails({
    this.error,
    this.id,
    this.mobile,
    this.username,
    this.sts,
    this.role,
    this.reporterId,
    this.reporterName,
    this.reporterMob,
    this.zone,
    this.empId,
    this.location,
  });

  final bool? error;
  final int? id;
  final String? mobile;
  final String? username;
  final String? sts;
  final String? role;
  final String? reporterId;
  final dynamic reporterName;
  final dynamic reporterMob;
  final String? zone;
  final String? empId;
  final String? location;

  factory RegisteredUserDetails.fromJson(Map<String, dynamic> json) => RegisteredUserDetails(
    error: json["error"],
    id: json["id"],
    mobile: json["mobile"],
    username: json["username"],
    sts: json["sts"],
    role: json["role"],
    reporterId: json["reporter_id"],
    reporterName: json["reporter_name"],
    reporterMob: json["reporter_mob"],
    zone: json["zone"],
    empId: json["emp_id"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "id": id,
    "mobile": mobile,
    "username": username,
    "sts": sts,
    "role": role,
    "reporter_id": reporterId,
    "reporter_name": reporterName,
    "reporter_mob": reporterMob,
    "zone": zone,
    "emp_id": empId,
    "location": location,
  };
}
