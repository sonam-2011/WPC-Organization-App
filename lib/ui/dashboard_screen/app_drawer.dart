import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/constants/colors.dart';
import 'package:freelancer_internal_app/provider/tickets_provider.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/member_hierarchy/screen/member_hierarchy_screen.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/profile/screen/profile_screen.dart';

import '../../constants/app_strings.dart';
import '../../models/response/registered_user_details.dart';
import '../../provider/member_hierarchy_list_provider.dart';
import '../../provider/shared_pref_provider.dart';
import '../../routes.dart';
import '../../shared_preferences_data.dart';
import 'package:provider/provider.dart';

import '../appdrawer_options/tickets/screens/ticket_screen_3.dart';

class AppDrawer extends StatelessWidget {
  final Color color = Colors.green;
  final scaffoldKey;
  RegisteredUserDetails? userDetails;

  AppDrawer({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    userDetails = Provider.of<ShraredPrefProvider>(context).loggedInUser;
    print(userDetails?.role??"");

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppBar(
            elevation: 0,
            title: Row(
              children: [
                Text(AppStrings.appDrawerTitle),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                    leading: Icon(Icons.person, color: MyColors.appBlack),
                    title: const Text('Profile'),
                    onTap: () {
                      scaffoldKey.currentState!.closeDrawer();
                      RegisteredUserDetails? userDetails;

                      userDetails = Provider.of<ShraredPrefProvider>(context,
                              listen: false)
                          .loggedInUser;

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProfileScreen(
                          userDetails: userDetails,
                        );
                      }));
                    }),
                if(userDetails?.role=="Admin")const Divider(),
                if(userDetails?.role=="Admin")ListTile(
                    leading: Icon(Icons.person_add, color: MyColors.appBlack),
                    title: const Text('Add Member'),
                    onTap: () {
                      scaffoldKey.currentState!.closeDrawer();

                      Navigator.of(context).pushNamed(Routes.addMemberScreen);
                    }),
                const Divider(),
                ListTile(
                    leading: Icon(Icons.person, color: MyColors.appBlack),
                    title: const Text('Members Hierarchy'),
                    onTap: () async {
                      scaffoldKey.currentState!.closeDrawer();
                      print("before");
                      Provider.of<MemberHierarchyListProvider>(context,
                              listen: false)
                          .getReportingMembersList(context);
                      print("after");
                      RegisteredUserDetails? userDetails;

                      userDetails = Provider.of<ShraredPrefProvider>(context,
                              listen: false)
                          .loggedInUser;
                      print(userDetails?.role);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MemberHierarchyScreen(
                            memRole: userDetails?.role ?? "");
                      }));
                    }),
                const Divider(),
                ListTile(
                    leading:
                        Icon(Icons.airplane_ticket, color: MyColors.appBlack),
                    title: const Text('Tickets'),
                    onTap: () async {
                      scaffoldKey.currentState!.closeDrawer();
                      RegisteredUserDetails? userDetails;

                      userDetails = Provider.of<ShraredPrefProvider>(context,
                              listen: false)
                          .loggedInUser;
                      // print("before");
                      // await Provider.of<TicketProvider>(context, listen: false).fetch(context);
                      // Provider.of<TicketProvider>(context, listen: false).fetchListOfTicketAssignee( context: context);

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return TicketScreen3(
                          userDetails: userDetails,
                        );
                      }));
                    }),
                const Divider(),
                ListTile(
                    leading: Icon(Icons.money_sharp, color: MyColors.appBlack),
                    title: const Text('Pay Now'),
                    onTap: () {
                      scaffoldKey.currentState!.closeDrawer();

                      Navigator.of(context).pushNamed(Routes.payNow);
                    }),
                const Divider(),
                ListTile(
                    leading: Icon(Icons.visibility, color: MyColors.appBlack),
                    title: const Text('Change Password'),
                    onTap: () {
                      scaffoldKey.currentState!.closeDrawer();

                      Navigator.of(context)
                          .pushNamed(Routes.changePasswordScreen);
                    }),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: MyColors.appBlack),
                  title: const Text('SignOut'),
                  onTap: () async {
                    Provider.of<ShraredPrefProvider>(context, listen: false)
                        .clearData();
                    // await SharedPreferencesData.clearData();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.loginScreen, (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
