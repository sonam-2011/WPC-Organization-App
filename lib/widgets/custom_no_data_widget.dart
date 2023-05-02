import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomNoDataWidget extends StatelessWidget {
  final String? imageString;
  final String ?text;
  const CustomNoDataWidget({
    super.key, required this.imageString,  this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(imageString!),),
            SizedBox(
              height: context.percentHeight * 2,

            ),
            Text(text??""),
          ],
        ));
  }
}