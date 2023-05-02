import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/provider/shared_pref_provider.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/models/add_lined_up.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/models/assign_ticker_resp.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/screens/ticket_screen_3.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../api/api_client.dart';
import '../constants/app_strings.dart';
import '../constants/colors.dart';
import '../models/job_category.dart';
import '../models/member_info.dart';
import '../models/response/industry_type.dart';
import '../models/response/registered_user_details.dart';
import '../routes.dart';
import '../ui/appdrawer_options/add_member/custom_model_dropdown_itm.dart';
import '../ui/appdrawer_options/member_hierarchy/model/reporting_member.dart';
import '../ui/appdrawer_options/member_hierarchy/screen/detail_screen.dart';
import '../ui/appdrawer_options/member_hierarchy/widgets/meber_ticket_list_2.dart';
import '../ui/appdrawer_options/tickets/models/ticket.dart';
import '../widgets/dialogs.dart';

class TicketUpdateLineUpProvider extends ChangeNotifier {
  bool isUpdating = false;
  bool isloadinglist = false;
  List<AddLineUp> lineUpComList = [];

  bool get getisUpdating => isUpdating;

  bool get getisloadinglist => isloadinglist;

  void onPop(){
    lineUpComList=[];
    notifyListeners();
  }

  Future<void> getLineUpList({required int rfId}) async {
    try {
      isloadinglist = true;
      notifyListeners();

      List<AddLineUp> lineUpCompList =
          await ApiClient.lineUpCompList(rfId: rfId);
      if (lineUpCompList!.isNotEmpty) {
        lineUpComList = lineUpCompList;
      }

      isloadinglist = false;
      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

  Future<void> updateTicket(
      {required Ticket ticket, required BuildContext context, required String path,ReportingMember ? member}  ) async {
    try {
      isUpdating = true;
      notifyListeners();

      final message = await ApiClient.editticket(ticket: ticket);
      print(message);
      final close = context.showLoading(
          textColor: MyColors.appWhite, msg: "Updating Ticket");
      await Future.delayed(2.seconds, close as FutureOr Function()?);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      RegisteredUserDetails? userDetails;

      userDetails =
          Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
      if(path !="Member"){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return TicketScreen3(userDetails: userDetails);
        }));

      }else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailScreen(member: member!,);
        }));

      }

      // getProfileInfoFunc();
      Dialogs.showVelocityToast("Updated SuccessFully", context);
      // Dialogs.showVelocityToast(message, context);

      isUpdating = false;
      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

  Future<void> addLineUpDetails(
      {required AddLineUp lineUp, required BuildContext context}) async {
    try {
      isUpdating = true;
      notifyListeners();

      final message = await ApiClient.addLineUpDetails(lineUp: lineUp);
      print("response");
      print(message);
      final close = context.showLoading(
          textColor: MyColors.appWhite, msg: "Adding Details");
      await Future.delayed(2.seconds, close as FutureOr Function()?);
      lineUpComList=[];
      getLineUpList(rfId: int.parse(lineUp.rfId??""));
      notifyListeners();
      Navigator.of(context).pop();
      VxToast.show(context, msg: "Added successfully!",textColor:MyColors.appWhite,bgColor: MyColors.appBlack);


      // Navigator.of(context).pop();
      // RegisteredUserDetails? userDetails;
      //
      // userDetails =
      //     Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //   return TicketScreen3(userDetails: userDetails);
      // }));
      // // getProfileInfoFunc();
      // Dialogs.showVelocityToast("Updated SuccessFully", context);
      // // Dialogs.showVelocityToast(message, context);

      isUpdating = false;
      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }


  Future<void> editLineUpDetails(
      {required AddLineUp lineUp, required BuildContext context}) async {
    try {
      isUpdating = true;
      notifyListeners();

      final message = await ApiClient.editLineUpDetails(lineup: lineUp);
      print("response");
      print(message);
      final close = context.showLoading(
          textColor: MyColors.appWhite, msg: " Updating Details");
      await Future.delayed(2.seconds, close as FutureOr Function()?);
      lineUpComList=[];
      getLineUpList(rfId: int.parse(lineUp.rfId??""));
      notifyListeners();
      Navigator.of(context).pop();
      VxToast.show(context, msg: "Updated successfully!",textColor:MyColors.appWhite,bgColor: MyColors.appBlack);


      // Navigator.of(context).pop();
      // RegisteredUserDetails? userDetails;
      //
      // userDetails =
      //     Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //   return TicketScreen3(userDetails: userDetails);
      // }));
      // // getProfileInfoFunc();
      // Dialogs.showVelocityToast("Updated SuccessFully", context);
      // // Dialogs.showVelocityToast(message, context);

      isUpdating = false;
      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

// Future<void> updateLineUpDetails(
//     {required AddLineUp lineUp, required BuildContext context}) async {
//   try {
//     isUpdating = true;
//     notifyListeners();
//
//     final message = await ApiClient.editticket(ticket: ticket);
//     print(message);
//     final close = context.showLoading(
//         textColor: MyColors.appWhite, msg: "Updating Ticket");
//     await Future.delayed(2.seconds, close as FutureOr Function()?);
//     Navigator.of(context).pop();
//     Navigator.of(context).pop();
//     RegisteredUserDetails? userDetails;
//
//     userDetails =
//         Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//       return TicketScreen3(userDetails: userDetails);
//     }));
//     // getProfileInfoFunc();
//     Dialogs.showVelocityToast("Updated SuccessFully", context);
//     // Dialogs.showVelocityToast(message, context);
//
//     isUpdating = false;
//     notifyListeners();
//   } catch (e) {
//     print("Could not call Api");
//     log(e.toString());
//     rethrow;
//   }
// }
}
