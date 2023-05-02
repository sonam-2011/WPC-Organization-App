import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/provider/member_hierarchy_list_provider.dart';
import 'package:freelancer_internal_app/provider/shared_pref_provider.dart';
import 'package:freelancer_internal_app/provider/ticket_update_lineup_provider.dart';
import 'package:freelancer_internal_app/provider/tickets_provider.dart';
import 'package:freelancer_internal_app/routes.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/add_member/add_member_screen.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/change_password/change_password_screen.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/member_hierarchy/screen/member_hierarchy_screen.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/pay_now/screen/pay_now_screen.dart';
import 'package:freelancer_internal_app/ui/onboarding/login_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import 'api/api_client.dart';
import 'constants/colors.dart';
import 'ui/onboarding/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Get.put(ApiClient());
  runApp(const MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ShraredPrefProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => MemberHierarchyListProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => TicketProvider()
        ),
        ChangeNotifierProvider(
            create: (BuildContext context) => TicketUpdateLineUpProvider()
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          // primaryColor: MyColors.blackMy,

          appBarTheme: const AppBarTheme(
              backgroundColor: MyColors.appBlack,
              iconTheme: IconThemeData(color: MyColors.appWhite)),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 3, color: MyColors.appBlack),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          Routes.loginScreen: (ctx) => const LoginScreen(),
          Routes.addMemberScreen: (ctx) => AddMemberScreen(),
          Routes.changePasswordScreen: (ctx) => ChangePasswordScreen(),
          Routes.payNow: (ctx) => PayNowScreen(),

          // Routes.editProfileScreen: (ctx) => UpdateProfileScreen(),
        },
      ),
    );
  }
}
