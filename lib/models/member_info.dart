// To parse this JSON data, do
//
//     final memberInfo = memberInfoFromJson(jsonString);

import 'dart:convert';

List<MemberInfo> memberInfoFromJson(String str) => List<MemberInfo>.from(json.decode(str).map((x) => MemberInfo.fromJson(x)));

String memberInfoToJson(List<MemberInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberInfo {
  MemberInfo({
    this.mmbrId,
    this.mmbrName,
    this.mmbrMob,
    this.mmbrRole,
    this.mmbrReportToId,
    this.mmbrZone,
    this.mmbrSts,
    this.mmbrAdminSts,
    this.mmbrDt,
    this.mmbrEmpId,
    this.mmbrLocation,
  });

  final int? mmbrId;
  final String? mmbrName;
  final String? mmbrMob;
  final String? mmbrRole;
  final String? mmbrReportToId;
  final String? mmbrZone;
  final String? mmbrSts;
  final String? mmbrAdminSts;
  final DateTime? mmbrDt;
  final String? mmbrEmpId;
  final String? mmbrLocation;

  factory MemberInfo.fromJson(Map<String, dynamic> json) => MemberInfo(
    mmbrId: json["mmbr_id"],
    mmbrName: json["mmbr_name"],
    mmbrMob: json["mmbr_mob"],
    mmbrRole: json["mmbr_role"],
    mmbrReportToId: json["mmbr_report_to_id"],
    mmbrZone: json["mmbr_zone"],
    mmbrSts: json["mmbr_sts"],
    mmbrAdminSts: json["mmbr_admin_sts"],
    mmbrDt: json["mmbr_dt"] == null ? null : DateTime.parse(json["mmbr_dt"]),
    mmbrEmpId: json["mmbr_emp_id"],
    mmbrLocation: json["mmbr_location"],
  );

  Map<String, dynamic> toJson() => {
    "mmbr_id": mmbrId,
    "mmbr_name": mmbrName,
    "mmbr_mob": mmbrMob,
    "mmbr_role": mmbrRole,
    "mmbr_report_to_id": mmbrReportToId,
    "mmbr_zone": mmbrZone,
    "mmbr_sts": mmbrSts,
    "mmbr_admin_sts": mmbrAdminSts,
    "mmbr_dt": mmbrDt?.toIso8601String(),
    "mmbr_emp_id": mmbrEmpId,
    "mmbr_location": mmbrLocation,
  };
}
