import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/api/api_client.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/pay_now/model/payment.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/pay_now/screen/payment_detail_screen.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/pay_now/screen/payment_form_screen.dart';
import 'package:freelancer_internal_app/ui/dashboard_screen/dashboard.dart';
import 'package:freelancer_internal_app/widgets/custom_button2.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_style.dart';
import '../../../../widgets/custom_dropdown_formFeild.dart';

class PayNowScreen extends StatefulWidget {
  const PayNowScreen({Key? key}) : super(key: key);

  @override
  State<PayNowScreen> createState() => _PayNowScreenState();
}

class _PayNowScreenState extends State<PayNowScreen> {
  final TextEditingController value = TextEditingController();
  List<Payment> list = [];

  bool isSelcted = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomDropDownFormButton(
                selectedOptionController: value,
                isReadOnly: false,
                text: "Select The Option",
                items: const [
                  "Paid",
                  "UnPaid",
                ],
                optionalFunction: (c) {
                  if (c != null) {
                    setState(() {
                      isSelcted = true;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              if (isSelcted && !isLoading)
                CustomButton2(
                  text: "Submit",
                  onTap: submt,
                ),
              if (isLoading) buildContainer(),
              const SizedBox(
                height: 10,
              ),
              buildListView()
            ],
          ),
        ),
      ),
    );
  }

  Column buildListView() {
    return Column(
      children: [
        //
        // Text(
        //   "List",
        //   style: MyTextStyle.formSubHeadingStyle,
        // ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),

            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (list.length > 0) {
                Payment data = list[index];
                return GestureDetector(
                  onTap: (){
                    if(value.text.toUpperCase() =="PAID"){
                      print("rfid");
                      print(data.rfId);

                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return PaymentDetailScreen(rfId: data.rfId??0,);
                      }));
                      
                    }
                    else{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return PaymentFormScreen(data: data,);
                      }));
                    }
                  },
                    child: buildCard(data));
              } else if (list.length == 0) {
                return Text("No List");
              }
            }),
      ],
    );
  }

  Card buildCard(Payment data) {
    return Card(
                color: MyColors.appBlack,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                    child: Column(
                children: [
                  SizedBox(height: 5,),

                  customRom(label: "Ticket Id : ", value: data.rfId.toString()??"",),
                    SizedBox(height: 5,),
                    customRom(label: "Mobile : ", value: data.usrMob??"",),
                    SizedBox(height: 5,),
                    customRom(label: "User Upi Id : ", value: data.usrUpi??"",),
                    SizedBox(height: 5,),
                    customRom(label: "Status : ", value: data.internalSts??"",),
                    SizedBox(height: 5,),
                    customRom(label: "Remark : ", value: data.rfRemark??"",),



                ],
              ),
                  ));
  }

  Widget customRom({
    required String label,required String value,
  }){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  height:5
              ),
              Text(
                label,
                style: MyTextStyle.paymentScreenListTileTextStyle,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  value,
                  style: MyTextStyle.paymentScreenListTileTextStyle,
                ),
              ),

            ],
          ),
          SizedBox(
              height:5
          ),
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

  submt() async {
    try {
      setState(() {
        isLoading = true;
      });
      list =
          await ApiClient.paidUnpaidList(payment_sts: value.text.toUpperCase());
    } catch (e) {
      _showErrorDialog();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
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
}
