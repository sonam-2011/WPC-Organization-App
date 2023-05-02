import 'dart:async';

import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../api/api_client.dart';
import '../../constants/app_strings.dart';
import '../../constants/colors.dart';
import '../../models/response/registered_user_details.dart';
import '../../widgets/custom_button2.dart';
import '../../widgets/input_field.dart';
import '../../widgets/validators.dart';
import 'change_password_screen.dart';

class OtpScreen2ResendOtp extends StatefulWidget {
  final Map map;

  const OtpScreen2ResendOtp({Key? key, required this.map}) : super(key: key);

  @override
  State<OtpScreen2ResendOtp> createState() => _OtpScreen2ResendOtpState();
}

class _OtpScreen2ResendOtpState extends State<OtpScreen2ResendOtp> {
  TextEditingController otpTextController = TextEditingController();
  late Future<dynamic> loginId;
  GlobalKey<FormState>? otp;
  late List<TextEditingController?> _textControllers;
  var scaffoldKey;

  // late String otpEntered;

  dispose() {
    otpTextController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    scaffoldKey = GlobalKey<ScaffoldState>();
    otp = GlobalKey<FormState>();
    loginId = sendMes();
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
    return;
  }

  verifyOtp() async {
    if (otpTextController.text.length < 6) {
      _showSnackbar(AppStrings.otpValidation);
      return;
    }

    otp?.currentState!.save();
    String mobile = widget.map['mobile'];

    try {
      final RegisteredUserDetails? userDetails =
          await ApiClient.otpVerifyButtonApi(
              mobile: mobile, otp: otpTextController.text);

      navigate(userDetails: userDetails);
    } catch (e) {
      _showSnackbar(e.toString());
      // otpTextController.clear();
    }
  }

  Future<void> navigate({RegisteredUserDetails? userDetails}) async {
    final close =
        context.showLoading(textColor: Colors.white, msg: 'Verifying');
    await Future.delayed(2.seconds, close as FutureOr Function()?);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return ChangePasswordScreen(
        userDetails: userDetails,
      );
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
                        onSaved: (v) => otpTextController.text = v,
                        isNumeric: false,
                        isPhoneNum: false,
                        controller: otpTextController,
                        validator: Validators.validateEmpty,
                        text: "Enter OTP",
                      ),

                      SizedBox(
                        height: context.percentHeight * 2,
                      ),
                      OtpTimer(
                        map: widget.map,
                      ),
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
  Duration myDuration = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  /// Timer related methods ///
  // Step 3
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
    if (mounted) {
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

  Future<void> resetTimerResendOtp() async {
    resetTimer();
    if (mounted == true) {}
    setState(() {
      myDuration = const Duration(minutes: 5);
    });
    try {
      final dynamic response = await ApiClient.resendOtpButton(
          otp: widget.map['otp'], mobile: widget.map['mobile']);
      if (response == "OTP sent to your mobile number") {
        var loginId = await ApiClient.otpMesGateway(
            mobile: widget.map['mobile'], otp: widget.map['otp']);
        print('mes gateway');
        print(loginId);
        _showSnackbar(AppStrings.otpMes);
      }

      print("resend otp");
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  void _showSnackbar(String mes) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mes)));
    return;
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    // final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(05));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Center(
      child: Column(
        children: [
          Row(
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
              if (int.parse(seconds) > 0)
                '$minutes:$seconds'
                    .text
                    .color(MyColors.appBlack)
                    .xl
                    .bold
                    .center
                    .make(),
            ],
          ),
        ],
      ),
    );
  }
}

// Timer? countdownTimer;
// Duration myDuration = const Duration(minutes: 1);
// bool isResend = false;
//
// @override
// void initState() {
//   super.initState();
//   startTimer();
// }
//
// void startTimer() {
//   countdownTimer =
//       Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
// }
//
// // void stopTimer() {
// //   setState(() => countdownTimer!.cancel());
// // }
//
//
// Future<dynamic> resendOtp() async {
//   String mobile = widget.map['mobile'];
//   String otp = widget.map['otp'];
//
//   try {
//     // final dynamic message = await ApiClient.otpVerify(
//     //     mobile: mobile, otp: otp);
//
//     // _showSnackbar(message);
//   } catch (e) {
//     _showSnackbar(e.toString());
//   }
// }
//
// void _showSnackbar(String mes) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mes)));
//   return;
// }
// //   // Step 6
// void setCountDown() {
//   const reduceSecondsBy = 1;
//   if (mounted) {
//     setState(() {
//       var seconds = myDuration.inSeconds - reduceSecondsBy;
//       if (seconds < 0) {
//         setState(() {
//           seconds=myDuration.inSeconds;
//         });
//       } else {
//         myDuration = Duration(seconds: seconds);
//       }
//     });
//   }
// }
//
// @override
// Widget build(BuildContext context) {
//   String strDigits(int n) => n.toString().padLeft(2, '0');
//
//   final minutes = strDigits(myDuration.inMinutes.remainder(60));
//   final seconds = strDigits(myDuration.inSeconds.remainder(60));
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       '$minutes:$seconds'.text.color(MyColors.pinkMy).xl.bold.center.make(),
//       TextButton(
//         onPressed:resendOtp,
//         child: AppStrings.resendOTP.text
//             .color(MyColors.pinkMy)
//             .xl
//             .bold
//             .center
//             .heightRelaxed
//             .underline
//             .make(),
//       ),
//     ],
//   );
// }
