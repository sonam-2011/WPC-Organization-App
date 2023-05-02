import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/constants/app_strings.dart';
import 'package:freelancer_internal_app/constants/colors.dart';

import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../api/api_client.dart';
import '../../../helper_functions.dart';
import '../../../models/member_info.dart';
import 'custom_model_dropdown_itm.dart';

class AddMemberController extends GetxController {
  // final ApiClient _apiClient = Get.find<ApiClient>();
  GlobalKey<FormState>? formKey;

  // Rx<SocialButton> selectedSocialButton = SocialButton.none.obs;
  // SocialLogin socialLogin = SocialLogin();

  RxBool isAdding = false.obs;
  RxBool agree = false.obs;
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController emppId = TextEditingController();
  TextEditingController reporter = TextEditingController();
  TextEditingController zone = TextEditingController();
  RxList<CustoMDropDownMenuItem> reportingPer = <CustoMDropDownMenuItem>[].obs;
  String mobileNumber = '';

  RxBool hidePassword = true.obs;
  RxBool isRoleSelected = false.obs;
  var scaffoldKey;

  @override
  void onInit() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    firstNameTextController.dispose();

    phoneTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordController.dispose();
    roleController.dispose();
    zone.dispose();
    emppId.dispose();
    location.dispose();
    reporter.dispose();
  }

  void clearControllers() {
    firstNameTextController.clear();

    phoneTextController.clear();
    passwordTextController.clear();
    confirmPasswordController.clear();
    reportingPer.value=[];

    roleController.clear();
    zone.clear();
    emppId.clear();
    location.clear();
    reporter.clear();
    agree.value = false;
  }

  submit(BuildContext context) async {
    if (!formKey!.currentState!.validate()) {
      print("not valide");
      print(isAdding.value);
      return;
    }

    print("checking value");
    if (agree.value == false) {
      HelperFunctions.snackBarFunc(
          message: AppStrings.pleaseAcceptthe, context: context);

      return;
    }

    if (formKey!.currentState!.validate()) {
      formKey!.currentState!.save();
      var rng = Random();
      var otp = rng.nextInt(900000) + 100000;
      print(otp);
      print(firstNameTextController.text);
      print(passwordTextController.text);
      print(phoneTextController.text);
      print(emppId.text);
      print(location.text);
      print(zone.text);
      print(roleController.text);

      print(reporter.text);
      // isAdding.value = true;
      try {
        final Future result = ApiClient.registerUser(
            username: firstNameTextController.text,
            password: passwordTextController.text,
            mobile: phoneTextController.text,
            otp: otp.toString(),
            role: roleController.text,
            zone: zone.text,
            repoter: reporter.text,
            empId: emppId.text,
            location: location.text);
        final close = context.showLoading(
            textColor: MyColors.appWhite, msg: 'Adding Member');
        await Future.delayed(2.seconds, close as FutureOr Function()?);

        if (await result != null) {
          final String message = await result;
          HelperFunctions.snackBarFunc(message: message, context: context);

          if (message == "Member Added successfully") {
            clearControllers();
          }
          // isAdding.value = false;
        }
      } catch (e) {
        print("in catch block");
        HelperFunctions.snackBarFunc(message: e.toString(), context: context);
      } finally {
        print("finally executed");
        agree.value = false;
      }
    }
  }

  changeIsroleselectedVale(String? p1) async {
    isRoleSelected.value =false;
    reporter.text ="";
     // reportingPer.value =[];


    String ? reportingTo;

    switch (roleController.value.text) {
      case "HR":
        {
          reportingTo = "Team Lead";
          // Body of value1
        }
        break;
      case "Team Lead":
        {
          reportingTo = "Manager";
          //Body of value2
        }
        break;
      case "Manager":
        {
          reportingTo = "Zonal Manager";
          // Body of value1
        }
        break;
      case "Zonal Manager":
        {
          reportingTo = "Admin";
          // Body of value1
        }
        break;
    }
    try {
      final result = await ApiClient.loadReportingMembers(
        role: reportingTo,
      );
      print("before");
      final repList = result as List<MemberInfo>;
      List<CustoMDropDownMenuItem> repPer = [];
      for (MemberInfo mem in repList) {
        repPer.add(CustoMDropDownMenuItem(
            memId: mem.mmbrId.toString(), memName: mem.mmbrName ?? "", empId: mem.mmbrEmpId??""));
      }

      reportingPer.value = repPer;
      print("After");
    } catch (e) {
      print("in catch block");
    } finally {
      print("finally executed");
    }

    isRoleSelected.value = true;
  }
}
