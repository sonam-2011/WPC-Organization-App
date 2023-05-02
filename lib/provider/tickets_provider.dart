import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/provider/shared_pref_provider.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/models/assign_ticker_resp.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../constants/app_strings.dart';
import '../models/job_category.dart';
import '../models/member_info.dart';
import '../models/response/industry_type.dart';
import '../models/response/registered_user_details.dart';
import '../ui/appdrawer_options/add_member/custom_model_dropdown_itm.dart';
import '../ui/appdrawer_options/tickets/models/ticket.dart';

class TicketProvider extends ChangeNotifier {
  List<Ticket> tickets = [];
  List<Ticket>? ticketSearched = [];
  List<CustoMDropDownMenuItem> listOfAssign = [];
  List<MemberInfo> listOfMemberAssign = [];
  List<String>? jobCategoriesNAmes = [];
  RegisteredUserDetails? userDetails;
  List<JobCategory> _jobCategories = [];
  List<IndustryType> _industries = [];
  List<String>? industriesNames = [];
  String totalNumOfTickets = "";
  String get getTotalNumOfTickets => totalNumOfTickets;

  bool isloading = false;
  bool isloadingJoblist = false;
  bool isloadTotalTicket = false;
  bool get getIsloadTotalTicket => isloadTotalTicket;

  bool isSearching = false;
  bool allLoaded = false;
  int pageNo = 1;

  List<String>? get getJobsList => jobCategoriesNAmes;



  List<Ticket> get getTickets => tickets;

  List<CustoMDropDownMenuItem> get getTicketAssingList => listOfAssign;

  List<MemberInfo> get getTicketAssingMemberList => listOfMemberAssign;

  List<Ticket>? get getSearchedTickets => ticketSearched;

  List<String>? get getIndustriesListNames => industriesNames;

  bool get getIsSeacrhing => isSearching;

  bool get getIsloading => isloading;

  Future<void> getIndustriesList() async {
    try {
      final industriesList =
          await ApiClient.industries(key: AppStrings.keyValue);
      if (industriesList!.isNotEmpty) {
        _industries = industriesList;
      }

      industriesNames = _industries.map((e) {
        return e.IndName ?? "";
      }).toList();
      // print(jobCategoriesNAmes);

      isloading = false;
      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

  Future<void> getJobCategoryList() async {
    try {
      isloadingJoblist = true;
      notifyListeners();

      final jobCategoryList =
          await ApiClient.jobCategory(key: AppStrings.keyValue);
      if (jobCategoryList!.isNotEmpty) {
        _jobCategories = jobCategoryList;
      }

      jobCategoriesNAmes = _jobCategories.map((e) {
        return e.catName ?? "";
      }).toList();
      // print(jobCategoriesNAmes);

      isloadingJoblist = false;
      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

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

  clearMemSearList() {
    isSearching = false;
    ticketSearched = [];
    notifyListeners();
  }

  clearOnPop() {
    isSearching = false;
    ticketSearched = [];
    tickets = [];
    listOfAssign = [];
    totalNumOfTickets="";
    isloading = false;
    pageNo = 1;
    allLoaded = false;
    notifyListeners();
  }

  clearOnDialogPop() {
    allLoaded = false;
    isSearching = false;
    isloading = false;
    ticketSearched = [];
    tickets = [];

    pageNo = 1;

    notifyListeners();
  }

  fetch(BuildContext context) async {
    if (allLoaded) {
      print("isallowed");
      print(allLoaded);
      return;
    }
    isSearching = false;
    isloading = true;
    notifyListeners();
    try {
      List<Ticket> ticketsFetched =
          await getTickList(context: context, pageNo: pageNo.toString());
      if (ticketsFetched.isNotEmpty) {
        if (pageNo > 1) {
          tickets?.addAll(ticketsFetched);

          print("page No greater than 1");
          notifyListeners();
        } else {
          print("page No less equal than 1");

          tickets = ticketsFetched;
          notifyListeners();
        }
      }
      print("page no");
      print(pageNo);
      print(tickets.length);

      isloading = false;
      allLoaded = ticketsFetched.length == 0;

      pageNo = pageNo + 1;
      isSearching = false;

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  search(String userInput) {
    isSearching = true;
    notifyListeners();
    ticketSearched = [];

    ticketSearched = tickets?.where((tic) {
      final String? nameLower = tic.rfCandName?.toLowerCase();

      return ((nameLower!.contains(userInput.toLowerCase())));
    }).toList();

    notifyListeners();
  }

  Future<List<Ticket>> getTickList(
      {required BuildContext context, required String pageNo}) async {
    try {
      userDetails =
          Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
      print("user id");

      print(userDetails?.id.toString());

      final response = await ApiClient.ticketsList(
          parentId: userDetails?.id.toString(), pageNo: pageNo);

      return response;
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

  Future<void> fetchListOfTicketAssignee(
      {required BuildContext context}) async {
    try {
      String? role;
      String? reportingTo;

      role = userDetails?.role;

      if (role == "Zonal Manager") {
        reportingTo = "Manager";
      } else if (role == "Manager") {
        reportingTo = "Team Lead";
      } else if (role == "Team Lead") {
        reportingTo = "HR";
      } else if (role == "Admin" || role == "ADMIN") {
        reportingTo = "Zonal Manager";
      }

      final result = await ApiClient.loadReportingMembers(
        role: reportingTo,
      );
      final repList = result as List<MemberInfo>;
      listOfMemberAssign = repList;

      for (MemberInfo mem in repList) {
        listOfAssign.add(CustoMDropDownMenuItem(
            memId: mem.mmbrId.toString(), memName: mem.mmbrName ?? "", empId: mem.mmbrEmpId??""));
      }

      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

  int? mapEmpIdtoMemId(String childEmpId) {
    final int childEmpIdInt = int.parse(childEmpId);

    int? childMemId;
    for (MemberInfo mem in listOfMemberAssign) {
      if (int.parse(mem.mmbrEmpId ?? "") == childEmpIdInt) {
        childMemId = mem.mmbrId;
      }
    }
    return childMemId;
  }

  Future<dynamic> assignTicket(
      {required String noOfTickets,
      required BuildContext context,
      required String childEmpId}) async {
    try {
      String? parentId;
      userDetails =
          Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;

      parentId = userDetails?.id.toString();
      print(noOfTickets);
      print(childEmpId);
      print(parentId);

      final result = await ApiClient.assignTicket(
          parentId: parentId, childId: childEmpId, totalTickets: noOfTickets);
      print(result);
      final AssignTicketResp resp = result;
      if (resp.message == "Assigned successfully") {
        return resp;
      } else {
        return null;
      }

      notifyListeners();
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }
}
