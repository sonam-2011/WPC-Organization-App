import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/models/response/registered_user_details.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/screens/ticket_detail_update_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../api/api_client.dart';
import '../../../../constants/app_strings.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/text_style.dart';
import '../../../../helper_functions.dart';
import '../../../../models/member_info.dart';
import '../../../../provider/tickets_provider.dart';
import '../../../../widgets/custom_button2.dart';
import '../../../../widgets/custom_dropdown_formFeild.dart';
import '../../../../widgets/input_field.dart';
import '../../../../widgets/validators.dart';
import '../../add_member/custom_model_dropdown_itm.dart';
import '../models/assign_ticker_resp.dart';
import '../models/ticket.dart';
import '../widgets/custom_tile.dart';

class TicketScreen3 extends StatefulWidget {
  final RegisteredUserDetails? userDetails;

  const TicketScreen3({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<TicketScreen3> createState() => _TicketScreen3State();
}

class _TicketScreen3State extends State<TicketScreen3> {
  int pageNo = 1;

  bool loading = false;
  bool alloaded = false;
  final ScrollController scrollContr = ScrollController();
  List<Ticket> tickesList = [];
  bool isSearching = false;
  List<Ticket>? ticketSearched = [];
  GlobalKey<FormState>? formKey;
  bool firstLoad = false;

  TextEditingController searchedUser = TextEditingController();
  List<Ticket> searchedList = [];

  List<CustoMDropDownMenuItem> listOfPersons = [];
  CustoMDropDownMenuItem? selectedItem;
  List<MemberInfo> listOfMemberAssign = [];
  List<CustoMDropDownMenuItem> listOfAssign = [];
  TextEditingController noOfTickets = TextEditingController();
  TextEditingController assignedTo = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("getting job list");
    Provider.of<TicketProvider>(context, listen: false).getIndustriesList();
    Provider.of<TicketProvider>(context, listen: false).getJobCategoryList();
    print("before call");
    Provider.of<TicketProvider>(context, listen: false)
        .gettotalNumOftickets(mmbr_id: widget.userDetails?.id.toString());
    print("after call");
    formKey = GlobalKey<FormState>();
    getTickList();
    fetchListOfTicketAssignee();

    scrollContr.addListener(() async {
      // if(pageNo <4){
      if (scrollContr.position.pixels >= scrollContr.position.maxScrollExtent &&
          (!loading)) {
        print("New Data");

        getTickList();
      }

      // }else
      // {
      //   print("do nothing");
      // }
    });

    print(pageNo);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("controller disposed");
    scrollContr.dispose();
    // searchedUser.dispose();
  }

  getTickList() async {
    print("getiing tickets");
    print(pageNo);
    if (alloaded) {
      print("all loaded");
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      List<Ticket> newTickets = await ApiClient.ticketsList(
          parentId: widget.userDetails?.id.toString(),
          pageNo: pageNo.toString());
      if (pageNo == 1) {
        firstLoad = true;
      }
      if (newTickets.isNotEmpty) {
        tickesList.addAll(newTickets);
        pageNo = pageNo + 1;
      }
      setState(() {
        loading = false;
        alloaded = newTickets.isEmpty;
      });
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

  fetchListOfTicketAssignee() async {
    try {
      String? role;
      String? reportingTo;

      role = widget.userDetails?.role;

      if (role == "Zonal Manager") {
        reportingTo = "Manager";
      } else if (role == "Manager") {
        reportingTo = "Team Lead";
      } else if (role == "Team Lead") {
        reportingTo = "HR";
      } else if (role == "Admin" || role == "ADMIN") {
        reportingTo = "Zonal Manager";
      }

      listOfMemberAssign = await ApiClient.loadReportingMembers(
        role: reportingTo,
      );

      for (MemberInfo mem in listOfMemberAssign) {
        listOfAssign.add(CustoMDropDownMenuItem(
            memId: mem.mmbrId.toString(), memName: mem.mmbrName ?? "", empId: mem.mmbrEmpId??""));
      }
    } catch (e) {
      print("Could not call Api");
      log(e.toString());
      rethrow;
    }
  }

  Form buildForm(BuildContext context) {
    // Provider.of<TicketProvider>(context, listen: false).fetch(context);

    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<TicketProvider>(builder: (context,value,child){
                if(value.isloadTotalTicket==false){
                  return  Container(
                      color: MyColors.appBlack,
                      child:  Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(AppStrings.totalNoTickets + value.getTotalNumOfTickets,
                            style: MyTextStyle.noDataTextStytle),
                      ));

                }else {
                  return SizedBox();
                }

        }
              ),
              SizedBox(height: 20),
              InputField(
                // assets: Icons.person,
                onTap: () {},
                textInputAction: TextInputAction.next,
                onSaved: (v) {
                  noOfTickets.text = v ?? "";
                },
                isNumeric: true,
                isPhoneNum: false,
                isPasswordField: false,
                controller: noOfTickets,
                validator: Validators.validateEmpty,
                text: AppStrings.noOfTickEts,
              ),
              SizedBox(height: 20),
              CustomDropDownFormButton2(
                validator: (value) =>
                    value == null ? AppStrings.reporter : null,
                text: "Assigned to",
                items: listOfAssign,
                selectedOptionController: assignedTo,
                optionalFunction: (v) {
                  selectedItem = v;
                  print(selectedItem?.memName);
                  print("executed optional function");
                },
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton2(
                color: MyColors.appBlack,
                colorText: Colors.white,
                text: "Assign Ticket",
                onTap: assignTicket,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  void clearControllers() {
    print("executing clear");
    noOfTickets.clear();
    assignedTo.clear();
    searchedUser.clear();
    selectedItem = null;
  }

  clearMemSearList() {
    isSearching = false;
    ticketSearched = [];
    setState(() {});
  }

  assignTicket() async {
    if (!formKey!.currentState!.validate()) {
      return;
    }
    print(selectedItem?.memId);
    print(noOfTickets?.text);

    formKey?.currentState!.save();
    try {
      final resp = await Provider.of<TicketProvider>(context, listen: false)
          .assignTicket(
        noOfTickets: noOfTickets.text,
        childEmpId: selectedItem?.memId ?? "",
        context: context,
      );

      final close = context.showLoading(
          textColor: MyColors.appWhite, msg: 'Assigning Ticket');
      await Future.delayed(2.seconds, close as FutureOr Function()?);

      if (resp != null) {
        setState(() {
          pageNo = 1;
          tickesList = [];
          alloaded = false;
          getTickList();
        });

        clearControllers();

        final AssignTicketResp assignTicketResp = resp;
        HelperFunctions.dialog(
            title: assignTicketResp.message ?? "",
            content: "",
            buttonTitle: "Ok",
            onPressed: () {
              Navigator.of(context).pop();
            },
            context: context);

        // clearControllers();
      }
    } catch (e) {
      print(e);
      HelperFunctions.dialog(
          title: AppStrings.errorMes,
          content: "Could Not Assign Tickets",
          buttonTitle: "Ok",
          onPressed: () {
            Navigator.of(context).pop();
          },
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("built called");
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            if (tickesList.isNotEmpty) buildForm(context),

            Divider(
              thickness: 5,
              color: MyColors.appBlack,
            ),
            const SizedBox(
              height: 10,
            ),
            if (tickesList.isNotEmpty)
              TextField(
                style: const TextStyle(color: Colors.grey),
                cursorColor: MyColors.appBlack,
                controller: searchedUser,
                onChanged: (val) {
                  isSearching = true;

                  ticketSearched = [];

                  ticketSearched = tickesList?.where((tic) {
                    final String? nameLower = tic.rfCandName?.toLowerCase();

                    return ((nameLower!
                        .contains(searchedUser.text.toLowerCase())));
                  }).toList();
                  searchedList = ticketSearched ?? [];

                  setState(() {});
                },
                cursorHeight: 18,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: MyColors.appBlack),
                  ),

                  // prefixIcon: ,
                  label: Text("Search"),
                  // hintText: text,
                  labelStyle: MyTextStyle.labelText,
                  contentPadding: const EdgeInsets.only(left: 10.0),
                  hintStyle: MyTextStyle.hintTextStyle,
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 2,
                    minHeight: 2,
                  ),

                  suffixIconColor: Colors.deepOrange,

                  suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () {
                            clearMemSearList();
                            searchedUser.clear();
                          },
                          icon: Icon(Icons.clear, color: MyColors.appBlack))),
                  // prefixIcon: Padding(
                  //   padding: const EdgeInsets.only(right: 10),
                  //   child: Icon(prefixAsset, color: Colors.grey.shade500),
                  // ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Tickets List",
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (isSearching == false) {
                    if (tickesList.isNotEmpty) {
                      return Stack(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              controller: scrollContr,
                              itemCount: tickesList.length + (alloaded ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index < tickesList.length) {
                                  Ticket ticket = tickesList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return TicketDetailUpdateScreen(
                                          ticket: ticket!,
                                          path: "Ticket",
                                        );
                                      }));
                                    },
                                    child: CustomTicketLineUpTile(
                                      title: ticket.rfCandName ?? "",
                                      subTitle: ticket.rfMob ?? "",
                                      trailing: ticket.rfLocation ?? "",
                                      ticket: ticket,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    width: constraints.maxWidth,
                                    height: 50,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text((tickesList.length + 1)
                                              .toString()),
                                          Text("All tickets Loaded"),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }),
                          if (loading)
                            Positioned(
                                left: 0,
                                bottom: 0,
                                child: Container(
                                  width: constraints.maxWidth,
                                  height: 80,
                                  child: CircularProgressIndicator(),
                                ))
                        ],
                      );
                    } else if (tickesList.isEmpty && firstLoad == true) {
                      return Center(
                          child: Container(
                              color: MyColors.appBlack,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(AppStrings.noTickets,
                                    style: MyTextStyle.noDataTextStytle),
                              )));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    if (searchedList.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          controller: scrollContr,
                          itemCount: searchedList.length,
                          itemBuilder: (context, index) {
                            Ticket ticket = searchedList[index];
                            return CustomTicketLineUpTile(
                              title: ticket.rfCandName ?? "",
                              subTitle: ticket.rfMob ?? "",
                              trailing: ticket.rfLocation ?? "",
                              ticket: ticket,
                            );
                          });
                    } else {
                      return Center(child: Text("No Such Ticket"));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
