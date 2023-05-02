// To parse this JSON data, do
//
//     final detailedPayment = detailedPaymentFromJson(jsonString);

import 'dart:convert';

List<DetailedPayment> detailedPaymentFromJson(String str) => List<DetailedPayment>.from(json.decode(str).map((x) => DetailedPayment.fromJson(x)));

String detailedPaymentToJson(List<DetailedPayment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailedPayment {
  DetailedPayment({
    this.payId,
    this.usrId,
    this.upiId,
    this.managerId,
    this.trnsctnId,
    this.amt,
    this.remark,
    this.rfId,
    this.dt,
    this.usrMob,
  });

  final int? payId;
  final String? usrId;
  final int? upiId;
  final String? managerId;
  final String? trnsctnId;
  final String? amt;
  final String? remark;
  final String? rfId;
  final DateTime? dt;
  final String? usrMob;

  factory DetailedPayment.fromJson(Map<String, dynamic> json) => DetailedPayment(
    payId: json["pay_id"],
    usrId: json["usr_id"],
    upiId: json["upi_id"],
    managerId: json["manager_id"],
    trnsctnId: json["trnsctn_id"],
    amt: json["amt"],
    remark: json["remark"],
    rfId: json["rf_id"],
    dt: json["dt"] == null ? null : DateTime.parse(json["dt"]),
    usrMob: json["usr_mob"],
  );

  Map<String, dynamic> toJson() => {
    "pay_id": payId,
    "usr_id": usrId,
    "upi_id": upiId,
    "manager_id": managerId,
    "trnsctn_id": trnsctnId,
    "amt": amt,
    "remark": remark,
    "rf_id": rfId,
    "dt": dt?.toIso8601String(),
    "usr_mob": usrMob,
  };
}
