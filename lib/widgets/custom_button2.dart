import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';

class CustomButton2 extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final Color? color;
  final Color? colorText;

  const CustomButton2(
      {Key? key, this.onTap, this.text, this.color, this.colorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // VxBox(child: Text(text??"").centered()).linearGradient([MyColors.pinkMy,MyColors.yellowMy]).make().onTap(onTap).b,
          TextButton(
            onPressed: onTap,
            child: Container(

              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(


                  color: MyColors.appBlack,
                  borderRadius: BorderRadius.circular(45),
                  border: Border.all(
                    color: MyColors.appBlack,
                  )),
              alignment: Alignment.center,

              child: Text(
                text ?? "aaa",
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
