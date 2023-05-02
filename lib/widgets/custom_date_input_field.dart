import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';

class CustomDateInputField extends StatelessWidget {
  final TextEditingController? controller;
  final Function saveDateFuncForApi;
  final String? labelText;
  final bool isReadOnly;

  CustomDateInputField({

    super.key,
    this.controller,
    required this.saveDateFuncForApi,
    this.isReadOnly = true,
    this.labelText,
    // required this.saveDate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,

      controller: controller,
      // validator: validator,
//editing controller of this TextField
      decoration: InputDecoration(

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 1, color: MyColors.appBlack),
          ),
          contentPadding: EdgeInsets.only(left: 10.0),
          suffixIcon: Icon((Icons.calendar_month), color: MyColors.appBlack),
          labelStyle: TextStyle(color: MyColors.appBlack),
          // icon: Icon(Icons.calendar_today), //icon of text field
          labelText: labelText == null
              ? "Select The Date *"
              : labelText //label text of field
          ),

//set it true, so that user will not able to edit text
      onTap:isReadOnly ? null : () async {
        DateTime? pickedDate = await showDatePicker(

            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
//DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          String formattedDateforApi =
              DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDateforApi);

            saveDateFuncForApi!(formattedDateforApi);


          //formatted date output using intl package =>  2021-03-16

          controller?.text =
              formattedDate; //set output date to TextField value.
        } else {}
      },
    );
  }
}
