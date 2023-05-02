// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

class AddLineUp {
  AddLineUp( {
    this.ln_id,
    this.ln_desg,
    this.ln_cmpny,
    this.ln_intrvw_sts,
    this.ln_intervw_dt,
    this.ln_fdbk,
    this.ln_doc_sts,
    this.ln_offer_sts,
    this.ln_expctd_doj,
    this.ln_joining_dt,
    this.ln_joining_sts,
    this.ln_package,
    this.ln_emp_code,
    this.ln_cooling_prd,
    this.ln_regional_hr,
    this.ln_zonal_hr,
    this.ln_branch_loc,
    this.ln_hr_remark,
    this.ln_tl_remark,
    this.ln_mngr_remark,
    this.ln_zm_remark,
    this.ln_adm_remark,
    this.rfId,
  });

  final String? rfId;
  final String? ln_desg;
  final int? ln_id;
  final String? ln_cmpny;
  final String? ln_intrvw_sts;
  final String? ln_intervw_dt;
  final String? ln_fdbk;
  final String? ln_doc_sts;
  final String? ln_offer_sts;
  final String? ln_expctd_doj;
  final String? ln_joining_dt;
  final String? ln_joining_sts;
  final String? ln_package;
  final String? ln_emp_code;
  final String? ln_cooling_prd;
  final String? ln_regional_hr;
  final String? ln_zonal_hr;
  final String? ln_branch_loc;
  final String? ln_hr_remark;
  final String? ln_tl_remark;
  final String? ln_mngr_remark;
  final String? ln_zm_remark;
  final String? ln_adm_remark;

  factory AddLineUp.fromJson(Map<String, dynamic> json) => AddLineUp(
    rfId: json["rf_id"],
    ln_id: json["ln_id"],
    ln_desg:json["ln_desg"],
    ln_cmpny:json["ln_cmpny"],
    ln_intrvw_sts:json["ln_intrvw_sts"],
    ln_intervw_dt:json["ln_intervw_dt"],
    ln_fdbk:json["ln_fdbk"],
    ln_doc_sts:json["ln_doc_sts"],
    ln_offer_sts:json["ln_offer_sts"],
    ln_expctd_doj:json["ln_expctd_doj"],
    ln_joining_dt:json["ln_joining_dt"],
    ln_joining_sts:json["ln_joining_sts"],
    ln_package:json["ln_package"],
    ln_emp_code:json["ln_emp_code"],
    ln_cooling_prd:json["ln_cooling_prd"],
    ln_regional_hr:json["ln_regional_hr"],
    ln_zonal_hr:json["ln_zonal_hr"],
    ln_branch_loc:json["ln_branch_loc"],
    ln_hr_remark:json["ln_hr_remark"],
    ln_tl_remark:json["ln_tl_remark"],
    ln_mngr_remark:json["ln_mngr_remark"],
    ln_zm_remark:json["ln_zm_remark"],
    ln_adm_remark:json["ln_adm_remark"],

  );

  // Map<String, dynamic> toJson() => {
  //       "rf_id": rfId,
  //       "rf_mmbr_id": rfMmbrId,
  //       "rf_usr_id": rfUsrId,
  //       "rf_cand_name": rfCandName,
  //       "rf_mob": rfMob,
  //       "rf_resume": rfResume,
  //       "rf_category": rfCategory,
  //       "rf_education": rfEducation,
  //       "rf_location": rfLocation,
  //       "rf_email": rfEmail,
  //       "rf_industry": rfIndustry,
  //       "rf_dob": rfDob,
  //       "rf_pincode": rfPincode,
  //       "rf_wrking_sts": rfWrkingSts,
  //       "rf_crnt_ctc": rfCrntCtc,
  //       "rf_cmpny_name": rfCmpnyName,
  //       "rf_crnt_desg": rfCrntDesg,
  //       "rf_notice": rfNotice,
  //       "rf_expected_ctc": rfExpectedCtc,
  //       "rf_ttl_exp": rfTtlExp,
  //       "rf_city": rfCity,
  //       "rf_dist": rfDist,
  //       "rf_state": rfState,
  //       "rf_sts": rfSts,
  //       "hr_tenure_crnt_cmpny": hrTenureCrntCmpny,
  //       "hr_sales_exp": hrSalesExp,
  //       "hr_usr_sts": hrUsrSts,
  //       "hr_usr_pan": hrUsrPan,
  //       "hr_usr_channel": hrUsrChannel,
  //       "rf_alternate_mob": rfAlternateMob,
  //       "rf_locality": rfLocality,
  //       "rf_preferred_loc": rfPreferredLoc,
  //       "rf_feedback": rfFeedback,
  //       "rf_remark": rfRemark,
  //       "rf_cooling": rfCooling,
  //       "rf_br_location": rfBrLocation,
  //       "rf_zone": rfZone,
  //       "hr_internal_sts": hrInternalSts,
  //     };
}
