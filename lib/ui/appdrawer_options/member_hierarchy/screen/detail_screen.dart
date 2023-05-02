import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/constants/colors.dart';
import 'package:freelancer_internal_app/constants/text_style.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/member_hierarchy/model/reporting_member.dart';
import 'package:freelancer_internal_app/widgets/custom_button2.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../../constants/app_strings.dart';
import '../../../../provider/member_hierarchy_list_provider.dart';
import '../../../../routes.dart';
import '../../../../widgets/read_only_text_feild.dart';
import '../widgets/meber_ticket_list_2.dart';

import 'member_hierarchy_screen.dart';

class DetailScreen extends StatelessWidget {
  final ReportingMember? member;

  DetailScreen({Key? key,  this.member}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Candidate's Details")),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 5),

            children: [
              // Container(height: context.percentHeight * 8,color: MyColors.blackMy, ),
              SizedBox(
                height:10
              ),
              Row(
                children: [
                  Text(
                    "Name : ",
                    style: MyTextStyle.detailScreenTextStle1,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    member?.mmbrName?.toUpperCase() ?? "",
                    style: MyTextStyle.detailScreenTextStle2,
                  ),
                ],
              ),
              SizedBox(
                height: context.percentHeight * 2,
              ),
              Row(
                children: [
                  Text(
                    "Mobile : ",
                    style: MyTextStyle.detailScreenTextStle1,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    member?.mmbrMob?.toUpperCase() ?? "",
                    style: MyTextStyle.detailScreenTextStle2,
                  ),
                ],
              ),
              SizedBox(
                height: context.percentHeight * 2,
              ),
              Row(
                children: [
                  Text(
                    "Role : ",
                    style: MyTextStyle.detailScreenTextStle1,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    member?.mmbrRole?.toUpperCase() ?? "",
                    style: MyTextStyle.detailScreenTextStle2,
                  ),
                ],
              ),
              SizedBox(
                height: context.percentHeight * 2,
              ),
              Row(
                children: [
                  Text(
                    "Zone : ",
                    style: MyTextStyle.detailScreenTextStle1,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    member?.mmbrZone?.toUpperCase() ?? "",
                    style: MyTextStyle.detailScreenTextStle2,
                  ),
                ],
              ),
              SizedBox(
                height: context.percentHeight * 2,
              ),
              Row(
                children: [
                  Text(
                    "Employee Id : ",
                    style: MyTextStyle.detailScreenTextStle1,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    member?.mmbrEmpId ?? "",
                    style: MyTextStyle.detailScreenTextStle2,
                  ),
                ],
              ),
              SizedBox(
                height: context.percentHeight * 2,
              ),
              Row(
                children: [
                  Text(
                    "Location : ",
                    style: MyTextStyle.detailScreenTextStle1,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    member?.mmbrLocation?.toUpperCase() ?? "",
                    style: MyTextStyle.detailScreenTextStle2,
                  ),
                ],
              ),
              SizedBox(
                height: context.percentHeight * 2,
              ),
              if (member?.mmbrRole != "HR")
                CustomButton2(
                    text: "Click Here To See Reporting Persons",
                    onTap: () async {
                      print("before");
                      await Provider.of<MemberHierarchyListProvider>(context, listen: false)
                          .getReportingMembersList2(context, member!);
                      print("after");

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return MemberHierarchyScreen(memRole: member?.mmbrRole ?? "");
                      }));
                    }),
              SizedBox(
                width: 20,
              ),
              if(member!=null) Expanded(
                      child: MemberTicketList2(member: member!,))


            ]
          ),
        ),
      ),
    );
  }
}
