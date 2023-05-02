import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer_internal_app/constants/colors.dart';
import 'package:freelancer_internal_app/constants/text_style.dart';
import 'package:freelancer_internal_app/models/response/registered_user_details.dart';
import 'package:freelancer_internal_app/ui/dashboard_screen/widgets/welcome_screen_images_widget.dart';

import '../../api/api_client.dart';
import 'app_drawer.dart';
import 'model/stats.dart';

class DashBoard extends StatefulWidget {
  final RegisteredUserDetails ? userDetails;

   DashBoard({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final scaffoldKey = new GlobalKey();
  List<Stats> stats=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadStats();
  }

  loadStats() async {



    stats = await ApiClient.dataStats(key: '');
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    DateTime _lastExitTime = DateTime.now();
    // print(adminAmt);
    // final size = MediaQuery.of(context).size;
    // final adminAmt = ModalRoute.of(context)!.settings.arguments as dynamic;

    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(_lastExitTime) >= Duration(seconds: 2)) {
          //showing message to user
          const snack = SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Press the back button again to exist the app"),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          // ScaffoldMessenger.of(context).removeCurrentSnackBar();
          _lastExitTime = DateTime.now();
          return false; // disable back press
        } else {
          SystemNavigator.pop();
          // Navigator.of(context)
          //     .pop();
          return true; //  exit the app
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),

        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const WlcomeScreenImagesWidget(),
                const SizedBox(
                  height: 15,
                ),
                if(stats.isEmpty)CircularProgressIndicator(),
                if(stats.isNotEmpty)ListView.builder(
                  itemCount: stats.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                  Stats data = stats[index];
                  return Card(
                    child: Container(
                      color: MyColors.appBlack,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(data.name??"",style: MyTextStyle.dashBoardListStyle,),
                                Text(" : ",style: MyTextStyle.dashBoardListStyle,),
                                Text(data.number.toString()??"",style: MyTextStyle.dashBoardListStyle,),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                })


              ],
            ),
          ),
        ),
      ),
    );
  }
}
