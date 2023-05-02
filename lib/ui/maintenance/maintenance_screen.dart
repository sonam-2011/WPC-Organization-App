import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/custom_button2.dart';



class MaintenanceScreen extends StatefulWidget {
  final Map map;

  const MaintenanceScreen({Key? key, required this.map}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: NetworkImage(widget.map['img'])),
                  SizedBox(
                    height:80
                  ),

                  Text(widget.map['desc']),
                  SizedBox(
                    height:80,
                  ),
                  if (widget.map['update'] == "ACTIVE")
                    CustomButton2(
                      onTap: ()async{
                        String url =widget.map['app_link'];
                         var uri = Uri.parse(widget.map['app_link']);
                         if(await canLaunchUrl(uri)){
                           await launch(url,forceSafariVC: true);
                         }
                       },
                      text: "Update",
                    ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
