import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../constants/text_style.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;

  const CustomTextButton({Key? key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(text ?? "",
          textAlign: TextAlign.center, style: MyTextStyle.buttonText),
    );
  }
}
