import 'package:flutter/material.dart';

import '../../../api/api_client.dart';

import '../model/welcome_screen_images.dart';

class WlcomeScreenImagesWidget extends StatefulWidget {
  const WlcomeScreenImagesWidget({Key? key}) : super(key: key);

  @override
  State<WlcomeScreenImagesWidget> createState() =>
      _WlcomeScreenImagesWidgetState();
}

class _WlcomeScreenImagesWidgetState extends State<WlcomeScreenImagesWidget> {
  late Future<List<WelcomeScreenIcwImages>?> loadedImages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadedImages = getImages();
  }

  Future<List<WelcomeScreenIcwImages>?> getImages() async {
    var imageeList = await ApiClient.loadImagesList();
    return imageeList;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heigh = size.height;
    final wid = size.width;
    return Container(
      width: wid,
      height: wid > heigh ? heigh * 0.5 : heigh * 0.3,
      child: FutureBuilder(
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Container(
                  // height: heigh * 0.25,
                  // width: wid * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                final data = snapshot.data as List<WelcomeScreenIcwImages>;
                return ListView.builder(
                    shrinkWrap: true,
                    // itemExtent: size.width * 0.8,
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(

                        // color: Colorrs.blue,
                        width: wid,
                        height: wid > heigh ? heigh * 0.5 : heigh * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.network(
                            data[index].image ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    });
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },

          // Future that needs to be resolved
          // inorder to display something on the Canvas
          future: loadedImages),
    );
  }
}
