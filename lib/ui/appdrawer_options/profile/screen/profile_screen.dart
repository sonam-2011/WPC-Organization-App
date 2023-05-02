import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/models/response/registered_user_details.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/member_hierarchy/model/reporting_member.dart';

import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../constants/app_strings.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/text_style.dart';
import '../../../../provider/member_hierarchy_list_provider.dart';
import '../../../../widgets/custom_no_data_widget.dart';
import '../../../../widgets/custom_tile.dart';

class ProfileScreen extends StatelessWidget {
  final RegisteredUserDetails?  userDetails;

  ProfileScreen({Key? key, required this.userDetails,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("in build of mem hei screen");

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Profile",
            ),

            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            elevation: 0,
            // leading: IconButton(onPressed: () {  }, icon: Icon(Icons.arrow_back_ios,)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                color: MyColors.appBlack,
                child: Column(
                  children: [
                    SizedBox(
                        height:20
                    ),
                    customRom(label: "Name :", value: userDetails?.username??""),
                    customRom(label:  "Mobile : ", value: userDetails?.mobile??""),
                    customRom(label: "Role : ", value: userDetails?.role??""),
                    customRom(label: "Reporter Name : ", value: userDetails?.reporterName??""),
                    customRom(label: "Reporter Mobile : ", value: userDetails?.reporterMob??""),
                    customRom(label: "Zone : ", value: userDetails?.zone??""),
                    customRom(label: "Location : ", value: userDetails?.location??""),


                  ],
                ),
              ),
            ),
          )),
    );
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
                  height:10
              ),
              Text(
                label,
                style: MyTextStyle.profileScreenTextStyle,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                value.toUpperCase(),
                style: MyTextStyle.profileScreenTextStyle,
              ),

            ],
          ),
          SizedBox(
              height:10
          ),
        ],
      ),
    );
  }
}

