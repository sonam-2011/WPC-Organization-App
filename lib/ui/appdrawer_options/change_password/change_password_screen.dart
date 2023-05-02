import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/constants/colors.dart';
import 'package:get/get.dart';
import '../../../constants/app_strings.dart';

import '../../../widgets/custom_button2.dart';
import '../../../widgets/custom_dropdown_formFeild.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/my_behaviour.dart';
import '../../../widgets/validators.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  ChangePasswordScreen({Key? key}) : super(key: key);


  @override
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();

          return true;
        },
        child: Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            title: const Text(
              "Change Password",
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.clearControllers();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            elevation: 0,
            // leading: IconButton(onPressed: () {  }, icon: Icon(Icons.arrow_back_ios,)),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * .1,
                      width: Get.width,
                    ),
                    Container(
                      height: Get.height * .9,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: MyColors.formBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 10),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 9),
                                child: Column(
                                  children: [
                                    Form(
                                      key: controller.formKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            InputField(
                                              assets:
                                              Icons.visibility,
                                              onTap: () {},
                                              textInputAction:
                                              TextInputAction.next,
                                              onSaved: (v) => controller
                                                  .oldPassword
                                                  .text = v,
                                              isNumeric: false,
                                              isPhoneNum: false,
                                              isPasswordField: false,
                                              controller: controller
                                                  .oldPassword,
                                              validator:
                                              Validators.validateEmpty,
                                              text: AppStrings.oldPasword,
                                            ),
                                            SizedBox(
                                              height: Get.height * .02,
                                            ),
                                            InputField(
                                              onTap: () {},
                                              assets: Icons
                                                  .visibility,
                                              textInputAction:
                                              TextInputAction.next,
                                              onSaved: (v) => controller
                                                  .passwordTextController.text = v,
                                              isNumeric: false,
                                              isPhoneNum: false,
                                              controller: controller
                                                  .passwordTextController,
                                              validator:
                                              Validators.validatePassword,
                                              text: AppStrings.newpass,
                                            ),
                                            SizedBox(
                                              height: Get.height * .02,
                                            ),

                                            Obx(
                                                  () => InputField(
                                                assets: controller
                                                    .hidePassword.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                onTap: () {
                                                  controller
                                                      .hidePassword.value =
                                                  !controller
                                                      .hidePassword.value;
                                                },
                                                textInputAction:
                                                TextInputAction.done,
                                                onSaved: (v) => controller
                                                    .confirmPasswordController
                                                    .text = v,
                                                isNumeric: false,
                                                isPhoneNum: false,
                                                isPasswordField: controller
                                                    .hidePassword.value
                                                    ? true
                                                    : false,
                                                controller: controller
                                                    .confirmPasswordController,
                                                validator: (v) => Validators
                                                    .validateConfirmPassword(
                                                    controller
                                                        .passwordTextController
                                                        .text,
                                                    controller
                                                        .confirmPasswordController
                                                        .text),
                                                text: AppStrings.conPass,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * .02,
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),


                              CustomButton2(
                                color:  MyColors.appBlack,
                                colorText: MyColors.appWhite,
                                text: "Change Password",
                                onTap: () {
                                  controller.submit(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}


