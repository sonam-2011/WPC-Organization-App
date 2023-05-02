// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

List<Payment> paymentFromJson(String str) => List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
  Payment({
    this.rfId,
    this.internalSts,
    this.rfRemark,
    this.usrMob,
    this.usrUpi,
    this.usrId,
  });

  final int? rfId;
  final String? internalSts;
  final String? rfRemark;
  final String? usrMob;
  final String? usrUpi;
  final int? usrId;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    rfId: json["rf_id"],
    internalSts: json["internal_sts"],
    rfRemark: json["rf_remark"],
    usrMob: json["usr_mob"],
    usrUpi: json["usr_upi"],
    usrId: json["usr_id"],
  );

  Map<String, dynamic> toJson() => {
    "rf_id": rfId,
    "internal_sts": internalSts,
    "rf_remark": rfRemark,
    "usr_mob": usrMob,
    "usr_upi": usrUpi,
    "usr_id": usrId,
  };
}
