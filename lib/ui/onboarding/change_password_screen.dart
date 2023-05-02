import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/ui/onboarding/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../api/api_client.dart';
import '../../constants/app_strings.dart';
import '../../constants/colors.dart';

import '../../models/response/registered_user_details.dart';
import '../../widgets/custom_button2.dart';
import '../../widgets/input_field.dart';
import '../../widgets/validators.dart';
import '../dashboard_screen/dashboard.dart';

class ChangePasswordScreen extends StatefulWidget {
  final RegisteredUserDetails? userDetails;

  ChangePasswordScreen({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState>? formKey;
  var scaffoldKey;
  int intialtap = 0;
  bool hidePass = true;
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController conPassTextController = TextEditingController();

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    formKey = GlobalKey<FormState>();
  }



  changePassword() async {
    if (!formKey!.currentState!.validate()) {
      return;
    }
    formKey?.currentState!.save();
    try {
      final String? response = await ApiClient // need to put () to remove error
          .changePassword(
        mobile: widget.userDetails?.mobile,
        password: passwordTextController.text,
      );
      print(response);

      navigate(widget.userDetails!);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void navigate(RegisteredUserDetails loginResponse) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return DashBoard(userDetails: loginResponse);
    }));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  dispose() {
    passwordTextController.dispose();
    conPassTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.appBlack,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          elevation: 0,
          // leading: IconButton(onPressed: () {  }, icon: Icon(Icons.arrow_back_ios,)),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: VxScrollVertical(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              SizedBox(
                height: context.percentHeight * 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppStrings.changePIN.text
                      .color(MyColors.appBlack)
                      .xl3
                      .bold
                      .center
                      .heightRelaxed
                      .underline
                      .make(),
                ],
              ),
              SizedBox(
                height: context.percentHeight * 8,
              ),
              Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InputField(
                          onTap: () {
                            print("ontap");

                            if(intialtap>0){
                              print("ontap>0" );

                              setState(() {
                                hidePass = !hidePass;
                              });
                            }else if(intialtap==0){
                              print("ontap=0" );

                              setState(() {
                                intialtap=intialtap + 1;
                              });
                              print(intialtap);
                            }

                          },
                          assets:
                          hidePass ? Icons.visibility_off : Icons.visibility,
                          textInputAction: TextInputAction.next,
                          onSaved: (v) {},
                          isNumeric: false,
                          isPhoneNum: false,
                          isPasswordField: hidePass ? true : false,
                          controller: passwordTextController,
                          validator: Validators.validatePassword,
                          text: AppStrings.pass,
                        ),
                        SizedBox(
                          height: context.percentHeight * 2,
                        ),
                        InputField(
                          onTap: () {
                            print("ontap");

                            if(intialtap>0){
                              print("ontap>0" );

                              setState(() {
                                hidePass = !hidePass;
                              });
                            }else if(intialtap==0){
                              print("ontap=0" );

                              setState(() {
                                intialtap=intialtap + 1;
                              });
                              print(intialtap);
                            }

                          },
                          assets:
                          hidePass ? Icons.visibility_off : Icons.visibility,
                          textInputAction: TextInputAction.next,
                          onSaved: (v) {},
                          isNumeric: false,
                          isPhoneNum: false,
                          isPasswordField: hidePass ? true : false,
                          controller: conPassTextController,
                          validator: Validators.validatePassword,
                          text: AppStrings.conPass,
                        ),
                        SizedBox(
                          height: context.percentHeight * 1,
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: context.percentHeight * 2,
              ),
              SizedBox(
                height: context.percentHeight * 2,
              ),
              CustomButton2(
                colorText: Colors.white,
                text: "Change Password",
                onTap: changePassword,
              ),
            ].vStack(),
          ),
        ),
      ),
    );
  }
}
