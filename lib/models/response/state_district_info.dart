// To parse this JSON data, do
//
//     final stateDistrictInfo = stateDistrictInfoFromJson(jsonString);

import 'dart:convert';

List<StateDistrictInfo> stateDistrictInfoFromJson(String str) => List<StateDistrictInfo>.from(json.decode(str).map((x) => StateDistrictInfo.fromJson(x)));

String stateDistrictInfoToJson(List<StateDistrictInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateDistrictInfo {
  StateDistrictInfo({
    this.message,
    this.status,
    this.postOffice,
  });

  final String? message;
  final String? status;
  final List<PostOffice>? postOffice;

  factory StateDistrictInfo.fromJson(Map<String, dynamic> json) => StateDistrictInfo(
    message: json["Message"],
    status: json["Status"],
    postOffice: json["PostOffice"] == null ? [] : List<PostOffice>.from(json["PostOffice"]!.map((x) => PostOffice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Status": status,
    "PostOffice": postOffice == null ? [] : List<dynamic>.from(postOffice!.map((x) => x.toJson())),
  };
}

class PostOffice {
  PostOffice({
    this.name,
    this.description,
    this.branchType,
    this.deliveryStatus,
    this.circle,
    this.district,
    this.division,
    this.region,
    this.block,
    this.state,
    this.country,
    this.pincode,
  });

  final String? name;
  final dynamic description;
  final String? branchType;
  final String? deliveryStatus;
  final String? circle;
  final String? district;
  final String? division;
  final String? region;
  final String? block;
  final String? state;
  final String? country;
  final String? pincode;

  factory PostOffice.fromJson(Map<String, dynamic> json) => PostOffice(
    name: json["Name"],
    description: json["Description"],
    branchType: json["BranchType"],
    deliveryStatus: json["DeliveryStatus"],
    circle: json["Circle"],
    district: json["District"],
    division: json["Division"],
    region: json["Region"],
    block: json["Block"],
    state: json["State"],
    country: json["Country"],
    pincode: json["Pincode"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Description": description,
    "BranchType": branchType,
    "DeliveryStatus": deliveryStatus,
    "Circle": circle,
    "District": district,
    "Division": division,
    "Region": region,
    "Block": block,
    "State": state,
    "Country": country,
    "Pincode": pincode,
  };
}
