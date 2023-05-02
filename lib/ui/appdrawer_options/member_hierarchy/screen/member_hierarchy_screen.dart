import 'package:flutter/material.dart';
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

class MemberHierarchyScreen extends StatelessWidget {
  TextEditingController searchedUser = TextEditingController();
  final String memRole;
  List<ReportingMember> searchedList = [];

  MemberHierarchyScreen({Key? key, required this.memRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("in build of mem hei screen");
    print(memRole);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Reporting Members",
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
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Consumer<MemberHierarchyListProvider>(
                    builder: (context, memlist, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
                    child: TextField(
                      style: const TextStyle(color: Colors.grey),
                      cursorColor: MyColors.appBlack,
                      controller: searchedUser,
                      onChanged: (val) {
                        Provider.of<MemberHierarchyListProvider>(context,
                                listen: false)
                            .search(memRole, searchedUser.text);
                        print("on changed");
                        searchedList = memlist.getmemSearched ?? [];
                        print(searchedList.length);
                      },
                      cursorHeight: 18,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(width: 1, color: MyColors.appBlack),
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
                                  Provider.of<MemberHierarchyListProvider>(
                                          context,
                                          listen: false)
                                      .clearMemSearList();
                                  searchedUser.clear();
                                },
                                icon: Icon(Icons.clear,
                                    color: MyColors.appBlack))),
                        // prefixIcon: Padding(
                        //   padding: const EdgeInsets.only(right: 10),
                        //   child: Icon(prefixAsset, color: Colors.grey.shade500),
                        // ),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Consumer<MemberHierarchyListProvider>(
                  builder: (context, memberList, child) {
                    if (memberList.getIsSeacrhing == false) {
                      if (memberList.isloading) {
                        print("in consumer of refer screen");
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (memRole == "Zonal Manager") {
                          if (memberList.getreportingMangersList!.isEmpty) {
                            return const Center(
                              child: Text(AppStrings.noReportingPerson),
                            );
                          } else {
                            return Column(
                              children: [


                                ListView.builder(
                                    shrinkWrap: true,
                                    // itemExtent: size.width * 0.8,
                                    itemCount:
                                    memberList.getreportingMangersList?.length,
                                    itemBuilder: (context, index) {
                                      if (memberList.getreportingMangersList !=
                                          null) {
                                        if (memberList
                                            .getreportingMangersList!.isEmpty) {
                                          return CustomNoDataWidget(
                                            imageString: ImageStrings.no_data,
                                            text: AppStrings.noReportingPerson,
                                          );
                                        } else {
                                          print("loading done");
                                          final ReportingMember member = memberList
                                              .getreportingMangersList![index];
                                          return CustomTile(
                                            member: member,
                                          );
                                        }
                                      }
                                    }),

                              ],
                            );
                          }
                        } else if (memRole == "Manager") {
                          if (memberList.getreportingTlList!.isEmpty) {
                            return const Center(
                              child: Text(AppStrings.noReportingPerson),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                // itemExtent: size.width * 0.8,
                                itemCount:
                                    memberList.getreportingTlList?.length,
                                itemBuilder: (context, index) {
                                  if (memberList.getreportingTlList != null) {
                                    if (memberList.getreportingTlList?.length ==
                                        0) {
                                      return CustomNoDataWidget(
                                        imageString: ImageStrings.no_data,
                                        text: AppStrings.noReportingPerson,
                                      );
                                    } else {
                                      print("loading done");
                                      final ReportingMember member =
                                          memberList.getreportingTlList![index];
                                      return CustomTile(
                                        member: member,
                                      );
                                    }
                                  }
                                });
                          }
                        } else if (memRole == "Team Lead") {
                          if (memberList.getreportingHrsList!.isEmpty) {
                            return const Center(
                              child: Text(AppStrings.noReportingPerson),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                // itemExtent: size.width * 0.8,
                                itemCount:
                                    memberList.getreportingHrsList?.length,
                                itemBuilder: (context, index) {
                                  if (memberList.getreportingHrsList != null) {
                                    if (memberList
                                            .getreportingHrsList?.length ==
                                        0) {
                                      return const CustomNoDataWidget(
                                        imageString: ImageStrings.no_data,
                                        text: AppStrings.noReportingPerson,
                                      );
                                    } else {
                                      print("loading done");
                                      final ReportingMember member = memberList
                                          .getreportingHrsList![index];
                                      return CustomTile(
                                        member: member,
                                      );
                                    }
                                  }
                                });
                          }
                        } else {
                          if (memberList
                              .getreportingZonalManagersList!.isEmpty) {
                            return const Center(
                              child: Text(AppStrings.noReportingPerson),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                // itemExtent: size.width * 0.8,
                                itemCount: memberList
                                    .getreportingZonalManagersList?.length,
                                itemBuilder: (context, index) {
                                  if (memberList
                                          .getreportingZonalManagersList !=
                                      null) {
                                    if (memberList.getreportingZonalManagersList
                                            ?.length ==
                                        0) {
                                      return CustomNoDataWidget(
                                        imageString: ImageStrings.no_data,
                                        text: AppStrings.noReportingPerson,
                                      );
                                    } else {
                                      print("loading done");
                                      final ReportingMember member = memberList
                                              .getreportingZonalManagersList![
                                          index];
                                      return CustomTile(
                                        member: member,
                                      );
                                    }
                                  }
                                });
                          }
                        }
                      }
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          // itemExtent: size.width * 0.8,
                          itemCount: memberList.memSearched?.length,
                          itemBuilder: (context, index) {
                            if (memberList.memSearched != null) {
                              if (memberList.memSearched!.isEmpty) {
                                return CustomNoDataWidget(
                                  imageString: ImageStrings.no_data,
                                  text: AppStrings.noReportingPerson,
                                );
                              } else {
                                print("loading done");
                                final ReportingMember member =
                                    memberList.memSearched![index];
                                return CustomTile(
                                  member: member,
                                );
                              }
                            }
                          });
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
