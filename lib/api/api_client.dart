import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:freelancer_internal_app/api/rest_client.dart';
import 'package:freelancer_internal_app/constants/app_strings.dart';
import 'package:freelancer_internal_app/models/member_info.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/pay_now/model/detailed_payment.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/pay_now/model/payment.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/models/add_lined_up.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/models/assign_ticker_resp.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/models/ticket.dart';
import 'package:freelancer_internal_app/ui/dashboard_screen/model/stats.dart';
import 'package:http/http.dart' as http;

import '../constants/api_end_points.dart';
import '../models/job_category.dart';
import '../models/response/industry_type.dart';
import '../models/response/registered_user_details.dart';
import '../models/response/sign_up_response.dart';
import '../ui/appdrawer_options/member_hierarchy/model/reporting_member.dart';
import '../ui/dashboard_screen/model/welcome_screen_images.dart';

class ApiClient {
  ApiClient._();


  static Future<dynamic> blockApp() {
    final form = FormData.fromMap({
      "desc": "desc1",
      "img": "img1",
      "update": "update1",
      "maintenance": "maintenance1"
    });
    return RestClient().postMethod(url: ApiEndPoints.blockApp, data: form).then(
            (dynamic response) {
          try {
            if (response != null) {
              final data = response as Map;

              return data;
            }
          } catch (e) {
            print("api client error called");
            log(e.toString());
            throw "Some Error";
          }
          return null;
        }, onError: (dynamic error) {
      print(
          "api client on error func signUp executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> checkAccess({
    required String? id,
  }) {
    final form = FormData.fromMap({
      "id": id,
      'role': "PARTNER",
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.checkAccess, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final stsmes = response as Map;

          return stsmes['sts'];
        }
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func signUp executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> signUp({
    required String? username,
    required String? password,
    required String? mobile,
    required String? otp,
    required String? role,
  }) {
    final form = FormData.fromMap({
      "username": username,
      'password': password,
      'mobile': mobile,
      'otp': otp,
      'role': role,
    });
    return RestClient().post(url: ApiEndPoints.signUp, data: form).then(
        (dynamic response) {
      try {
        if (response != null) print(response['error']);
        print(response['message']);
        return SignUpResponse.fromJson(response);
      } catch (e) {
        print("api client error called");
        log(e.toString());
        rethrow;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func signUp executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<List<IndustryType>?> industries({
    required String? key,
  }) {
    final form = FormData.fromMap({
      'key': key,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.industryType, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final industriesTypeListJson = response as List;
          final industries = industriesTypeListJson.map((e) {
            return IndustryType.fromJson(e);
          }).toList();
          // print("no of job categories ");
          // print(industries.length);
          return industries;
        }
      } catch (e) {
        print("Could not call Api");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> paidUnpaidList({
    required String? payment_sts,
  }) {
    final form = FormData.fromMap({
      'payment_sts': payment_sts,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.paid_unpaid_list, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final respnse2 = response as List;
          final payments = respnse2.map((e) {
            return Payment.fromJson(e);
          }).toList();
          // print("no of job categories ");
          // print(industries.length);
          return payments;
        }
      } catch (e) {
        print("Could not call Api");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> usrPaymentDetail({
    required String? rf_id,
  }) {
    final form = FormData.fromMap({
      'rf_id': rf_id,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.usrPaymentDetail, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final respnse2 = response as List;
          final payments = respnse2.map((e) {
            return DetailedPayment.fromJson(e);
          }).toList();
          // print("no of job categories ");
          // print(industries.length);
          return payments;
        }
      } catch (e) {
        print("Could not call Api");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> dataStats({
    required String? key,
  }) {
    final form = FormData.fromMap({
      'key': key,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.data_stat, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final respnse2 = response as List;
          final stats = respnse2.map((e) {
            return Stats.fromJson(e);
          }).toList();
          // print("no of job categories ");
          // print(industries.length);
          return stats;
        }
      } catch (e) {
        print("Could not call Api");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }


  static Future<dynamic> payUsr({

    required String? usr_id,
    required String? upi_id,
    required String? manager_id,
    required String? trns_id,
    required String? amount,
    required String? remark,
    required String? rf_id,
  }) {
    final form = FormData.fromMap({
      'usr_id': usr_id,
      'upi_id': upi_id,
      'manager_id': manager_id,
      'trns_id': trns_id,
      'amount': amount,
      'remark': remark,
      'rf_id': rf_id,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.payUsr, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          print(response);
          final respnse2 = response as Map;
          final mess = respnse2['message'];
          // print("no of job categories ");
          // print(industries.length);
          if(mess=="Submitted"){
            return mess;

          }else{
            throw "Could Not Submit Data";
          }

        }
      } catch (e) {
        print("Could not call Api");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<List<JobCategory>?> jobCategory({
    required String? key,
  }) {
    final form = FormData.fromMap({
      'key': key,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.jobCategory, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final JobCategoriesListJson = response as List;
          print(response);
          final jobCateogies = JobCategoriesListJson.map((e) {
            return JobCategory.fromJson(e);
          }).toList();
          // print("no of job categories ");
          // print(jobCateogies.length);
          return jobCateogies;
        }
      } catch (e) {
        print("cold not get joblist");
        print("Could not call Api");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print("cold not get joblist");
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }


  static Future<dynamic> lineUpCompList({
    required int? rfId,
  }) {
    final form = FormData.fromMap({
      "rf_id": rfId,
      // "page_number":
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.linedUpList, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final lineUoListJson = response as List;
          print(response);
          final lineupList = lineUoListJson.map((e) {
            return AddLineUp.fromJson(e);
          }).toList();
          // print("no of job categories ");
          // print(jobCateogies.length);
          return lineupList;
        }
      } catch (e) {
        print("cold not get joblist");
        print("Could not call Api");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print("cold not get joblist");
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }



  static Future<dynamic> registerUser({
    required String? username,
    required String? password,
    required String? mobile,
    required String? otp,
    required String? role,
    required String? zone,
    required String? repoter,
    required String? empId,
    required String? location,
  }) {
    final form = FormData.fromMap({
      "username": username,
      'password': password,
      'mobile': mobile,
      'otp': otp,
      'role': role,
      'zone': zone,
      'reporter_id': repoter,
      'emp_id': empId,
      'location': location,
    });
    return RestClient().postMethod(url: ApiEndPoints.signUp, data: form).then(
        (dynamic response) {
      try {
        if (response != null) {
          final SignUpResponse respon = SignUpResponse.fromJson(response);
          if (respon.error == "true") {
            final String? message = respon.message;
            throw message ?? "";
          } else {
            return respon.message;
          }
        }

        return SignUpResponse.fromJson(response);
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw AppStrings.unknownError;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func signUp executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> assignTicket({
    required String? parentId,
    required String? childId,
    required String? totalTickets,
  }) {
    final form = FormData.fromMap({
      'parent_id': parentId,
      'child_id': childId,
      'ttl': totalTickets,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.assignTicket, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final json = response as Map<String, dynamic>;
          final AssignTicketResp assRes = AssignTicketResp.fromJson(json);

          print("no of members ");
          return assRes;
        }

        return [];
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw AppStrings.unknownError;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func signUp executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<List<WelcomeScreenIcwImages>?> loadImagesList() async {
    final url = Uri.parse(ApiEndPoints.welcomeScreenImagesApiGet);
    try {
      List<dynamic> welcomeScreenImagesApi = [];
      List<WelcomeScreenIcwImages> welcomeScreenImagesList = [];
      var res = await http.get(url);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        if (jsonData.isNotEmpty) {
          print(jsonData);
          welcomeScreenImagesApi = jsonData;
          for (var element in welcomeScreenImagesApi) {
            welcomeScreenImagesList.add(WelcomeScreenIcwImages(
              id: element['id'],
              image: element['image'],
            ));
          }
          print(welcomeScreenImagesList.length);
          return welcomeScreenImagesList;
        }
      } else if (res.statusCode > 200) {
        throw Exception("Error while fetching data");
      }
    } catch (err) {
      print(err);
      print("error is dere");

      rethrow;
    }
    return null;
  }

  static Future<dynamic> loadReportingMembers({
    required String? role,
  }) {
    final form = FormData.fromMap({
      'role': role,
    });
    return RestClient().postMethod(url: ApiEndPoints.mmbrlist, data: form).then(
        (dynamic response) {
      try {
        if (response != null) {
          final jsonList = response as List;
          final members = jsonList.map((e) {
            return MemberInfo.fromJson(e);
          }).toList();
          print("no of members ");
          return members;
        }

        return [];
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw AppStrings.unknownError;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func signUp executed when rest client throw exeption");
      throw error;
    });
  }

  // 2 called in initstate of otpScreens
  static Future<dynamic> otpMesGateway({
    required String? mobile,
    required String? otp,
  }) {
    const username = "t1codegenium";
    const password = "73930909";
    const sender = "CODEGM";
    final sendto = mobile;
    const entityID = '1701159594049845554';
    const templateID = '1707166324441436149';
    final message =
        "Hi Your OTP for Codegenium verification is ${otp!}. This OTP is valid for 5 minutes. please do not share it with anyone.- CodeGenium";

    final Map<String, String> queryPrams = {
      'username': username,
      'password': password,
      'sender': sender,
      'sendto': sendto!,
      'entityID': entityID,
      'templateID': templateID,
      'message': message,
    };
    return RestClient()
        .otpMesGateway(
            queryParameter: queryPrams, url: ApiEndPoints.mesGateWayOtp)
        .then((dynamic response) {
      try {
        if (response != null) return response;
      } catch (e) {
        print("api client error called");
        log(e.toString());
        rethrow;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  //3 api called on verifyotp button Api called in both otp screens

  static Future<RegisteredUserDetails?> otpVerifyButtonApi({
    required String? mobile,
    required String? otp,
  }) {
    final form = FormData.fromMap({
      'mobile': mobile,
      'otp': otp,
    });
    return RestClient()
        .otpVerifyButtonApi(url: ApiEndPoints.verifyOtp, data: form)
        .then((dynamic response) {
      try {
        if (response['message'] == 'successfull') {
          //response is {"id":17,"mobile":"9761057507","username":"sonam","sts":"ACTIVE","message":"successfull"}

          return RegisteredUserDetails.fromJson(response);
        } else {
          throw response['message'];
        }
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw response['message'];
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  // Api called in forgot password screen on recover account button

  static Future<dynamic> recoverAccButt({
    required String? mobile,
    required String? otp,
  }) {
    final form = FormData.fromMap({
      'mobile': mobile,
      'otp': otp,
    });
    return RestClient().post(url: ApiEndPoints.recoverAccButt, data: form).then(
        (dynamic response) {
      try {
        if (response != null) return SignUpResponse.fromJson(response);
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> ticketsList({
    required String? parentId,
    required String? pageNo,
  }) {
    final form = FormData.fromMap({
      'parent_id': parentId,
      'page_number': pageNo,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.ticketList, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final ListJson = response as List;
          final ticketList = ListJson.map((e) {
            return Ticket.fromJson(e);
          }).toList();
          print("no of tickets");
          print(ticketList.length);
          return ticketList;
        }
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> memberLstByParentId({
    required String? parentId,
  }) {
    final form = FormData.fromMap({
      'parent_id': parentId,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.mmbrListByParentId, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final memListJson = response as List;
          final reportingMemList = memListJson.map((e) {
            return ReportingMember.fromJson(e);
          }).toList();
          print("no of refere candidates");
          print(reportingMemList.length);
          return reportingMemList;
        }
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<RegisteredUserDetails?> login({
    required String? password,
    required String? mobile,
  }) {
    final form = FormData.fromMap({
      'password': password,
      'mobile': mobile,
    });
    return RestClient().post(url: ApiEndPoints.login, data: form).then(
        (dynamic response) {
      try {
        if (response != null) return RegisteredUserDetails.fromJson(response);
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

// api called on resnd otp button
  static Future<dynamic> resendOtpButton({
    required String? otp,
    required String? mobile,
  }) {
    final form = FormData.fromMap({
      'mobile': mobile,
      'otp': otp,
    });
    return RestClient()
        .postResendOtpButton(url: ApiEndPoints.resendToUpdate, data: form)
        .then((dynamic response) {
      try {
        if (response != null) return response;
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client function  on error func resendOtpButton executed when rest client throw exeption");
      throw error;
    });
  }

  //
  // api called in change password screen
  static Future<String?> changePassword({
    required String? password,
    required String? mobile,
  }) {
    final form = FormData.fromMap({
      'password': password,
      'mobile': mobile,
    });
    return RestClient()
        .changePassword(url: ApiEndPoints.changePassword, data: form)
        .then((dynamic response) {
      try {
        if (response != null) return response;
        ;
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw e;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> changePasswordMeber({
    required String? oldPassword,
    required String? newPassword,
    required String? mobile,
  }) {
    final form = FormData.fromMap({
      'password': oldPassword,
      'newpassword': newPassword,
      'mobile': mobile,
    });
    return RestClient()
        .postMethod(url: ApiEndPoints.changePasswordMember, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final respMap = response as Map;
          return respMap['message'];
        }
        throw AppStrings.unknownError;
        // // final String result =response ["message"];
        // print(result);
      } catch (e) {
        print("api client error called");
        log(e.toString());
        throw AppStrings.unknownError;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      throw error;
    });
  }

  static Future<dynamic> totalNumOfTickets({
    required String? mmbr_id,

  }) {
    final form = FormData.fromMap({
      'mmbr_id': mmbr_id,

    });
    return RestClient()
        .postMethod(url: ApiEndPoints.ttl_ticket_by_id, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          print("response of total tickets api");
          print(response);
          final respMap = response as Map;
          return respMap['total'];
        }
        // throw AppStrings.unknownError;
        // // final String result =response ["message"];
        // print(result);
      } catch (e) {
        print("api client error called");
        log(e.toString());
        // throw AppStrings.unknownError;
      }
      return null;
    }, onError: (dynamic error) {
      print(
          "api client on error func executed when rest client throw exeption");
      // throw error;
    });
  }

  static Future<dynamic> editticket({required Ticket ticket}) {
    final form = FormData.fromMap({
      "rf_id": ticket.rfId,
      "rf_mmbr_id": ticket.rfMmbrId,
      "rf_usr_id": ticket.rfUsrId,
      "rf_cand_name": ticket.rfCandName,
      "rf_mob": ticket.rfMob,
      "rf_resume": ticket.rfResume,
      "rf_category": ticket.rfCategory,
      "rf_education": ticket.rfEducation,
      "rf_location": ticket.rfLocation,
      "rf_email": ticket.rfEmail,
      "rf_industry": ticket.rfIndustry,
      "rf_dob": ticket.rfDob,
      "rf_pincode": ticket.rfPincode,
      "rf_wrking_sts": ticket.rfWrkingSts,
      "rf_crnt_ctc": ticket.rfCrntCtc,
      "rf_cmpny_name": ticket.rfCmpnyName,
      "rf_crnt_desg": ticket.rfCrntDesg,
      "rf_notice": ticket.rfNotice,
      "rf_expected_ctc": ticket.rfExpectedCtc,
      "rf_ttl_exp": ticket.rfTtlExp,
      "rf_city": ticket.rfCity,
      "rf_dist": ticket.rfDist,
      "rf_state": ticket.rfState,
      "rf_sts": ticket.rfSts,
      "hr_tenure_crnt_cmpny": ticket.hrTenureCrntCmpny,
      "hr_sales_exp": ticket.hrSalesExp,
      "hr_usr_sts": ticket.hrUsrSts,
      "hr_usr_pan": ticket.hrUsrPan,
      "hr_usr_channel": ticket.hrUsrChannel,
      "rf_alternate_mob": ticket.rfAlternateMob,
      "rf_locality": ticket.rfLocality,
      "rf_preferred_loc": ticket.rfPreferredLoc,
      "rf_feedback": ticket.rfFeedback,
      "rf_remark": ticket.rfRemark,
      "rf_cooling": ticket.rfCooling,
      "rf_br_location": ticket.rfBrLocation,
      "rf_zone": ticket.rfZone,
      "hr_internal_sts": ticket.hrInternalSts,
    });

    return RestClient()
        .postMethod(url: ApiEndPoints.editticket, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final respose = response as Map;
          final message = respose["message"];
          print("printing response");
          print(response);
          // print(message);

          return response;
        }
      } catch (e) {
        log(e.toString());
        throw "Could Not Edit Ticket";
      }
      return null;
    }, onError: (dynamic error) {
      // print(
      //     "api client on error func executed when rest client throw exeption");
      // throw "Could Not Edit Ticket";
    });
  }

  static Future<dynamic> editLineUpDetails({required AddLineUp lineup}) {
    final form = FormData.fromMap({
    "ln_id":lineup.ln_id,
    "ln_desg":lineup.ln_desg,
    "ln_cmpny":lineup.ln_cmpny,
    "ln_intrvw_sts":lineup.ln_intrvw_sts,
    "ln_intervw_dt":lineup.ln_intervw_dt,
    "ln_fdbk":lineup.ln_fdbk,
    "ln_doc_sts":lineup.ln_doc_sts,
    "ln_offer_sts":lineup.ln_offer_sts,
    "ln_expctd_doj":lineup.ln_expctd_doj,
    "ln_joining_dt":lineup.ln_joining_dt,
    "ln_joining_sts":lineup.ln_joining_sts,
    "ln_package":lineup.ln_package,
    "ln_emp_code":lineup.ln_emp_code,
    "ln_cooling_prd":lineup.ln_cooling_prd,
    "ln_regional_hr":lineup.ln_regional_hr,
    "ln_zonal_hr":lineup.ln_zonal_hr,
    "ln_branch_loc":lineup.ln_branch_loc,
    "ln_hr_remark":lineup.ln_hr_remark,
    "ln_tl_remark":lineup.ln_tl_remark,
    "ln_mngr_remark":lineup.ln_mngr_remark,
    "ln_zm_remark":lineup.ln_zm_remark,
    "ln_adm_remark":lineup.ln_adm_remark,

    });

    return RestClient()
        .postMethod(url: ApiEndPoints.editLinedUp, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final respose = response as Map;
          final message = respose["message"];
          print("printing response");
          print(response);
          // print(message);

          return response;
        }
      } catch (e) {
        log(e.toString());
        throw "Could Not Edit Ticket";
      }
      return null;
    }, onError: (dynamic error) {
      // print(
      //     "api client on error func executed when rest client throw exeption");
      // throw "Could Not Edit Ticket";
    });
  }

  static Future<dynamic> addLineUpDetails({required AddLineUp lineUp}) {
    final form = FormData.fromMap({
      "rf_id": lineUp.rfId,
      "ln_desg": lineUp.ln_desg,
      "ln_cmpny": lineUp.ln_cmpny,
      "ln_intrvw_sts": lineUp.ln_intrvw_sts,
      "ln_intervw_dt": lineUp.ln_intervw_dt,
      "ln_fdbk": lineUp.ln_fdbk,
      "ln_doc_sts": lineUp.ln_doc_sts,
      "ln_offer_sts": lineUp.ln_offer_sts,
      "ln_expctd_doj": lineUp.ln_expctd_doj,
      "ln_joining_dt": lineUp.ln_joining_dt,
      "ln_joining_sts": lineUp.ln_joining_sts,
      "ln_package": lineUp.ln_package,
      "ln_emp_code": lineUp.ln_emp_code,
      "ln_cooling_prd": lineUp.ln_cooling_prd,
      "ln_regional_hr": lineUp.ln_regional_hr,
      "ln_zonal_hr": lineUp.ln_zonal_hr,
      "ln_branch_loc": lineUp.ln_branch_loc,
      "ln_hr_remark": lineUp.ln_hr_remark,
      "ln_tl_remark": lineUp.ln_tl_remark,
      "ln_mngr_remark": lineUp.ln_mngr_remark,
      "ln_zm_remark": lineUp.ln_zm_remark,
      "ln_adm_remark": lineUp.ln_adm_remark,
    });

    return RestClient()
        .postMethod(url: ApiEndPoints.addlinedup, data: form)
        .then((dynamic response) {
      try {
        if (response != null) {
          final respose = response as Map;
          final message = respose["message"];
          print("printing response");
          print(response);
          print(message);

          return response;
        }
      } catch (e) {
        log(e.toString());
        throw "Could Not line up";
      }
      return null;
    }, onError: (dynamic error) {
      // print(
      //     "api client on error func executed when rest client throw exeption");
      // throw "Could Not Edit Ticket";
    });
  }

// refered candidate api list called on home screen
}
