import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/member_hierarchy/model/reporting_member.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_style.dart';
import '../models/ticket.dart';
import '../screens/ticket_detail_update_screen.dart';



class CustomTicketLineUpTile extends StatelessWidget {

  CustomTicketLineUpTile({Key? key, required this.title, required this.subTitle, required this.trailing,  this.ticket,  }) : super(key: key);

  final String title;
  final Ticket  ? ticket;
  final String subTitle;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
      child: Card(
          color: MyColors.tileColor,
          elevation: 10,
          child: ListTile(
            title: Text(
              title,
              style: MyTextStyle.customListtileStyleTitle,
            ),
            subtitle: Text(
              subTitle,
              style: MyTextStyle.customListtileStyleSubTitle,
            ),
            trailing: Text(
              trailing,
              style: MyTextStyle.customListtileStyleTrailing,
            ),
          )),
    );
  }
}
