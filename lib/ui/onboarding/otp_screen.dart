import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../api/api_client.dart';
import '../../constants/app_strings.dart';
import '../../constants/colors.dart';
import '../../models/response/registered_user_details.dart';
import '../../provider/shared_pref_provider.dart';
import '../../shared_preferences_data.dart';
import '../../widgets/custom_button2.dart';
import '../../widgets/input_field.dart';
import '../../widgets/validators.dart';
import '../dashboard_screen/dashboard.dart';




class OtpScreen extends StatefulWidget {
  final Map map;

  const OtpScreen({Key? key, required this.map}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpTextController = TextEditingController();
  late Future<dynamic> loginId;
  GlobalKey<FormState>? otp;
  var scaffoldKey;

  dispose() {
    otpTextController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    scaffoldKey = GlobalKey<ScaffoldState>();
    otp = GlobalKey<FormState>();
    loginId = sendMes();//calling mes gateway to sent otp on mobile after getting positive response from server
    print(loginId);

    super.initState();
  }

  Future<dynamic> sendMes() async {
    String mobile = widget.map['mobile'];
    String otp = widget.map['otp'];
    var loginId = await ApiClient.otpMesGateway(mobile: mobile, otp: otp);
    _showSnackbar(AppStrings.otpMes);
    print(loginId);

    print(loginId);
    // print(details?.length);

    return loginId;
  }

  void _showSnackbar(String mes) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mes)));
  }

  verifyOtp() async {
    if (otpTextController.text.length < 6) {
      _showSnackbar(AppStrings.otpValidation);
      return;
    }

    otp?.currentState!.save();
    String mobile = widget.map['mobile'];

    try {
      final RegisteredUserDetails? userDetails = await ApiClient.otpVerifyButtonApi(
          mobile: mobile, otp: otpTextController.text);


      navigate(userDetails: userDetails);
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  Future<void> navigate({required RegisteredUserDetails? userDetails}) async {
    final close =
        context.showLoading(textColor: Colors.white, msg: 'Verifying');
    await       SharedPreferencesData.clearData();
    print("details cleared from shared pref");
    Provider.of<ShraredPrefProvider>(context, listen: false).saveLoginResponse(userDetails!);
    // SharedPreferencesData.saveLoginResponse(userDetails!);
    print("details saved in shared pref");
    await Future.delayed(2.seconds, close as FutureOr Function()?);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return DashBoard(userDetails: userDetails);
    }));
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              AppStrings.verCode.text
                  .color(MyColors.appBlack)
                  .xl2
                  .bold
                  .center
                  .heightRelaxed
                  .underline
                  .make(),
            ]),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            AppStrings.pleaseEnterOtp.text.color(MyColors.appBlack).xl.make(),
            SizedBox(
              height: context.percentHeight * 5,
            ),
            Form(
                key: otp,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InputField(
                        onTap: () {},
                        textInputAction: TextInputAction.next,
                        onSaved: (v) {
                          otpTextController.text = v;
                          print("on saved");
                          print(otpTextController.text);
                        },
                        isNumeric: false,
                        isPhoneNum: false,
                        controller: otpTextController,
                        validator: Validators.validateEmpty,
                        text: "Enter OTP",
                      ),
                      // OtpTextField(
                      //   clearText: true,
                      //   autoFocus: false,
                      //   cursorColor: Colors.black,
                      //   filled: true,
                      //   fillColor: Colors.white24,
                      //   fieldWidth: 50,
                      //   numberOfFields: 6,
                      //   borderColor: MyColors.blackMy,
                      //
                      //   //set to true to show as box or false to show as dash
                      //   showFieldAsBox: true,
                      //   //runs when a code is typed in
                      //   onCodeChanged: (String code) {
                      //     print("on code changed executed");
                      //     // otpTextController.text = code;
                      //   },
                      //
                      //   //runs when every textfield is filled
                      //   onSubmit: (String verificationCode) {
                      //     otpTextController.text = verificationCode;
                      //     print("executing onsubmit");
                      //   }, // end onSubmit
                      // ),
                      SizedBox(
                        height: context.percentHeight * 2,
                      ),
                      OtpTimer(map: widget.map),
                    ],
                  ),
                )),
            CustomButton2(
              onTap: verifyOtp,
              text: "Verify Otp",
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
          ].vStack(),
        ),
      ),
    );
  }
}

class OtpTimer extends StatefulWidget {
  final Map map;

  const OtpTimer({Key? key, required this.map}) : super(key: key);

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 5);
  bool isResend = false;

  void initState() {
    super.initState();
    startTimer();
  }
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
    startTimer();
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    if(mounted==true){
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }

  }

  Future<dynamic> resendOtp() async {
    String mobile = widget.map['mobile'];
    String otp = widget.map['otp'];

    try {
      final dynamic message =
          await ApiClient.resendOtpButton(mobile: mobile, otp: otp);

      _showSnackbar(message);
    } catch (e) {
      _showSnackbar(e.toString());
    }

    var loginId = await ApiClient.otpMesGateway(mobile: mobile, otp: otp);
    _showSnackbar(AppStrings.otpMes);
    print(loginId);

    print(loginId);
    // print(details?.length);

    return loginId;
  }

  void _showSnackbar(String mes) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mes)));
    return;
  }


  // void stopTimer() {
  //   setState(() => countdownTimer!.cancel());
  // }

  Future<void> resetTimerResendOtp() async {
    resetTimer();
    setState(() {
      myDuration = const Duration(minutes: 5);
    });
    await resendOtp();
    print("resend otp");
  }

  // Step 6


  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes.remainder(05));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: resetTimerResendOtp,
          child: AppStrings.resendOTP.text
              .color(MyColors.appBlack)
              .xl
              .bold
              .center
              .heightRelaxed
              .underline
              .make(),
        ),
        if (int.parse(seconds) > 0)'$minutes:$seconds'.text.color(MyColors.appBlack).xl.bold.center.make(),

      ],
    );
  }
}
