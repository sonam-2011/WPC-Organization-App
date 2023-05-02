import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/widgets/validators.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';
import '../ui/appdrawer_options/add_member/custom_model_dropdown_itm.dart';

class CustomDropDownFormButton extends StatefulWidget {
  final String? text;
  final String? dropDownIntialVAlue;

  final List<String>? items;
  final TextEditingController? selectedOptionController;
  final String? Function(String?)? validator;
  final Function(String?)? optionalFunction;
  final bool isReadOnly;

  const CustomDropDownFormButton({
    Key? key,
    this.text,
    this.items,
    this.selectedOptionController,
    this.validator,
    this.isReadOnly = true,
    this.optionalFunction,
    this.dropDownIntialVAlue,
  }) : super(key: key);

  @override
  State<CustomDropDownFormButton> createState() =>
      _CustomDropDownFormButtonState();
}

class _CustomDropDownFormButtonState extends State<CustomDropDownFormButton> {
  String? selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // candidates = loadList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: widget.validator,

      // validator: Validators.validateEmpty,
      isExpanded: true,
      //helped to avoid pixel issue
      onSaved: (selectedOption) {
        widget.selectedOptionController?.text = selectedOption ?? "";
        // setState(() {
        //
        // });
      },

      decoration: InputDecoration(

        // label: Text("select the job2 " ?? "no label"),
        // hintText: text,
        labelStyle: MyTextStyle.labelText,
        labelText: widget.text,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1,color: MyColors.appBlack),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1,color: MyColors.appBlack),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: MyTextStyle.errorTextStyle,
        border: OutlineInputBorder(

          borderSide: BorderSide(width: 1,color: MyColors.appBlack),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        // fillColor: Colors.blueAccent,
      ),

      dropdownColor: MyColors.appWhite,
      value: widget.dropDownIntialVAlue,
      onTap: () {
        print("on tap executed");
      },
      onChanged: widget.isReadOnly
          ? null
          : (String? newValue) {
              print("on changed executed");
              setState(() {
                selectedValue = newValue!;
                widget.selectedOptionController?.text = newValue ?? "";
                if (widget.optionalFunction != null) {
                  widget.optionalFunction!(newValue);
                }
              });
            },
      items: widget.items?.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    items,
                    style: TextStyle(color: MyColors.appBlack),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CustomDropDownFormButton2 extends StatefulWidget {
  final String? text;
  final List<CustoMDropDownMenuItem>? items;
  final TextEditingController? selectedOptionController;
  final String? Function(String?)? validator;
  final Function(dynamic?)? optionalFunction;

  const CustomDropDownFormButton2(
      {Key? key,
      this.text,
      this.items,
      this.selectedOptionController,
      required this.validator,
      this.optionalFunction})
      : super(key: key);

  @override
  State<CustomDropDownFormButton2> createState() =>
      _CustomDropDownFormButtonState2();
}

class _CustomDropDownFormButtonState2 extends State<CustomDropDownFormButton2> {
  CustoMDropDownMenuItem? selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // candidates = loadList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CustoMDropDownMenuItem>(
      // validator: widget.validator,

      // validator: Validators.validateEmpty,
      isExpanded: true,
      //helped to avoid pixel issue
      onSaved: (selectedOption) {
        // widget.selectedOptionController?.text = selectedOption ?? "";
        // setState(() {
        //
        // });
      },

      decoration: InputDecoration(
        // label: Text("select the job2 " ?? "no label"),
        // hintText: text,
        labelStyle: MyTextStyle.labelText,
        labelText: widget.text,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: MyTextStyle.errorTextStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: false,
        // fillColor: Colors.blueAccent,
      ),

      dropdownColor: MyColors.appWhite,
      value: selectedValue,
      onTap: () {
        print("on tap executed");
      },
      onChanged: (CustoMDropDownMenuItem? newValue) {
        print("on changed executed");
        setState(() {
          selectedValue = newValue;
          widget.selectedOptionController?.text = newValue?.memId ?? "";
          if (widget.optionalFunction != null) {
            widget.optionalFunction!(newValue);
          }
        });
      },
      items: widget.items?.map((CustoMDropDownMenuItem items) {
        return DropdownMenuItem(
          value: items,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    items.memName,
                    style: TextStyle(color: MyColors.appBlack),
                  ),
                ),
                Text(
                  items.empId,
                  style: TextStyle(color: MyColors.appBlack),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
