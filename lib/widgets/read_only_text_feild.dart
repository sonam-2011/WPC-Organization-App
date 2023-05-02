import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer_internal_app/widgets/validators.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';

class ReadOnlyTextField extends StatelessWidget {
  final String? text;
  final FormFieldValidator<String> validator;
  final bool? isNumeric;


  final IconData? assets;
  final TextEditingController? controller;
  final int maxLines;
  final bool isReadOnly;

  const ReadOnlyTextField({
    this.validator = Validators.validateTEmpty,
    Key? key,
    this.text,
    this.assets,
    this.controller,
    this.maxLines = 1,
    this.isReadOnly = true, this.isNumeric=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      // enabled: false,
      readOnly: isReadOnly,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onFieldSubmitted: (val) {
        print("on onFieldSubmitted executed");
      },
      onEditingComplete: () {
        print("on editing executed");
      },
      keyboardType: isNumeric! ? TextInputType.number : TextInputType.text,
      style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          // fontFamily: Fonts.robotoRegular,
          fontWeight: FontWeight.normal),
      // cursorHeight: 18,
      // style: const TextStyle(
      //     fontSize: 16,
      //     color: Colors.black,
      //     // fontFamily: Fonts.robotoRegular,
      //     fontWeight: FontWeight.bold),

      controller: controller,

      textAlign: TextAlign.start,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1, color: MyColors.appBlack),
        ),

        errorStyle: MyTextStyle.errorTextStyle,
        // prefixIcon: ,
        label: Text(text ?? "no label"),
        // hintText: text,
        labelStyle: MyTextStyle.labelText,
        contentPadding: const EdgeInsets.only(left: 10.0),
        hintStyle: MyTextStyle.hintTextStyle,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 2,
          minHeight: 2,
        ),

        suffixIconColor: Colors.deepOrange,

        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(assets, color: Colors.grey.shade500),
        ),
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.only(right: 10),
        //   child: Icon(prefixAsset, color: Colors.grey.shade500),
        // ),
      ),
    );
  }
}
