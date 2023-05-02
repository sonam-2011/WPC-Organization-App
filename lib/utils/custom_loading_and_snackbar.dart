import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/response/registered_user_details.dart';

class CustomLoadingFunction {
  CustomLoadingFunction._();

 static  void _showDialog({required String message,required BuildContext context}) {
    showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: Text(message),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Okay'),
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.of(context).pop;
                  },
                )
              ],
            ));
  }
  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('An Error Occurred While submitting data'),
  //       content: Text(message),
  //       actions: <Widget>[
  //         ElevatedButton(
  //           child: const Text('Okay'),
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  void _showSuccessDialog({required String message,required BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Okay'),
              onPressed: () {

                Navigator.of(ctx).pop();

              },
            )
          ],
        ));
  }

  static Future<void> navigate(
      {RegisteredUserDetails? userDetails,
      required BuildContext context,
      required String loadingMes}) async {
    final close =
        context.showLoading(textColor: MyColors.appWhite, msg: loadingMes);
    await Future.delayed(2.seconds, close as FutureOr Function()?);
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    //   return ChangePasswordScreen(
    //     userDetails: userDetails,
    //   );
  }
}
