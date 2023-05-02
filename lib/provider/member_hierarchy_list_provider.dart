import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/provider/shared_pref_provider.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/member_hierarchy/model/reporting_member.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../models/response/registered_user_details.dart';
import '../shared_preferences_data.dart';
import '../ui/appdrawer_options/tickets/models/ticket.dart';

class MemberHierarchyListProvider extends ChangeNotifier {
  List<ReportingMember>? reportingZonalMangers = [];
  List<ReportingMember>? reportingMangers = [];
  List<ReportingMember>? reportingTl = [];
  List<ReportingMember>? reportingHrs = [];
  List<ReportingMember>? memSearched = [];
  bool isloading = false;
  bool isSearching = false;
  bool isloadTotalTicket = false;
  bool get getIsloadTotalTicket => isloadTotalTicket;
  String totalNumOfTickets = "";
  String get getTotalNumOfTickets => totalNumOfTickets;

  RegisteredUserDetails? userDetails;
  Future<void> gettotalNumOftickets({required String? mmbr_id}) async {
    try {
      isloadTotalTicket = true;
      notifyListeners();
      print("user id");
      print(userDetails?.id);
      final response  = await ApiClient.totalNumOfTickets(mmbr_id: mmbr_id);
      print("pri niting response");
      print(response);

      totalNumOfTickets = response.toString();

      isloadTotalTicket = false;
      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      // rethrow;
    }
  }

  //parameters for tickets list by pagination
  // final ScrollController scrollContr = ScrollController();
  bool loadingMoreAssignedTickets = false;
  bool firstLoad = false;
  bool alloadedAssignedTickets = false;
  int pageNo = 1;
  List<Ticket> tickesList = [];
  bool get getfirstLoad => firstLoad;

  List<Ticket> get getTickesList => tickesList;

  fetchInitiallyAssignedTickets({
    required String userId
}) async {
    // isSearching = false;
    firstLoad = true;
    notifyListeners();
    try {
      List<Ticket> ticketsFetched = await ApiClient.ticketsList(
          parentId: userId, pageNo: pageNo.toString());

      if (ticketsFetched.isNotEmpty) {
        tickesList.addAll(ticketsFetched);
      }

      print(pageNo);
      print("page no");
      print(tickesList.length);
      print("tickets.lengt");
      print(ticketsFetched.length);
      print("ticketsFetched.length");

      firstLoad = false;
      pageNo = pageNo + 1;

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  fetchAssignedTickets(BuildContext context) async {
    if (alloadedAssignedTickets) {
      print("isallowed");
      print(alloadedAssignedTickets);
      return;
    }
    // isSearching = false;
    loadingMoreAssignedTickets = true;
    notifyListeners();
    try {
      List<Ticket> ticketsFetched = await ApiClient.ticketsList(
          parentId: userDetails?.id.toString(), pageNo: pageNo.toString());

      if (ticketsFetched.isNotEmpty) {
        tickesList.addAll(ticketsFetched);
      }

      print(pageNo);
      print("page no");
      print(tickesList.length);
      print("tickets.lengt");
      print(ticketsFetched.length);
      print("ticketsFetched.length");

      isloading = false;
      alloadedAssignedTickets = ticketsFetched.isEmpty;
      notifyListeners();
      pageNo = pageNo + 1;
    } catch (e) {
      throw e;
    }
  }

  // Future<List<Ticket>> getTickList(
  //     {required BuildContext context, required String pageNo}) async {
  //   try {
  //     userDetails =
  //         Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
  //
  //     print(pageNo);
  //
  //     final response = await ApiClient.ticketsList(
  //         parentId: userDetails?.id.toString(), pageNo: pageNo);
  //
  //     return response;
  //   } catch (e) {
  //     print("Could not call Api");
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

  List<ReportingMember>? get getreportingZonalManagersList =>
      reportingZonalMangers;

  List<ReportingMember>? get getreportingMangersList => reportingMangers;

  List<ReportingMember>? get getmemSearched => memSearched;

  List<ReportingMember>? get getreportingTlList => reportingTl;

  List<ReportingMember>? get getreportingHrsList => reportingHrs;

  bool get getIsSeacrhing => isSearching;

  clearMemSearList() {
    isSearching = false;
    memSearched = [];
    notifyListeners();
  }

  search(String memRole, String userInput) {
    isSearching = true;
    notifyListeners();
    memSearched = [];

    if (memRole == "Zonal Manager") {
      memSearched = reportingMangers?.where((mem) {
        final String? nameLower = mem.mmbrName?.toLowerCase();

        return ((nameLower!.contains(userInput.toLowerCase())));
      }).toList();
      notifyListeners();
    } else if (memRole == "Manager") {
      memSearched = reportingTl?.where((mem) {
        final String? nameLower = mem.mmbrName?.toLowerCase();

        return ((nameLower!.contains(userInput.toLowerCase())));
      }).toList();
      notifyListeners();
    } else if (memRole == "Team Lead") {
      memSearched = reportingHrs?.where((mem) {
        final String? nameLower = mem.mmbrName?.toLowerCase();

        return ((nameLower!.contains(userInput.toLowerCase())));
      }).toList();
      notifyListeners();
    } else {
      memSearched = reportingZonalMangers?.where((mem) {
        final String? nameLower = mem.mmbrName?.toLowerCase();

        return ((nameLower!.contains(userInput.toLowerCase())));
      }).toList();
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> getReportingMembersList(BuildContext context) async {
    try {
      isSearching = false;
      isloading = true;
      notifyListeners();
      userDetails =
          Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
      print(userDetails?.empId);
      print(userDetails?.role);
      notifyListeners();

      final response = await ApiClient.memberLstByParentId(
          parentId: userDetails?.id.toString());

      String? loginUserRole = userDetails?.role;

      if (loginUserRole == "Zonal Manager") {
        reportingMangers = response;
        notifyListeners();
      } else if (loginUserRole == "Manager") {
        reportingTl = response;
        notifyListeners();
      } else if (loginUserRole == "Team Lead") {
        reportingHrs = response;
        notifyListeners();
      } else if (loginUserRole == "Admin" || loginUserRole == "ADMIN") {
        print("filling zonal manager");
        reportingZonalMangers = response;
        notifyListeners();
      }

      isloading = false;
      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

  Future<void> getReportingMembersList2(
      BuildContext context, ReportingMember mem) async {
    RegisteredUserDetails? userDetails;

    try {
      // String repRole;
      // // isloading2 = true;
      // // notifyListeners();
      // if (mem.mmbrRole == " Zonal Manager") {
      //   repRole = "Manager";
      // } else if (mem.mmbrRole == "Manager") {
      //   repRole = "Team Lead";
      // } else if (mem.mmbrRole == "Team Lead") {
      //   repRole = "Hr";
      // }
      isSearching = false;
      isloading = true;
      notifyListeners();
      final response =
          await ApiClient.memberLstByParentId(parentId: mem.mmbrId.toString());
      if (mem.mmbrRole == "Zonal Manager") {
        reportingMangers = response;
      } else if (mem.mmbrRole == "Manager") {
        reportingTl = response;
      } else if (mem.mmbrRole == "Team Lead") {
        reportingHrs = response;
      }
      isloading = false;
      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }
}
