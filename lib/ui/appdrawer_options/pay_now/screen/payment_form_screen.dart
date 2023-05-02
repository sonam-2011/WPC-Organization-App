import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/widgets/custom_button2.dart';
import 'package:freelancer_internal_app/widgets/validators.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../api/api_client.dart';
import '../../../../constants/app_strings.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/text_style.dart';
import '../../../../models/response/registered_user_details.dart';
import '../../../../provider/shared_pref_provider.dart';
import '../../../../routes.dart';
import '../../../../widgets/read_only_text_feild.dart';
import '../model/payment.dart';

class PaymentFormScreen extends StatefulWidget {
  final Payment data;

  const PaymentFormScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<PaymentFormScreen> createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends State<PaymentFormScreen> {
  GlobalKey<FormState>? formKey;
  TextEditingController transId = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController amt = TextEditingController();

  bool isSubmitting = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    // rfId = widget.ticket.rfId;
  }

  SingleChildScrollView buildPaymentForm() {
    return SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: const [
            //     Text(
            //       "Details",
            //       style: MyTextStyle.subHeadings,
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: context.percentHeight * 2,
            // ),
            ReadOnlyTextField(
              validator: Validators.validateEmpty,
              isReadOnly: false,
              // assets: Icons.person,
              controller: transId,
              text: AppStrings.transactionId,
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
              validator: Validators.validateEmpty,

              isReadOnly: false,

              // assets: Icons.phone,
              controller: amt,
              text: AppStrings.amount,
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
              isReadOnly: false,

              // assets: Icons.phone,
              controller: remark,
              text: AppStrings.remark,
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Details"),
      ),
      body: Column(
        children: [
          buildPaymentForm(),
          SizedBox(
            height: 10,
          ),
          if (!isSubmitting)CustomButton2(
            text: "Submit",
            onTap: submit,
          ),
          // if (isSubmitting) buildContainer(),
        ],
      ),
    );
  }


  Container buildContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: MyColors.appBlack,
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
            color: MyColors.appBlack,
          )),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text(
            "Please Wait",
            textAlign: TextAlign.center,
            style: MyTextStyle.customButton2Text,
          ),
        ],
      ),
    );
  }


  void _showErrorDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: const Text('An Error Occurred '),
            content: const Text('Try Again Later'),
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

  submit() async {
    if (!formKey!.currentState!.validate()) {
      return;
    }

    formKey?.currentState!.save();
    try {

      setState(() {
        isSubmitting = true;
      });

      RegisteredUserDetails? userDetails;
      await Provider.of<ShraredPrefProvider>(context, listen: false).readSharedData();
      userDetails = Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
      print("details");

      print(userDetails?.id.toString());
      print(transId.text);
      print(amt.text);
      print(remark.text);
      print(widget.data.usrUpi);
      print(widget.data.usrId);
      print(widget.data.rfId);

     final message =  await ApiClient.payUsr(usr_id: widget.data.usrId.toString(),
          upi_id: widget.data.usrUpi,
          manager_id
          :userDetails?.id.toString(),
          trns_id: transId.text,
          amount: amt.text,
          remark: remark.text,
          rf_id: widget.data.rfId.toString());

      final close = context.showLoading(
          textColor: MyColors.appWhite, msg: "Please Wait");
      await Future.delayed(2.seconds, close as FutureOr Function()?);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      // Navigator.of(context).pop();





        Navigator.of(context).pushNamed(Routes.payNow);


    } catch (e) {
      _showErrorDialog();
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }
}
