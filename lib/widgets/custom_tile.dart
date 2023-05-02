import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/member_hierarchy/model/reporting_member.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';
import '../ui/appdrawer_options/member_hierarchy/screen/detail_screen.dart';

class CustomTile extends StatelessWidget {
  CustomTile({Key? key,  this.member}) : super(key: key);

  final ReportingMember ? member;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(member: member)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
        child: Card(
            color: MyColors.tileColor,
            elevation: 10,
            child: ListTile(
              title: Text(
                member?.mmbrName ?? "",
                style: MyTextStyle.customListtileStyleTitle,
              ),
              subtitle: Text(
                member?.mmbrRole.toString() ?? "",
                style: MyTextStyle.customListtileStyleSubTitle,
              ),
              trailing: Text(
                member?.mmbrMob ?? "",
                style: MyTextStyle.customListtileStyleTrailing,
              ),
            )),
      ),
    );
  }
}
