import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/constants/colors.dart';

import '../constants/app_strings.dart';
import 'constants/text_style.dart';

class HelperFunctions {
  HelperFunctions._();

  static void snackBarFunc(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 3000),
      ),
    );
  }

  static void dialog(
      {required String title,
      required String content,
      required String buttonTitle,
      required Function()? onPressed,
      required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: Container(
              decoration: BoxDecoration(
                  color: MyColors.appBlack,
                  border: Border.all(
                    color: MyColors.appBlack,
                  )),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(14),
              child: Text(
                buttonTitle,
                textAlign: TextAlign.center,
                style: MyTextStyle.customButton2Text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
