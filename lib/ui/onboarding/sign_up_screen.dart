import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../api/api_client.dart';
import '../../constants/app_strings.dart';
import '../../constants/colors.dart';
import '../../models/response/sign_up_response.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_button2.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/input_field.dart';
import '../../widgets/validators.dart';
import 'otp_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState>? formKey;
  var scaffoldKey;
  bool hidePass = true;
  int intialtap = 0;
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController conPassTextController = TextEditingController();

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    formKey = GlobalKey<FormState>();
  }


  @override
  dispose(){
    firstNameTextController.dispose();
    phoneTextController.dispose();
    passwordTextController.dispose();
    conPassTextController.dispose();
    super.dispose();
  }


  signUp() async {
    if (!formKey!.currentState!.validate()) {
      return;
    }
    print("validating");
    formKey!.currentState!.save();
    // setState(() {
    //   isSigningUp = true;
    // });

    print("reaching here");
    var rng = Random();
    var otp = rng.nextInt(900000) + 100000;
    print(otp);

    try {
      final dynamic signUpResponse = await ApiClient.signUp(
        // need to put () to remove error(
        mobile: phoneTextController.text.replaceAll(" ", ""),
        password: passwordTextController.text,
        username: firstNameTextController.text,
        otp: otp.toString(), role: "",
      );


        final SignUpResponse signUpRes = signUpResponse;

        final Map<String, String> map = {
          'mobile': phoneTextController.text,
          "otp": otp.toString(),
        };

        navigate(data: map);

    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> navigate({required Map<String, String> data}) async {
    final close = context.showLoading(msg: "Loading", textColor: Colors.white);
    await Future.delayed(2.seconds, close as FutureOr Function()?);
    navigateToNextPage(data);

  }


  void navigateToNextPage(Map data) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return OtpScreen(
        map: data,
      );
    }));
  }


  void _showErrorDialog(String message) {
    final mes1 = message.replaceAll("Exception:", "");
    final mes = mes1.replaceFirst(" ", "");
    Dialogs.showErrorDialog(mes, context);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(


        appBar: AppBar(
          backgroundColor: MyColors.appBlack,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          elevation: 0,
          // leading: IconButton(onPressed: () {  }, icon: Icon(Icons.arrow_back_ios,)),
        ),
        body: VxScrollVertical(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            SizedBox(
              height: context.percentHeight * 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppStrings.welcome.text
                    .color(MyColors.appBlack)
                    .xl3
                    .bold
                    .center
                    .heightRelaxed
                    .underline
                    .make(),
              ],
            ),
            SizedBox(
              height: context.percentHeight * 8,
            ),
            AppStrings.signUp.text
                .color(MyColors.appBlack)
                .xl2
                .bold
                .center
                .heightRelaxed
                .make(),
            SizedBox(
              height: context.percentHeight * 5,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    InputField(
                      assets: Icons.person,
                      onTap: () {},
                      textInputAction: TextInputAction.next,
                      onSaved: (v) {},
                      isNumeric: false,
                      isPhoneNum: false,
                      isPasswordField: false,
                      controller: firstNameTextController,
                      validator: Validators.validateName,
                      text: AppStrings.fullName,
                    ),
                    SizedBox(
                      height: context.percentHeight * 2,
                    ),
                    InputField(
                      onTap: () {},
                      assets: Icons.phone,
                      textInputAction: TextInputAction.next,
                      onSaved: (v) {},
                      isNumeric: true,
                      isPhoneNum: false,
                      controller: phoneTextController,
                      validator: Validators.validatePhone,
                      text: AppStrings.mobileNum,
                    ),
                    SizedBox(
                      height: context.percentHeight * 2,
                    ),
                    InputField(
                      onTap: () {
                        print("ontap");

                        if(intialtap>0){
                          print("ontap>0" );

                          setState(() {
                            hidePass = !hidePass;
                          });
                        }else if(intialtap==0){
                          print("ontap=0" );

                          setState(() {
                            intialtap=intialtap + 1;
                          });
                          print(intialtap);
                        }

                      },
                      assets:
                      hidePass ? Icons.visibility_off : Icons.visibility,
                      textInputAction: TextInputAction.next,
                      onSaved: (v) {},
                      isNumeric: false,
                      isPhoneNum: false,
                      isPasswordField: hidePass ? true : false,
                      controller: passwordTextController,
                      validator: Validators.validatePassword,
                      text: AppStrings.pass,
                    ),
                    SizedBox(
                      height: context.percentHeight * 2,
                    ),
                    InputField(
                      onTap: () {
                        print("ontap");

                        if(intialtap>0){
                          print("ontap>0" );

                          setState(() {
                            hidePass = !hidePass;
                          });
                        }else if(intialtap==0){
                          print("ontap=0" );

                          setState(() {
                            intialtap=intialtap + 1;
                          });
                          print(intialtap);
                        }

                      },
                      assets:
                      hidePass ? Icons.visibility_off : Icons.visibility,
                      textInputAction: TextInputAction.next,
                      onSaved: (v) {},
                      isNumeric: false,
                      isPhoneNum: false,
                      isPasswordField: hidePass ? true : false,
                      controller: conPassTextController,
                      validator: Validators.validatePassword,
                      text: AppStrings.conPass,
                    ),
                    SizedBox(
                      height: context.percentHeight * 1,
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppStrings.tAndConditions.text
                    .color(MyColors.appBlack)
                    .xs
                    .bold
                    .align(TextAlign.start)
                    // .start
                    .heightRelaxed
                    .make(),
              ],
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            CustomButton2(
              onTap: signUp,
              text: "Sign Up",
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            CustomTextButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              text: AppStrings.alreadyHaveAcc,
            )
          ].vStack(),
        ),
      ),
    );
  }
}
