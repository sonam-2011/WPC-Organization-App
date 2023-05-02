import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../api/api_client.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/colors.dart';
import '../../../helper_functions.dart';
import '../../../models/member_info.dart';
import '../../../models/response/registered_user_details.dart';
import '../../../provider/shared_pref_provider.dart';

class ChangePasswordController extends GetxController {
  // final ApiClient _apiClient = Get.find<ApiClient>();
  GlobalKey<FormState>? formKey;

  // Rx<SocialButton> selectedSocialButton = SocialButton.none.obs;
  // SocialLogin socialLogin = SocialLogin();

  RxBool isAdding = false.obs;

  RxBool agree = false.obs;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String mobileNumber = '';

  RxBool hidePassword = true.obs;
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
    oldPassword.dispose();

    passwordTextController.dispose();
    confirmPasswordController.dispose();
  }

  void clearControllers() {
    oldPassword.clear();

    passwordTextController.clear();
    confirmPasswordController.clear();

    agree.value = false;
  }

  submit(BuildContext context) async {
    if (!formKey!.currentState!.validate()) {
      print("not valide");

      return;
    }

    if (formKey!.currentState!.validate()) {
      formKey!.currentState!.save();

      print(oldPassword.text);
      print(passwordTextController.text);
      print(confirmPasswordController.text);
      RegisteredUserDetails? userDetails;
      userDetails =
          Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
      print(userDetails?.mobile);

      // isAdding.value = true;
      try {
       Future result =  ApiClient.changePasswordMeber(
            oldPassword: oldPassword.text,
            newPassword: passwordTextController.text,
            mobile: userDetails?.mobile);
        final close = context.showLoading(
            textColor: MyColors.appWhite, msg: 'Changing Password');
        await Future.delayed(2.seconds, close as FutureOr Function()?);

        if (await result == "Password changed successfully!") {
          final String message = await result ;
          print(message);
          HelperFunctions.snackBarFunc(message: message, context: context);

          clearControllers();
          Navigator.of(context).pop;

          isAdding.value = false;
        }else{
          HelperFunctions.snackBarFunc(message:await result, context: context);
        }
      } catch (e) {
        print("in catch block");
        print(e);
        HelperFunctions.snackBarFunc(message: e.toString(), context: context);
      }
    }
  }
}
