import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/models/add_lined_up.dart';
import 'package:freelancer_internal_app/widgets/validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../constants/app_strings.dart';
import '../../../../constants/text_style.dart';
import '../../../../provider/ticket_update_lineup_provider.dart';
import '../../../../widgets/custom_button2.dart';
import '../../../../widgets/custom_date_input_field.dart';
import '../../../../widgets/custom_dropdown_formFeild.dart';
import '../../../../widgets/read_only_text_feild.dart';
import '../models/ticket.dart';

class LineupForComapnyScreen extends StatefulWidget {
  final AddLineUp? lineUpDetails;
  final int? rfId;
  final bool isEditing;
  final bool appBarActBut;
  final bool isCustomBut;

  const LineupForComapnyScreen(
      {Key? key, this.lineUpDetails, this.rfId, this.isEditing = false, required this.appBarActBut, required this.isCustomBut})
      : super(key: key);

  @override
  State<LineupForComapnyScreen> createState() => _LineupForComapnyScreenState();
}

class _LineupForComapnyScreenState extends State<LineupForComapnyScreen> {
  GlobalKey<FormState>? formKey;
  TextEditingController? newCompDesignation = TextEditingController();

  TextEditingController? companyName = TextEditingController();

  TextEditingController? lineUpDate = TextEditingController();

  String lineUpDateForApi = "";

  TextEditingController? interviewStatus = TextEditingController();

  TextEditingController? feedback = TextEditingController();

  TextEditingController? selectionStatus = TextEditingController();

  TextEditingController? documentStatus = TextEditingController();

  TextEditingController? offerStatus = TextEditingController();

  TextEditingController? expectedDOJ = TextEditingController();

  String expectedDOJForApi = "";

  TextEditingController? joiningDate = TextEditingController();

  String joiningDateForApi = "";

  TextEditingController? package = TextEditingController();

  TextEditingController? employeeCode = TextEditingController();

  TextEditingController? selectedForComp = TextEditingController();

  TextEditingController? coolingPeriod = TextEditingController();

  TextEditingController? zone = TextEditingController();

  TextEditingController? regionalHr = TextEditingController();

  TextEditingController? zonalHr = TextEditingController();

  TextEditingController? branchLocation = TextEditingController();

  TextEditingController? remark = TextEditingController();

  TextEditingController? internalStatus = TextEditingController();

  TextEditingController? hrRemark = TextEditingController();
  TextEditingController? tMRemark = TextEditingController();
  TextEditingController? zonalManagerRemark = TextEditingController();
  TextEditingController? adminRemark = TextEditingController();
  TextEditingController? interviewDateTime = TextEditingController();
  TextEditingController? joiningStatus = TextEditingController();
  TextEditingController? tlRemark = TextEditingController();
  String expectedDateForApi = "";

  List<String> offerStatusList = [
    "Offered",
    "Pending",
  ];

  String interviewDatForApi = "";

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    isEditing =
        widget.isEditing; // if(widget.lineUpDetails?.ln_intervw_dt!=null){
    //   DateTime dt = DateTime.parse(
    //       widget.lineUpDetails!.ln_intervw_dt!);
    //   print(dt);
    //   String interViewDate =
    //   DateFormat('dd-MM-yyyy')
    //       .format(dt);
    //
    //
    // }

    companyName?.text = widget.lineUpDetails?.ln_cmpny ?? "";
    newCompDesignation?.text = widget.lineUpDetails?.ln_desg ?? "";
    package?.text = widget.lineUpDetails?.ln_package ?? "";
    employeeCode?.text = widget.lineUpDetails?.ln_emp_code ?? "";
    regionalHr?.text = widget.lineUpDetails?.ln_regional_hr ?? "";
    zonalHr?.text = widget.lineUpDetails?.ln_zonal_hr ?? "";
    hrRemark?.text = widget.lineUpDetails?.ln_hr_remark ?? "";
    tlRemark?.text = widget.lineUpDetails?.ln_tl_remark ?? "";
    tMRemark?.text = widget.lineUpDetails?.ln_mngr_remark ?? "";
    zonalManagerRemark?.text = widget.lineUpDetails?.ln_zm_remark ?? "";
    adminRemark?.text = widget.lineUpDetails?.ln_adm_remark ?? "";

    //initializing drop downs

    // internalStatus?.text = widget.lineUpDetails?.ln_int ?? "";
    joiningStatus?.text = widget.lineUpDetails?.ln_joining_sts ?? "";
    interviewStatus?.text = widget.lineUpDetails?.ln_intrvw_sts ?? "";
    documentStatus?.text = widget.lineUpDetails?.ln_doc_sts ?? "";
    offerStatus?.text = widget.lineUpDetails?.ln_offer_sts ?? "";
    // if(widget.ticket?.rfDob!=""){
    //   DateTime dt = DateTime.parse(
    //       widget.ticket!.rfDob!);
    //   print(dt);
    //   String dob =
    //   DateFormat('dd-MM-yyyy')
    //       .format(dt);
    //   dobController?.text = dob;
    //   String initDateForApi =  DateFormat('yyyy-MM-dd')
    //       .format(dt);
    //   dobForApi = initDateForApi;
    //
    //
    // }
    if(widget.lineUpDetails?.ln_intervw_dt!=""&&widget.lineUpDetails?.ln_intervw_dt != null){
      DateTime dt = DateTime.parse(
          widget.lineUpDetails?.ln_intervw_dt??"");
      print(dt);
      String dob =
      DateFormat('dd-MM-yyyy')
          .format(dt);
      interviewDateTime?.text = dob;
    String initDateForApi =  DateFormat('yyyy-MM-dd')
        .format(dt);
    interviewDatForApi =initDateForApi;


    }
    //
    // if(widget.lineUpDetails?.ln_intervw_dt!=null){
    //   DateTime dt = DateTime.parse(
    //       widget.lineUpDetails!.ln_intervw_dt??"");
    //   print(dt);
    //   String dob =
    //   DateFormat('dd-MM-yyyy')
    //       .format(dt);
    //   interviewDateTime?.text = dob;
    //
    //
    // }
    print("interview date");
    print(widget.lineUpDetails?.ln_intervw_dt);
    print("jpining date");
    print(widget.lineUpDetails?.ln_joining_dt);
    print("expected date");
    print(widget.lineUpDetails?.ln_expctd_doj);
    if(widget.lineUpDetails?.ln_joining_dt!=""&&widget.lineUpDetails?.ln_joining_dt != null){
      DateTime dt2 = DateTime.parse(
          widget.lineUpDetails?.ln_joining_dt??"");
      print(dt2);
      String expDoj =
      DateFormat('dd-MM-yyyy')
          .format(dt2);
      joiningDate?.text = expDoj;

      String initDateForApi =  DateFormat('yyyy-MM-dd')
          .format(dt2);
      joiningDateForApi =initDateForApi;

    }

    // if(widget.lineUpDetails?.ln_joining_dt!=""){
    //   DateTime dt2 = DateTime.parse(
    //       widget.lineUpDetails?.ln_joining_dt??"");
    //   print(dt2);
    //   String join =
    //   DateFormat('dd-MM-yyyy')
    //       .format(dt2);
    //   joiningDate?.text = join;
    // }

    if(widget.lineUpDetails?.ln_expctd_doj!=""&&widget.lineUpDetails?.ln_expctd_doj != null){
      DateTime dt2 = DateTime.parse(
          widget.lineUpDetails?.ln_expctd_doj??"");
      print(dt2);
      String expDoj =
      DateFormat('dd-MM-yyyy')
          .format(dt2);
      expectedDOJ?.text = expDoj;

      String initDateForApi =  DateFormat('yyyy-MM-dd')
          .format(dt2);
      expectedDOJForApi =initDateForApi;

    }
  }

  // saveLineUpDateForApi(String date) {
  //   lineUpDateForApi = date;
  // }
  //
  // saveexpectedDOJForApi(String date) {
  //   expectedDOJForApi = date;
  // }
  //
  // savejoiningDateForApi(String date) {
  //   joiningDateForApi = date;
  // }

  File? resume;

  bool isEditing = false;

  List<String> candStatusList = [
    'Interested',
    'Not Insterested',
    'Call back in a week',
    'Not Reachable'
  ];

  List<String> channelList = ['a', 'b', 'c'];

  List<String> interViewStatusList = [
    'Attended',
    'Not Attended',
    'Need To Attend Again'
  ];

  List<String> selectionStatusList = ['Pending', 'Yes', 'No', 'Hold'];

  List<String> docStatusList = ['Pending', 'Yes', 'No', 'Hold'];

  List<String> offStatusList = ['Pending', 'Yes', 'No', 'Hold'];
  List<String> interviewStatusList = [
    "Reached",
    "No Show",
    "Not Interested",
    "Switched Off",
    "Reschedule"
  ];
  List<String> joiningStatusList = [
    "Pending",
    "Joined",
    "Dropped",
    "Onboarding Completed",
    "Onboarding Pending",
  ];

  clearControllers() {
    lineUpDateForApi = "";
    expectedDOJForApi = "";
    joiningDateForApi = "";
    lineUpDate?.clear();
    expectedDOJ?.clear();
    joiningDate?.clear();
    interviewStatus?.clear();
    selectionStatus?.clear();
    offerStatus?.clear();
  }

  update() async {
    if (!formKey!.currentState!.validate()) {
      return;
    }

    formKey?.currentState!.save();
    // print(joiningStatus?.text);
    // print(interviewDatForApi);
    print("exp date of joining");
    print(expectedDOJForApi);
    // print(joiningDateForApi);

    AddLineUp lineUpDetails = AddLineUp(
      rfId: widget.rfId.toString(),
      ln_id: widget.lineUpDetails?.ln_id,
      ln_desg: newCompDesignation?.text,
      ln_cmpny: companyName?.text,
      ln_intrvw_sts: interviewStatus?.text,
      ln_intervw_dt: interviewDatForApi,
      ln_fdbk: feedback?.text,
      ln_doc_sts: documentStatus?.text,
      ln_offer_sts: offerStatus?.text,
      ln_expctd_doj: expectedDOJForApi,
      ln_joining_dt: joiningDateForApi,
      ln_joining_sts: joiningStatus?.text,
      ln_package: package?.text,
      ln_emp_code: employeeCode?.text,
      ln_cooling_prd: coolingPeriod?.text,
      ln_regional_hr: regionalHr?.text,
      ln_zonal_hr: zonalHr?.text,
      ln_branch_loc: branchLocation?.text,
      ln_hr_remark: hrRemark?.text,
      ln_tl_remark: tlRemark?.text,
      ln_mngr_remark: tMRemark?.text,
      ln_zm_remark: zonalManagerRemark?.text,
      ln_adm_remark: adminRemark?.text,
    );

    try {
      if(widget.appBarActBut==false){
        print("Add");

        await Provider.of<TicketUpdateLineUpProvider>(context, listen: false)
            .addLineUpDetails(context: context, lineUp: lineUpDetails);

      }
      else{
        print("edit");

        await Provider.of<TicketUpdateLineUpProvider>(context, listen: false)
            .editLineUpDetails(context: context, lineUp: lineUpDetails);

      }
      // Navigator.of(context).pop();
    } catch (e) {
      // print("could not update");
      // print(e);
    } finally {
      // setState(() {
      //   isEditing = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("built again");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Ticket Details"), actions: [
          widget.appBarActBut
              ? IconButton(
                  onPressed: update,
                  icon: const Icon(
                    Icons.save,
                  ))
              : Text(""),
        ]),
        body: VxScrollVertical(
          padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 5),
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            // Container(height: context.percentHeight * 8,color: MyColors.blackMy, ),
            SizedBox(
              height: context.percentHeight * 2,
            ),

            buildForm(context),
            SizedBox(
              height: context.percentHeight * 2,
            ),

            if (widget.isCustomBut == true)
              CustomButton2(onTap: update, text: AppStrings.add),
          ].vStack(),
        ),
      ),
    );
  }

  SingleChildScrollView buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: companyName,
                validator: Validators.validateEmpty,
                text: AppStrings.selectedForComp),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: newCompDesignation,
                validator: Validators.validateEmpty,
                text: AppStrings.newCompDesignation),
            SizedBox(
              height: context.percentHeight * 2,
            ),

            CustomDateInputField(
              isReadOnly: !isEditing,
              labelText: "Interview Date / Time",
              controller: interviewDateTime,
              saveDateFuncForApi: (va) {
                interviewDatForApi = va;
              },
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            CustomDropDownFormButton(
              dropDownIntialVAlue: interviewStatus?.text == ""? null: interviewStatus?.text ,

              isReadOnly: !isEditing,
              items: interviewStatusList,
              selectedOptionController: interviewStatus,
              text: AppStrings.interviewStatus,
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            CustomDropDownFormButton(
              dropDownIntialVAlue: joiningStatus?.text == ""? null: joiningStatus?.text ,
              isReadOnly: !isEditing,
              items: joiningStatusList,
              text: AppStrings.joiningStatus,
              selectedOptionController: joiningStatus,
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            CustomDateInputField(
              isReadOnly: !isEditing,
              labelText: AppStrings.joiningDate,
              controller: joiningDate,
              saveDateFuncForApi: (va) {
                joiningDateForApi = va;
              },
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
                isNumeric: true,
                isReadOnly: !isEditing,
                controller: package,
                text: AppStrings.package),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: employeeCode,
                text: AppStrings.employeeCode),
            SizedBox(
              height: context.percentHeight * 2,
            ),

            CustomDropDownFormButton(
              dropDownIntialVAlue: documentStatus?.text == ""? null: documentStatus?.text ,

              isReadOnly: !isEditing,
              items: docStatusList,
              text: AppStrings.documentStatus,
              selectedOptionController: documentStatus,
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            // ReadOnlyTextField(
            //     controller: newCompDesignation, text: AppStrings.newCompDesignation),
            // SizedBox(
            //   height: context.percentHeight * 2,
            // ),
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: regionalHr,
                text: AppStrings.regionalHr),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: zonalHr,
                text: AppStrings.zonalHr),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: hrRemark,
                text: AppStrings.hrRemark),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: tlRemark,
                text: AppStrings.tlRemark),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: tMRemark,
                text: AppStrings.tmRemark),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: zonalManagerRemark,
                text: AppStrings.zonalManagerRemark),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            ReadOnlyTextField(
                isReadOnly: !isEditing,
                controller: adminRemark,
                text: AppStrings.adminRemark),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            CustomDateInputField(
              isReadOnly: !isEditing,
              labelText: "Expected Date Of Joining",
              controller: expectedDOJ,
              saveDateFuncForApi: (va) {
                expectedDOJForApi=va;
                // expectedDateForApi = va;
                // print(expectedDOJForApi);
              },
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
            CustomDropDownFormButton(
              dropDownIntialVAlue: offerStatus?.text == ""? null: offerStatus?.text ,

              isReadOnly: !isEditing,
              items: offerStatusList,
              selectedOptionController: offerStatus,
              text: AppStrings.offerStatus,
            ),
            SizedBox(
              height: context.percentHeight * 2,
            ),
          ],
        ),
      ),
    );
  }
}
