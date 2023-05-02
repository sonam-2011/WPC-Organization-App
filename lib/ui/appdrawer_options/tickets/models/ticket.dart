// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

List<Ticket> ticketFromJson(String str) => List<Ticket>.from(json.decode(str).map((x) => Ticket.fromJson(x)));

String ticketToJson(List<Ticket> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ticket {
  Ticket({
    this.rfId,
    this.rfMmbrId,
    this.rfUsrId,
    this.rfCandName,
    this.rfMob,
    this.rfResume,
    this.rfCategory,
    this.rfEducation,
    this.rfLocation,
    this.rfEmail,
    this.rfIndustry,
    this.rfDob,
    this.rfPincode,
    this.rfWrkingSts,
    this.rfCrntCtc,
    this.rfCmpnyName,
    this.rfCrntDesg,
    this.rfNotice,
    this.rfExpectedCtc,
    this.rfTtlExp,
    this.rfCity,
    this.rfDist,
    this.rfState,

    this.rfSts,
    this.hrTenureCrntCmpny,
    this.hrSalesExp,
    this.hrUsrSts,
    this.hrUsrPan,
    this.hrUsrChannel,
    this.rfAlternateMob,
    this.rfLocality,
    this.rfPreferredLoc,
    this.rfFeedback,
    this.rfRemark,
    this.rfCooling,
    this.rfBrLocation,
    this.rfZone,
    this.hrInternalSts,
  });

  final int? rfId;
  final String? rfMmbrId;
  final String? rfUsrId;
  final String? rfCandName;
  final String? rfMob;
  final String? rfResume;
  final String? rfCategory;
  final String? rfEducation;
  final String? rfLocation;
  final String? rfEmail;
  final String? rfIndustry;
  final String? rfDob;
  final String? rfPincode;
  final String? rfWrkingSts;
  final String? rfCrntCtc;
  final String? rfCmpnyName;
  final String? rfCrntDesg;
  final String? rfNotice;
  final String? rfExpectedCtc;
  final String? rfTtlExp;
  final String? rfCity;
  final String? rfDist;
  final String? rfState;

  final String? rfSts;
  final String? hrTenureCrntCmpny;
  final String? hrSalesExp;
  final String? hrUsrSts;
  final String? hrUsrPan;
  final String? hrUsrChannel;
  final String? rfAlternateMob;
  final String? rfLocality;
  final String? rfPreferredLoc;
  final String? rfFeedback;
  final String? rfRemark;
  final String? rfCooling;
  final String? rfBrLocation;
  final String? rfZone;
  final String? hrInternalSts;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    rfId: json["rf_id"],
    rfMmbrId: json["rf_mmbr_id"],
    rfUsrId: json["rf_usr_id"],
    rfCandName: json["rf_cand_name"],
    rfMob: json["rf_mob"],
    rfResume: json["rf_resume"],
    rfCategory: json["rf_category"],
    rfEducation: json["rf_education"],
    rfLocation: json["rf_location"],
    rfEmail: json["rf_email"],
    rfIndustry: json["rf_industry"],
    rfDob: json["rf_dob"],
    rfPincode: json["rf_pincode"],
    rfWrkingSts: json["rf_wrking_sts"],
    rfCrntCtc: json["rf_crnt_ctc"],
    rfCmpnyName: json["rf_cmpny_name"],
    rfCrntDesg: json["rf_crnt_desg"],
    rfNotice: json["rf_notice"],
    rfExpectedCtc: json["rf_expected_ctc"],
    rfTtlExp: json["rf_ttl_exp"],
    rfCity: json["rf_city"],
    rfDist: json["rf_dist"],
    rfState: json["rf_state"],

    rfSts: json["rf_sts"],
    hrTenureCrntCmpny: json["hr_tenure_crnt_cmpny"],
    hrSalesExp: json["hr_sales_exp"],
    hrUsrSts: json["hr_usr_sts"],
    hrUsrPan: json["hr_usr_pan"],
    hrUsrChannel: json["hr_usr_channel"],
    rfAlternateMob: json["rf_alternate_mob"],
    rfLocality: json["rf_locality"],
    rfPreferredLoc: json["rf_preferred_loc"],
    rfFeedback: json["rf_feedback"],
    rfRemark: json["rf_remark"],
    rfCooling: json["rf_cooling"],
    rfBrLocation: json["rf_br_location"],
    rfZone: json["rf_zone"],
    hrInternalSts: json["hr_internal_sts"],
  );

  Map<String, dynamic> toJson() => {
    "rf_id": rfId,
    "rf_mmbr_id": rfMmbrId,
    "rf_usr_id": rfUsrId,
    "rf_cand_name": rfCandName,
    "rf_mob": rfMob,
    "rf_resume": rfResume,
    "rf_category": rfCategory,
    "rf_education": rfEducation,
    "rf_location": rfLocation,
    "rf_email": rfEmail,
    "rf_industry": rfIndustry,
    "rf_dob": rfDob,
    "rf_pincode": rfPincode,
    "rf_wrking_sts": rfWrkingSts,
    "rf_crnt_ctc": rfCrntCtc,
    "rf_cmpny_name": rfCmpnyName,
    "rf_crnt_desg": rfCrntDesg,
    "rf_notice": rfNotice,
    "rf_expected_ctc": rfExpectedCtc,
    "rf_ttl_exp": rfTtlExp,
    "rf_city": rfCity,
    "rf_dist": rfDist,
    "rf_state": rfState,

    "rf_sts": rfSts,
    "hr_tenure_crnt_cmpny": hrTenureCrntCmpny,
    "hr_sales_exp": hrSalesExp,
    "hr_usr_sts": hrUsrSts,
    "hr_usr_pan": hrUsrPan,
    "hr_usr_channel": hrUsrChannel,
    "rf_alternate_mob": rfAlternateMob,
    "rf_locality": rfLocality,
    "rf_preferred_loc": rfPreferredLoc,
    "rf_feedback": rfFeedback,
    "rf_remark": rfRemark,
    "rf_cooling": rfCooling,
    "rf_br_location": rfBrLocation,
    "rf_zone": rfZone,
    "hr_internal_sts": hrInternalSts,
  };
}
