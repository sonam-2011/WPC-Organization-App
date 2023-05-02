import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../api/api_client.dart';
import '../../constants/app_strings.dart';
import '../../constants/colors.dart';
import '../../widgets/custom_button2.dart';
import '../../widgets/input_field.dart';
import '../../widgets/validators.dart';
import 'otp_screen2_resend_otp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState>? formKey;
  var scaffoldKey;

  TextEditingController phoneTextController = TextEditingController();

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    formKey = GlobalKey<FormState>();
  }

  // dispose() {
  //   phoneTextController.dispose();
  //
  //
  //   super.dispose();
  // }

  recoverAccButt() async {
    if (!formKey!.currentState!.validate()) {
      return;
    }
    print("validating");
    formKey!.currentState!.save();

    print("reaching here");
    var rng = Random();
    var otp = rng.nextInt(900000) + 100000;
    print(otp);

    try {
      final dynamic signUpResponse = await ApiClient.recoverAccButt(
        // need to put () to remove error(
        mobile: phoneTextController.text.replaceAll(" ", ""),
        otp: otp.toString(),
      );

      // final SignUpResponse signUpRes = signUpResponse;

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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return OtpScreen2ResendOtp(
        map: data,
      );
    }));
  }

  void _showErrorDialog(String message) {
    final mes1 = message.replaceAll("Exception:", "");
    final mes = mes1.replaceFirst(" ", "");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(mes),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: VxScrollVertical(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                SizedBox(
                  height: context.percentHeight * 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppStrings.forpass.text
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
                            text: AppStrings.regisMob,
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
                SizedBox(height: size.height * 0.02),
                CustomButton2(
                  text: AppStrings.recoverAccButt,
                  onTap: recoverAccButt
                ),
                SizedBox(height: size.height * 0.02),
              ].vStack(),
            ),
          ),
        ),
      ),
    );
  }
}
