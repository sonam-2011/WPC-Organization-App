import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_internal_app/constants/text_style.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/models/add_lined_up.dart';
import 'package:freelancer_internal_app/ui/appdrawer_options/tickets/models/ticket.dart';
import 'package:freelancer_internal_app/widgets/custom_dropdown_formFeild.dart';
import 'package:freelancer_internal_app/widgets/custom_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../constants/app_strings.dart';
import '../../../../provider/ticket_update_lineup_provider.dart';
import '../../../../provider/tickets_provider.dart';
import '../../../../widgets/custom_button2.dart';
import '../../../../widgets/custom_date_input_field.dart';
import '../../../../widgets/read_only_text_feild.dart';
import '../../member_hierarchy/model/reporting_member.dart';
import '../widgets/custom_tile.dart';
import 'lineup_for_comapny_screen.dart';

class TicketDetailUpdateScreen extends StatefulWidget {
  final Ticket ticket;
  final ReportingMember? member;

  final String path;

  const TicketDetailUpdateScreen({Key? key, required this.ticket, required this.path, this.member})
      : super(key: key);

  @override
  State<TicketDetailUpdateScreen> createState() =>
      _TicketDetailUpdateScreenState();
}

class _TicketDetailUpdateScreenState extends State<TicketDetailUpdateScreen> {
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController? locality = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? jobCategory = TextEditingController();
  TextEditingController? education = TextEditingController();

  // TextEditingController? yearExp = TextEditingController();
  // TextEditingController? monthExp = TextEditingController();
  TextEditingController? industryType = TextEditingController();
  TextEditingController? pincode = TextEditingController();
  TextEditingController? dobController = TextEditingController();
  TextEditingController? wrkingStatus = TextEditingController();
  TextEditingController? currCTC = TextEditingController();
  TextEditingController? currComp = TextEditingController();
  TextEditingController? alternateNum = TextEditingController();
  TextEditingController? currDesignation = TextEditingController();
  TextEditingController? noticePeriod = TextEditingController();
  TextEditingController? expCtc = TextEditingController();
  TextEditingController? prefferedLocation = TextEditingController();
  TextEditingController? totalExp = TextEditingController();
  TextEditingController? tenureInCurrentCompany = TextEditingController();
  TextEditingController? fieldSalesExperience = TextEditingController();
  TextEditingController? candStatus = TextEditingController();
  TextEditingController? offerStatus = TextEditingController();
  TextEditingController? candPanNo = TextEditingController();

  // TextEditingController? uploadStatus = TextEditingController();
  // TextEditingController? uploadedDate = TextEditingController();
  TextEditingController? channel = TextEditingController();

  TextEditingController? cityTextController = TextEditingController();
  TextEditingController? districtTextController = TextEditingController();
  TextEditingController? stateTextController = TextEditingController();

  // TextEditingController? lineUpDate = TextEditingController();
  // String lineUpDateForApi = "";
  String dobForApi = "";
  GlobalKey<FormState>? formKey;

  String uploadDateForApi = "";

  TextEditingController? feedback = TextEditingController();

  TextEditingController? joiningDate = TextEditingController();
  String joiningDateForApi = "";

  TextEditingController? package = TextEditingController();
  TextEditingController? employeeCode = TextEditingController();
  TextEditingController? joinedComp = TextEditingController();
  TextEditingController? selectedForComp = TextEditingController();
  TextEditingController? coolingPeriod = TextEditingController();
  TextEditingController? zone = TextEditingController();
  TextEditingController? regionalHr = TextEditingController();
  TextEditingController? zonalHr = TextEditingController();

  TextEditingController? branchLocation = TextEditingController();
  TextEditingController? remark = TextEditingController();
  TextEditingController? internalStatus = TextEditingController();
  int? rfId;

  // saveLineUpDateForApi(String date) {
  //   lineUpDateForApi = date;
  // }

  savejoiningDateForApi(String date) {
    joiningDateForApi = date;
  }

  File? resume;
  bool isEditing = false;
  List<String> candStatusList = [
    'Interested',
    'Not Insterested',
    'Call back in a week',
    'Not Reachable'
  ];

  List<String> uploadStatusList = [
    "Duplicate",
    "Uploaded",
  ];

  List<String> educafieldSalesExperienceList = [
    "0",
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  List<String> channelList = [
    "Agency",
    "Banca",
    " Direct / CAT / Sparc",
    "APC",
    "IMF",
    "Tele Sales",
    "FIG",
    "Elite",
    "Defence",
    "Broca",
    "Others"
  ];
  List<String> internalStatusList = [
    "Open",
    "With Admin",
    "With Zonal Manager",
    "With Manager",
    "With Team Lead",
    "With HR",
    "Closed"
  ];
  List<String> educationItems = ['10th', '12th', 'Graduation', 'Masters'];
  List<String> workingStatusList = [
    "Yes",
    "No",
  ];

  List<String> interViewStatusList = [
    'Attended',
    'Not Attended',
    'Need To Attend Again'
  ];

  List<String> selectionStatusList = ['Pending', 'Yes', 'No', 'Hold'];
  List<String> docStatusList = [
    "Shared to Company",
    "Pending",
    "Dropped",
  ];

  List<String> offStatusList = ['Pending', 'Yes', 'No', 'Hold'];

  clearControllers() {
    // lineUpDateForApi = "";

    dobForApi = "";
    uploadDateForApi = "";
    joiningDateForApi = "";
    // lineUpDate?.clear();

    offerStatus?.clear();
  }

  update() async {
    if (!formKey!.currentState!.validate()) {
      return;
    }

    print(firstNameTextController.text);

    formKey?.currentState!.save();
    print(dobForApi);

    Ticket ticket = Ticket(
      rfId: widget.ticket.rfId,
      rfMmbrId: widget.ticket.rfMmbrId,
      rfUsrId: widget.ticket.rfUsrId,
      rfCandName: firstNameTextController.text,
      rfResume: widget.ticket.rfResume,
      rfMob: phoneTextController.text,
      rfCategory: jobCategory?.text,
      rfEducation: education?.text,
      rfLocation: location.text,
      rfEmail: email?.text,
      rfIndustry: industryType?.text,
      rfDob: dobForApi,
      rfPincode: pincode?.text,
      rfWrkingSts: wrkingStatus?.text,
      rfCmpnyName: currComp?.text,
      rfCrntCtc: currCTC?.text,
      rfNotice: noticePeriod?.text,
      rfCrntDesg: currDesignation?.text,
      rfExpectedCtc: expCtc?.text,
      rfTtlExp: totalExp?.text,
      rfCity: cityTextController?.text,
      rfDist: districtTextController?.text,
      rfState: stateTextController?.text,
      rfSts: widget.ticket.rfSts,
      hrTenureCrntCmpny: tenureInCurrentCompany?.text,
      hrSalesExp: fieldSalesExperience?.text,
      hrUsrSts: candStatus?.text,
      hrUsrPan: candPanNo?.text,
      hrUsrChannel: channel?.text,
      rfAlternateMob: alternateNum?.text,
      rfLocality: locality?.text,
      rfPreferredLoc: prefferedLocation?.text,
      rfFeedback: feedback?.text,
      rfCooling: coolingPeriod?.text,
      rfBrLocation: branchLocation?.text,
      rfZone: zone?.text,
      hrInternalSts: internalStatus?.text,
      rfRemark: remark?.text,
    );

    try {
      if(widget.member==null){
        await Provider.of<TicketUpdateLineUpProvider>(context, listen: false)
            .updateTicket(ticket: ticket, context: context, path: widget.path);
      }else{
        await Provider.of<TicketUpdateLineUpProvider>(context, listen: false)
            .updateTicket(ticket: ticket, context: context, path: widget.path,member: widget.member);
      }

      // Navigator.of(context).pop();
    } catch (e) {
      print("could not update");
      print(e);
    } finally {
      setState(() {
        isEditing = false;
      });
    }
  }


  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    rfId = widget.ticket.rfId;
    firstNameTextController.text = widget.ticket.rfCandName ?? "";
    phoneTextController.text = widget.ticket.rfMob ?? "";
    alternateNum?.text = widget.ticket.rfAlternateMob ?? "";
    location.text = widget.ticket.rfLocation ?? "";
    locality?.text = widget.ticket.rfLocality ?? "";
    pincode?.text = widget.ticket.rfPincode ?? "";
    cityTextController?.text = widget.ticket.rfCity ?? "";
    districtTextController?.text = widget.ticket.rfDist ?? "";
    stateTextController?.text = widget.ticket.rfState ?? "";
    email?.text = widget.ticket.rfEmail ?? "";
    candPanNo?.text = widget.ticket.hrUsrPan ?? "";
    totalExp?.text = widget.ticket.rfTtlExp ?? "";
    tenureInCurrentCompany?.text = widget.ticket.hrTenureCrntCmpny ?? "";
    wrkingStatus?.text = widget.ticket.rfWrkingSts ?? "";
    currComp?.text = widget.ticket.rfCmpnyName ?? "";
    currCTC?.text = widget.ticket.rfCrntCtc ?? "";
    currDesignation?.text = widget.ticket.rfCrntDesg ?? "";
    noticePeriod?.text = widget.ticket.rfNotice ?? "";
    expCtc?.text = widget.ticket.rfExpectedCtc ?? "";
    prefferedLocation?.text = widget.ticket.rfPreferredLoc ?? "";
    feedback?.text = widget.ticket.rfFeedback ?? "";
    remark?.text = widget.ticket.rfRemark ?? "";
    coolingPeriod?.text = widget.ticket.rfCooling ?? "";
    branchLocation?.text = widget.ticket.rfBrLocation ?? "";
    //drop down initialize
    jobCategory?.text = widget.ticket.rfCategory ?? "";
    education?.text = widget.ticket.rfEducation ?? "";
    fieldSalesExperience?.text = widget.ticket.hrSalesExp ?? "";
    zone?.text = widget.ticket.rfZone ?? "";
    candStatus?.text = widget.ticket.hrUsrSts ?? "";
    internalStatus?.text = widget.ticket.hrInternalSts ?? "";
    // internalStatus?.text = widget.ticket.hrInternalSts ?? "";
    // offerStatus?.text = widget.ticket.hr ?? "";

    industryType?.text = widget.ticket.rfIndustry ?? "";
    channel?.text = widget.ticket.hrUsrChannel ?? "";

    print("dob");
    print(widget.ticket?.rfDob!);


    //
    if(widget.ticket?.rfDob!=""){
      DateTime dt = DateTime.parse(
          widget.ticket!.rfDob!);
      print(dt);
      String dob =
      DateFormat('dd-MM-yyyy')
          .format(dt);
      dobController?.text = dob;
      String initDateForApi =  DateFormat('yyyy-MM-dd')
          .format(dt);
      dobForApi = initDateForApi;


    }
    // dobController?.text=widget.ticket.rfDob??"";
    //   DateTime dt = DateTime.parse(
    //       widget.ticket!.rfDob!);
    //   print(dt);
    //   String dob =
    //   DateFormat('dd-MM-yyyy')
    //       .format(dt);
    // print(dob);
    //   dobController?.text = dob;

    super.initState();
    print("industry type");
    print(industryType?.text);
    print("rf id");
    print(rfId);

    Provider.of<TicketUpdateLineUpProvider>(context, listen: false)
        .getLineUpList(rfId: rfId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ticket Details"),
          leading: Consumer<TicketUpdateLineUpProvider>(builder: (context,value,child){
            return IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined),onPressed: (){
              value.onPop();
              Navigator.of(context).pop();
          },);}),

          actions: [
            IconButton(
                onPressed: () {
                  if(isEditing==false){
                    setState(() {
                      isEditing = !isEditing;
                    });

                  }else if(isEditing==true){
                    update();
                    setState(() {
                      isEditing = !isEditing;
                    });
                  }

                },
                icon: isEditing
                    ? const Icon(
                        Icons.save,
                      )
                    : const Icon(
                        Icons.edit,
                      )),
          ],
        ),
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
            CustomButton2(
              text: "Line Up for Company",
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LineupForComapnyScreen(
                    appBarActBut: false,
                    isEditing: true,
                    rfId: widget.ticket.rfId, isCustomBut: true,
                    // ticket: widget.ticket,
                  );
                }));
              },
            ),

            SizedBox(
              height: context.percentHeight * 2,
            ),
            Consumer<TicketUpdateLineUpProvider>(
              builder: (context, value, child) {
                if (value.isloadinglist) {
                  return CircularProgressIndicator();
                } else {
                  if (value.lineUpComList.isNotEmpty) {
                    return ListView.builder(itemCount: value.lineUpComList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                      AddLineUp comp = value.lineUpComList[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LineupForComapnyScreen(
                              lineUpDetails: comp,
                              rfId: widget.ticket.rfId,
                              isEditing: true,
                              appBarActBut: true,
                              isCustomBut: false,
                              // ticket: widget.ticket,
                            );
                          }));
                        },
                        child : CustomTicketLineUpTile(title: comp.ln_cmpny?.toUpperCase()??"",
                        subTitle: comp.ln_desg??"",
                        trailing: ""),
                        // ListTile(
                        //   subtitle: Text(comp.ln_cmpny??""),
                        //     title: Text(comp.ln_id.toString() ?? "Comp Name",style: TextStyle(color: Colors.blue),)),
                      );
                    });
                  } else if (value.lineUpComList.isEmpty) {
                    return Text("No Line Up Company");
                  } else {
                    return Text("abc");
                  }
                }
              },
            ),
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
            buildFormPersonalDetails(),
            buildFormEducationalDetails(),
            buildFormProfessionalDetails(),
            buildFormGeneralDetails(),
            // if (isEditing == true)
            //   CustomButton2(onTap: update, text: AppStrings.updateTicket),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildFormPersonalDetails() {
    return SingleChildScrollView(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            "Candidate's Personal Details",
            style: MyTextStyle.subHeadings,
          ),
        ],
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        assets: Icons.person,
        controller: firstNameTextController,
        text: AppStrings.fullName,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        assets: Icons.phone,
        controller: phoneTextController,
        text: AppStrings.mobile,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        assets: Icons.phone,
        controller: alternateNum,
        text: AppStrings.alternateMobile,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        controller: location,
        text: AppStrings.location,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      CustomDateInputField(
        isReadOnly: !isEditing,
        labelText: "Date Of Birth",
        controller: dobController,
        saveDateFuncForApi: (va) {
          dobForApi = va;
        },
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        controller: locality,
        text: AppStrings.locality,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
          isReadOnly: !isEditing,
          controller: pincode,
          text: AppStrings.pincode),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        // assets: Icons.person,
        controller: cityTextController,
        text: AppStrings.city,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        controller: districtTextController,
        text: AppStrings.dist,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        controller: stateTextController,
        text: AppStrings.state,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        controller: email,
        text: AppStrings.email,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
          isReadOnly: !isEditing,
          controller: candPanNo,
          text: AppStrings.candPanNo),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      // CustomDropDownFormButton(
      //   items: uploadStatusList,
      //   selectedOptionController: uploadStatus,
      //   text: AppStrings.uploadStatus,
      // ),
      // SizedBox(
      //   height: context.percentHeight * 2,
      // ),
      // CustomDateInputField(
      //   labelText: "Upload Date",
      //   controller: uploadedDate,
      //   saveDateFuncForApi: (va) {
      //     uploadDateForApi = va;
      //   },
      // ),
      // SizedBox(
      //   height: context.percentHeight * 2,
      // ),
    ]));
  }

  SingleChildScrollView buildFormEducationalDetails() {
    return SingleChildScrollView(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            "Candidate's Educational Details",
            style: MyTextStyle.subHeadings,
          ),
        ],
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      CustomDropDownFormButton(
        isReadOnly: !isEditing,
        dropDownIntialVAlue: education?.text == "" ? null : education?.text,
        items: educationItems,
        text: AppStrings.education,
        selectedOptionController: education,
      ),

      // ReadOnlyTextField(
      //   isReadOnly: !isEditing,
      //   // assets: Icons.person,
      //   controller: education,
      //   text: AppStrings.education,
      // ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
    ]));
  }

  SingleChildScrollView buildFormProfessionalDetails() {
    return SingleChildScrollView(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            "Candidate's Professional Details",
            style: MyTextStyle.subHeadings,
          ),
        ],
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),

      ReadOnlyTextField(
        isReadOnly: !isEditing,
        // assets: Icons.person,
        controller: jobCategory,
        text: AppStrings.jobCategory,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      // Consumer<TicketProvider>(
      //   builder: (context, value, child) {
      //     return CustomDropDownFormButton(
      //     isReadOnly: !isEditing,
      //       dropDownIntialVAlue: jobCategory?.text == "" ? null: industryType?.text,
      //       items: value.getJobsList,
      //       text: AppStrings.jobCategory,
      //       selectedOptionController: jobCategory,
      //     );
      //   },
      // ),
      // SizedBox(
      //   height: context.percentHeight * 2,
      // ),
      // ReadOnlyTextField(
      //   isReadOnly: !isEditing,
      //   // assets: Icons.person,
      //   controller: industryType,
      //   text: AppStrings.industryType,
      // ),
      SizedBox(
        height: context.percentHeight * 2,
      ),

      Consumer<TicketProvider>(
        builder: (context, value, child) {
          return CustomDropDownFormButton(
            isReadOnly: !isEditing,
            dropDownIntialVAlue:
                industryType?.text == "" ? null : industryType?.text,
            items: value.getIndustriesListNames,
            text: AppStrings.selectIndustryType,
            selectedOptionController: industryType,
          );
        },
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        controller: totalExp,
        text: AppStrings.totalExperienceinMonths,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      CustomDropDownFormButton(
        isReadOnly: !isEditing,
        dropDownIntialVAlue: fieldSalesExperience?.text == ""
            ? null
            : fieldSalesExperience?.text,
        items: educafieldSalesExperienceList,
        text: AppStrings.fieldSalesExperience,
        selectedOptionController: fieldSalesExperience,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        controller: tenureInCurrentCompany,
        text: AppStrings.tenureInCurrentCompany,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),

      // ReadOnlyTextField(
      //   isReadOnly: !isEditing,
      //   controller: wrkingStatus,
      //   text: AppStrings.wrkSts,
      // ),

          CustomDropDownFormButton(
            isReadOnly: !isEditing,
            dropDownIntialVAlue: wrkingStatus?.text == ""
                ? null
                : wrkingStatus?.text,
            items: workingStatusList,
            text: AppStrings.wrkSts,
            selectedOptionController: wrkingStatus,
          ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      Column(
        children: [
          ReadOnlyTextField(
            isReadOnly: !isEditing,
            controller: currComp,
            text: AppStrings.currentCompanyName,
          ),
          SizedBox(
            height: context.percentHeight * 2,
          ),
          ReadOnlyTextField(
            isReadOnly: !isEditing,
            controller: currDesignation,
            text: AppStrings.currentDesignation,
          ),
          SizedBox(
            height: context.percentHeight * 2,
          ),
          ReadOnlyTextField(
            isReadOnly: !isEditing,
            controller: currCTC,
            text: AppStrings.currentCTC,
          ),
          SizedBox(
            height: context.percentHeight * 2,
          ),
          ReadOnlyTextField(
            isReadOnly: !isEditing,
            controller: noticePeriod,
            text: AppStrings.noticePeriod,
          ),
          SizedBox(
            height: context.percentHeight * 2,
          ),

          ReadOnlyTextField(
            isReadOnly: !isEditing,
            controller: expCtc,
            text: AppStrings.expectedCTC,
          ),

          // ReadOnlyTextField(
          //   controller: ,
          //   text: AppStrings.fullName,
          // ),
          SizedBox(
            height: context.percentHeight * 2,
          ),
          ReadOnlyTextField(
            isReadOnly: !isEditing,
            controller: prefferedLocation,
            text: AppStrings.preferedLocation,
          ),

          // ReadOnlyTextField(
          //   controller: ,
          //   text: AppStrings.fullName,
          // ),
          SizedBox(
            height: context.percentHeight * 2,
          ),
        ],
      ),
    ]));
  }

  SingleChildScrollView buildFormGeneralDetails() {
    return SingleChildScrollView(
        child: Column(children: [
      Text("Other Details"),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        controller: feedback,
        text: AppStrings.feedback,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
        isReadOnly: !isEditing,
        controller: remark,
        text: AppStrings.remark,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
          isReadOnly: !isEditing,
          controller: coolingPeriod,
          text: AppStrings.coolingPeriod),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      CustomDropDownFormButton(
          isReadOnly: !isEditing,
          dropDownIntialVAlue: zone?.text == "" ? null : zone?.text,
          // validator: (value) =>
          // value == null
          //     ? AppStrings.zone
          //
          //     : null,
          text: AppStrings.zone,
          items: const [
            'North',
            'South',
            'East',
            'West',
          ],
          selectedOptionController: zone),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      CustomDropDownFormButton(
        isReadOnly: !isEditing,
        dropDownIntialVAlue: candStatus?.text == "" ? null : candStatus?.text,
        items: candStatusList,
        selectedOptionController: candStatus,
        text: AppStrings.candStatus,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      CustomDropDownFormButton(
        dropDownIntialVAlue: channel?.text == "" ? null : channel?.text,
        isReadOnly: !isEditing,
        items: channelList,
        selectedOptionController: channel,
        text: AppStrings.channel,
      ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      // CustomDropDownFormButton(
      //   isReadOnly: !isEditing,
      //   dropDownIntialVAlue: internalStatus?.text == "" ? null: internalStatus?.text,
      //   items: internalStatusList,
      //   selectedOptionController: internalStatus,
      //   text: AppStrings.internalStatus,
      // ),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
          isReadOnly: !isEditing,
          controller: joinedComp,
          text: AppStrings.joinedCompany),
      SizedBox(
        height: context.percentHeight * 2,
      ),
      ReadOnlyTextField(
          isReadOnly: !isEditing,
          controller: branchLocation,
          text: AppStrings.branchLocation),

      SizedBox(
        height: context.percentHeight * 2,
      ),

      Divider(),
    ]));
  }
}
