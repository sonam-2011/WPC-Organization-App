import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/constants/app_strings.dart';
import 'package:freelancer_internal_app/constants/colors.dart';
import 'package:freelancer_internal_app/constants/text_style.dart';
import 'package:freelancer_internal_app/provider/member_hierarchy_list_provider.dart';
import 'package:provider/provider.dart';

import '../../../../api/api_client.dart';
import '../../../../provider/tickets_provider.dart';
import '../../tickets/models/ticket.dart';
import '../../tickets/screens/ticket_detail_update_screen.dart';
import '../../tickets/widgets/custom_tile.dart';
import '../model/reporting_member.dart';

class MemberTicketList2 extends StatefulWidget {
  final ReportingMember member;

  const MemberTicketList2({Key? key, required this.member}) : super(key: key);

  @override
  State<MemberTicketList2> createState() => _MemberTicketList2State();
}

class _MemberTicketList2State extends State<MemberTicketList2> {
  int pageNo = 1;

  bool loading = false;
  bool firstLoad = false;
  bool alloaded = false;
  final ScrollController scrollContr = ScrollController();
  List<Ticket> tickesList = [];
  bool isSearching = false;
  List<Ticket>? ticketSearched = [];
  TextEditingController searchedUser = TextEditingController();
  List<Ticket> searchedList = [];

  @override
  void initState() {
    super.initState();
    getTickList();
    Provider.of<MemberHierarchyListProvider>(context, listen: false)
        .gettotalNumOftickets(mmbr_id: widget.member.mmbrId.toString());

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
          parentId: widget.member.mmbrId.toString(), pageNo: pageNo.toString());
      if(pageNo ==1){
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

  clearMemSearList() {
    isSearching = false;
    ticketSearched = [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Divider(
          height: 20,
          color: MyColors.appBlack,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Tickets List",
          style: MyTextStyle.subHeadings,
        ),
        const SizedBox(
          height: 10,
        ),
        if(tickesList.isNotEmpty)Consumer<MemberHierarchyListProvider>(builder: (context,value,child){
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
        if(tickesList.isNotEmpty)TextField(
          style: const TextStyle(color: Colors.grey),
          cursorColor: MyColors.appBlack,
          controller: searchedUser,
          onChanged: (val) {
            isSearching = true;

            ticketSearched = [];

            ticketSearched = tickesList?.where((tic) {
              final String? nameLower = tic.rfCandName?.toLowerCase();

              return ((nameLower!.contains(searchedUser.text.toLowerCase())));
            }).toList();
            searchedList =ticketSearched ?? [];

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
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                    return TicketDetailUpdateScreen(ticket: ticket!, path: 'Member',member: widget.member,);
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
                                      Text((tickesList.length + 1).toString()),
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
                } else if (tickesList.isEmpty&&firstLoad ==true) {
                  return Center(
                      child: Container(
                          color: MyColors.appBlack,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(AppStrings.noTicketsAssigned,
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
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                              return TicketDetailUpdateScreen(ticket: ticket!, path: "Member",member: widget.member,);
                            }));
                          },
                          child: CustomTicketLineUpTile(
                            title: ticket.rfCandName ?? "",
                            subTitle: ticket.rfMob ?? "",
                            trailing: ticket.rfLocation ?? "",
                            ticket: ticket,
                          ),
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
    );
  }
}
