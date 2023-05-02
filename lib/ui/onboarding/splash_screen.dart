import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




import '../../api/api_client.dart';
import '../../models/response/registered_user_details.dart';
import '../../provider/shared_pref_provider.dart';
import '../../routes.dart';
import '../dashboard_screen/dashboard.dart';
import '../maintenance/maintenance_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadWidget();
  }



  _loadWidget() async {
    await Future.delayed(const Duration(milliseconds: 500));
    var duration = const Duration(seconds: 3);
    setState(() { animate = true; });
    return Timer(duration, (await navigationPage));
  }

  // Future<void> navigationPage() async {
  //   Map checkMAintenanceMap =
  //   await ApiClient.blockApp();
  //
  //   if (checkMAintenanceMap['maintenance']=="ACTIVE") {
  //     Navigator.of(context)
  //         .pushReplacement(MaterialPageRoute(builder: (context) {
  //       return  MaintenanceScreen(map:checkMAintenanceMap);
  //     }));
  //
  //
  //   } else if (checkMAintenanceMap['maintenance']=="DEACTIVE"){
  //        RegisteredUserDetails? userDetails;
  //     await Provider.of<ShraredPrefProvider>(context, listen: false).readSharedData();
  //     userDetails = Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
  //     if (userDetails?.username != null) {
  //       String accessMes =
  //       await ApiClient.checkAccess(id: userDetails?.id.toString());
  //       if (accessMes == "ACTIVE") {
  //         print("in initstate");
  //         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
  //           return  DashBoard(userDetails: userDetails,);
  //         }));
  //       } else {
  //         Provider.of<ShraredPrefProvider>(context, listen: false)
  //             .clearData();
  //         // await SharedPreferencesData.clearData();
  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             Routes.loginScreen, (Route<dynamic> route) => false);
  //     }} else {
  //       Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
  //
  //
  //     }
  //   }
  // }

  void navigationPage() async {
    RegisteredUserDetails? userDetails;
 await Provider.of<ShraredPrefProvider>(context, listen: false).readSharedData();
 userDetails = Provider.of<ShraredPrefProvider>(context, listen: false).loggedInUser;
 print(userDetails?.username);

    if (userDetails?.username != null) {
      print("in initstate");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return  DashBoard(userDetails: userDetails);

      }));
    }
    else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return const LoginScreen();
      }));
    }
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                )),
          ),
        ));


  }
}

// return SafeArea(
// child: Scaffold(
// body: Stack(
// children: [
// AnimatedPositioned(
// duration: const Duration(milliseconds: 2000),
// top: animate ? MediaQuery.of(context).size.height/2.5 : 0,
// left: MediaQuery.of(context).size.width/3 ,
// child: AnimatedOpacity(
// duration: const Duration(milliseconds: 2000),
// opacity: animate ? 1 : 0,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "Welcome",
// style: Theme.of(context).textTheme.headlineLarge,
// ),
//
//
// // Text(
// //   tAppTagLine,
// //   style: Theme.of(context).textTheme.headline2,
// // )
// ],
// ),
// ),
// ),
// // AnimatedPositioned(
// //   duration: const Duration(milliseconds: 2000),
// //   right:MediaQuery.of(context).size.width/3.5,
// //   bottom: animate ? MediaQuery.of(context).size.height/3  : 0,
// //   child: AnimatedOpacity(
// //     duration: const Duration(milliseconds: 2000),
// //     opacity: animate ? 1 : 0,
// //     child: Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           "Welcome",
// //           style: Theme.of(context).textTheme.headlineLarge,
// //         ),
// //
// //
// //         // Text(
// //         //   tAppTagLine,
// //         //   style: Theme.of(context).textTheme.headline2,
// //         // )
// //       ],
// //     ),
// //   ),
// // ),
// ],
//
// ),
// // Center(
// //     child: AppStrings.welcome.text
// //         .color(MyColors.appBlack)
// //         .xl3
// //         .bold
// //         .center
// //         .heightRelaxed
// //         .underline
// //         .wide
// //         .make()),
// ),
// );