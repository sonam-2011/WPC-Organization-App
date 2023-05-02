

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/api/api_client.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/pay_now/model/detailed_payment.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_style.dart';

class PaymentDetailScreen extends StatefulWidget {
  final int rfId;

  const PaymentDetailScreen({Key? key, required this.rfId, }) : super(key: key);

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  bool isLoaded=false;

    List<DetailedPayment>  data=[];
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    // rfId = widget.ticket.rfId;
  }


  void _loadData() async {
    print("rfid");
    print(widget.rfId);
    data = await ApiClient.usrPaymentDetail(rf_id: widget.rfId.toString());
    setState(() {
      isLoaded=true;

    });

  }

  Card buildCard(DetailedPayment data) {
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
              customRom(label: "User Upi Id : ", value: data.upiId.toString()??"",),
              SizedBox(height: 5,),
              customRom(label: "Manager Id : ", value: data.managerId.toString()??"",),
              SizedBox(height: 5,),
              customRom(label: "Transaction Id : ", value: data.trnsctnId??"",),
              SizedBox(height: 5,),
              customRom(label: "Amount: ", value: data.amt??"",),
              // SizedBox(height: 5,),
              // customRom(label: "Status : ", value: data.internalSts??"",),
              SizedBox(height: 5,),
              customRom(label: "Remark : ", value: data.remark??"",),



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

              itemCount: data?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {

                  DetailedPayment item = data![index];
                  return buildCard(item);
             }),
        ],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: isLoaded ?  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              buildListView()
            ],
          ),
        ),
      ):Center(
        child: CircularProgressIndicator(color: MyColors.appBlack,),
      )
    );
  }
}
