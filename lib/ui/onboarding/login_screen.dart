import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/ui/onboarding/sign_up_screen.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../api/api_client.dart';
import '../../constants/app_strings.dart';
import '../../constants/colors.dart';
import '../../models/response/registered_user_details.dart';
import '../../provider/shared_pref_provider.dart';
import '../../shared_preferences_data.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_button2.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/input_field.dart';
import '../../widgets/validators.dart';
import '../dashboard_screen/dashboard.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState>? formKey;
  var scaffoldKey;
  bool hidePass = true;
  int intialtap = 0;
  bool isSigningUp = false;
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    formKey = GlobalKey<FormState>();
  }



  dispose() {
    phoneTextController.dispose();
    passwordTextController.dispose();

    super.dispose();
  }

  login() async {
    if (!formKey!.currentState!.validate()) {
      return;
    }
    formKey?.currentState!.save();

    print("reaching here");
    try {
      print("before api");
      final RegisteredUserDetails? loginResponse =
          await ApiClient // need to put () to remove error
              .login(
        mobile: phoneTextController.text.replaceAll(" ", ""),
        password: passwordTextController.text,
      );
      print("after api");
      final close = context.showLoading(
          textColor: MyColors.appWhite, msg: 'Logging In');
      await Future.delayed(2.seconds, close as FutureOr Function()?);
      print(loginResponse?.username);
      print(loginResponse?.mobile);
      Provider.of<ShraredPrefProvider>(context, listen: false).saveLoginResponse(loginResponse!);

       // SharedPreferencesData.saveLoginResponse(loginResponse!);
      print("Data saved in shared prefs");
      print(loginResponse.username);
      navigate(loginResponse);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void navigate(RegisteredUserDetails loginResponse) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return DashBoard(userDetails: loginResponse);
    }));
  }

  void _showErrorDialog(String message) {
    Dialogs.showErrorDialog(message, context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            AppStrings.login.text
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                      SizedBox(
                        height: context.percentHeight * 2,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            CustomButton2(
              onTap: login,
              text: "Login",
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            // CustomTextButton(
            //   text: AppStrings.signUpButton,
            //   onTap: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) {
            //       return SignUpScreen();
            //     }));
            //   },
            // ),
            // SizedBox(height: size.height * 0.01),
            CustomTextButton(
              text: AppStrings.forgotPasBut,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ForgotPasswordScreen();
                }));
              },
            ),
            // VxInlineBlock(
            //   verticalDirection: VerticalDirection.up,
            //   children: [
            //     "VelocityX is Super".text.make().box.height(90).red500.make(),
            //     "VelocityX increase productivity".text.make().box.red500.make()
            //   ],
            // ),
            // VxBlock(
            //   children: [
            //     "VelocityX is Super".text.make().box.h.red500.make(),
            //     "VelocityX increase productivity".text.make().box.red500.make()
            //   ],
            //   verticalDirection: VerticalDirection.up,
            // ),
          ].vStack(),
        ),
      ),
    );
  }
}
