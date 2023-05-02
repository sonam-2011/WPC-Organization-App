import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/constants/colors.dart';
import 'package:get/get.dart';
import '../../../constants/app_strings.dart';

import '../../../widgets/custom_button2.dart';
import '../../../widgets/custom_dropdown_formFeild.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/my_behaviour.dart';
import '../../../widgets/validators.dart';
import 'add_member_controller.dart';

class AddMemberScreen extends GetView<AddMemberController> {
  AddMemberScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(AddMemberController());

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
              "Add Member",
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
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35.0, vertical: 10),
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
                                  physics: NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height*0.1,
                                      ),
                                      InputField(
                                        assets:
                                            Icons.person_outline_rounded,
                                        onTap: () {},
                                        textInputAction:
                                            TextInputAction.next,
                                        onSaved: (v) => controller
                                            .firstNameTextController
                                            .text = v,
                                        isNumeric: false,
                                        isPhoneNum: false,
                                        isPasswordField: false,
                                        controller: controller
                                            .firstNameTextController,
                                        validator:
                                            Validators.validateName,
                                        text: AppStrings.fullName,
                                      ),
                                      SizedBox(
                                        height: Get.height * .02,
                                      ),
                                      InputField(
                                        onTap: () {},
                                        assets: Icons
                                            .mobile_screen_share_sharp,
                                        textInputAction:
                                            TextInputAction.next,
                                        onSaved: (v) => controller
                                            .phoneTextController.text = v,
                                        isNumeric: true,
                                        isPhoneNum: false,
                                        controller: controller
                                            .phoneTextController,
                                        validator:
                                            Validators.validatePhone,
                                        text: AppStrings.mobileNum,
                                      ),
                                      SizedBox(
                                        height: Get.height * .02,
                                      ),
                                      InputField(
                                        onTap: () {},
                                        assets: Icons.password_sharp,
                                        textInputAction:
                                            TextInputAction.next,
                                        isNumeric: false,
                                        isPhoneNum: false,
                                        isPasswordField: true,
                                        onSaved: (v) => controller
                                            .passwordTextController
                                            .text = v,
                                        controller: controller
                                            .passwordTextController,
                                        validator:
                                            Validators.validatePassword,
                                        text: AppStrings.pass,
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
                                      InputField(
                                        onTap: () {},
                                        assets: Icons.perm_identity,
                                        textInputAction:
                                            TextInputAction.next,
                                        isNumeric: false,
                                        isPhoneNum: false,
                                        isPasswordField: false,
                                        onSaved: (v) =>
                                            controller.emppId.text = v,
                                        controller: controller.emppId,
                                        validator:
                                            Validators.validateEmpty,
                                        text: AppStrings.empId,
                                      ),
                                      SizedBox(
                                        height: Get.height * .02,
                                      ),
                                      InputField(
                                        onTap: () {},
                                        assets: Icons.location_on,
                                        textInputAction:
                                            TextInputAction.next,
                                        isNumeric: false,
                                        isPhoneNum: false,
                                        isPasswordField: false,
                                        onSaved: (v) =>
                                            controller.location.text = v,
                                        controller: controller.location,
                                        validator:
                                            Validators.validateEmpty,
                                        text: AppStrings.location,
                                      ),
                                      SizedBox(
                                        height: Get.height * .02,
                                      ),
                                      CustomDropDownFormButton(
                                        isReadOnly: false,
                                          validator: (value) =>
                                              value == null
                                                  ? AppStrings.zone
                                                  : null,
                                          text: AppStrings.zone,
                                          items: const [
                                            'North',
                                            'South',
                                            'East',
                                            'West',
                                          ],
                                          selectedOptionController:
                                              controller.zone),
                                      SizedBox(
                                        height: Get.height * .02,
                                      ),
                                      CustomDropDownFormButton(
                                        isReadOnly: false,
                                        validator: (value) =>
                                            value == null
                                                ? AppStrings.role
                                                : null,
                                        text: AppStrings.role,
                                        items: const [
                                          'HR',
                                          'Team Lead',
                                          'Manager',
                                          'Zonal Manager',
                                        ],
                                        selectedOptionController:
                                            controller.roleController,
                                        optionalFunction: controller
                                            .changeIsroleselectedVale,
                                      ),
                                      SizedBox(
                                        height: Get.height * .02,
                                      ),
                                      Obx(() {
                                        if (controller
                                            .isRoleSelected.value && controller.reportingPer.value.length >0) {
                                          return Column(
                                            children: [
                                              CustomDropDownFormButton2(

                                                validator: (value) =>
                                                    value == null
                                                        ? AppStrings
                                                            .reporter
                                                        : null,
                                                text: AppStrings.reporter,
                                                items:controller.reportingPer.value,
                                                selectedOptionController:
                                                    controller.reporter,
                                                optionalFunction: (v) {
                                                  print(
                                                      "executed optional function");
                                                },
                                              ),
                                              SizedBox(
                                                height: Get.height * .02,
                                              ),
                                            ],
                                          );
                                        } else {
                                          print("sizebox");
                                          return SizedBox();
                                        }
                                      }),
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
                        Obx(
                          () => Row(
                            children: [
                              Checkbox(
                                shape: const CircleBorder(),
                                //mouseCursor:MouseCursor.uncontrolled,
                                activeColor: MyColors.appBlack,
                                value: controller.agree.value,
                                onChanged: (value) {
                                  controller.agree.value = value!;
                                },
                              ),
                              const InkWell(
                                // onTap: (){
                                //   Get.toNamed(Routes.termsAndCon);
                                // },
                                child: Text(
                                  AppStrings.terms,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                        CustomButton2(
                          color: const Color(0xff1562A7),
                          colorText: Colors.white,
                          text: "Add Member",
                          onTap: () {
                            controller.submit(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
