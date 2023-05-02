import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';

class Dialogs{
  Dialogs._();

 static void showErrorDialog(String message1,context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:  const Text("An Error Occured"),
        content: Text(message1),
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

  static void showVelocityToast(String message1,context) {
    VxToast.show(context, msg: message1,
        bgColor: MyColors.appBlack,
        textColor: MyColors.appWhite,
        position
            :VxToastPosition.center);
  }

  void _showSuccessDialog(String message,BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Okay'),
              onPressed: () {
                // setState(() {
                //   isSubmitting = false;
                // });
                // Navigator.of(ctx).pop();
                // clearControlers();
              },
            )
          ],
        ));
  }



}
