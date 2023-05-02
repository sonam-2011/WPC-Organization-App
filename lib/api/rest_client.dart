import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class RestClient {
  //----------------------------------------------------------- Singleton-Instance ------------------------------------------------------------------
  // Singleton Instance ( iska instance vo ek bar hi create hoga)
  static final RestClient _instance = RestClient.internal();

  // singleton class
  /// RestClient Private Constructor -> NetworkUtil
  /// @param -> _
  /// @usage -> Returns the instance of NetworkUtil class
  RestClient.internal();

  /// RestClient Factory Constructor -> NetworkUtil
  /// @dependency -> _
  /// @usage -> Returns the instance of NetworkUtil class
  factory RestClient() => _instance;

  //------------------------------------------------------------- Variables ---------------------------------------------------------------------------
  // JsonDecoder object
  final JsonDecoder _decoder = const JsonDecoder();

  //------------------------------------------------------------- Methods -----------------------------------------------------------------------------


  Future<dynamic> get(
      {required String url, Map<String, String>? headers}) async {
    headers ??= {};

    return http
        .get(Uri.parse(url), headers: headers) // Make HTTP-GET request
        .then((http.Response response) {
      // On response received
      // Get response status code
      final int statusCode = response.statusCode;
      print('get $url -> ${response.statusCode}');
      // Check response status code for error condition

      if (statusCode < 200 || statusCode > 499) {
        // Error occurred
        throw Exception("Error while fetching data");
      } else {
        // No error occurred
        // Get response body
        final String res = utf8.decode(response.bodyBytes);
        print('Response ->$res');
        // Convert response body to JSON object
        return _decoder.convert(res);
      }
    }, onError: (dynamic error) {
      if (error != null && error is Exception) {
        throw error;
      } else {
        return null;
      }
    });
  }
  Future<dynamic> post({required String url, required FormData data}) async {
    var dio = Dio();
    var response = await dio.post(url, data: data);

    print(response.data);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.data.toString()) as Map<String, dynamic>;
      print(jsonData);
      bool resMessage = jsonData["error"];

      print(resMessage);
      if (resMessage == false) {
        return jsonData;
      } else {
        print("rest  client error called");

        // Error occurred
        throw Exception(jsonData["message"]);
      }
    }
  }
  //2  called in initstate of otpScreens

  Future<String> otpMesGateway({required Map<String, String> queryParameter,
    required String url,
    Map<String, String>? headers}) async {
    headers ??= {};

    var _dio = Dio();


    Map<String, String> qParams = queryParameter;

    var response = await _dio.post(url, queryParameters: qParams);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.data);

      return "mes gateway Api called Successfully";
    } else {
      print("rest  client error called");

      // Error occurred
      throw Exception('no mes send');
    }
  }
  //3 api called on verifyotp button on otpscreen

  Future<dynamic> otpVerifyButtonApi(
      {required String url, required FormData data}) async {
    var dio = Dio();
    var response = await dio.post(url, data: data);

    print(response.data);
    var jsonData = jsonDecode(response.toString()) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      print(jsonData);

      return jsonData;
    }
    else {
      print("rest  client error called");

      // Error occurred
      throw Exception(jsonData["message"]);
    }
  }
  Future<dynamic> postResendOtpButton({required String url, required FormData data}) async {
    var dio = Dio();
    var response = await dio.post(url, data: data);

    print(response.data);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.toString()) as Map<String, dynamic>;
      String resMessage = jsonData["message"]!;
      print('printing in rest client');
      print(resMessage);
      if (resMessage == "OTP sent to your mobile number") {
        return resMessage;
      } else {
        print("rest  client error called");

        // Error occurred
        throw Exception(resMessage);
      }
    }
  }


  Future<dynamic> changePassword({required String url, required FormData data}) async {
    var dio = Dio();
    var response = await dio.post(url, data: data);

    print(response.data);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.toString()) as Map<String, dynamic>;
      String resMessage = jsonData["message"];
      print(resMessage);
      if (resMessage == "Password changed successfully!") {
        return resMessage;
      } else {
        print("changePassword rest client error");

        // Error occurred
        throw Exception(resMessage);
      }
    }
  }

  Future<dynamic> postVerifyOtpToUpdate({required String url, required FormData data}) async {
    var dio = Dio();
    var response = await dio.post(url, data: data);

    print(response.data);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.toString()) as Map<String, dynamic>;
      String resMessage = jsonData["message"];
      print(resMessage);
      if (resMessage == "OTP sent to your mobile number") {
        return resMessage;
      } else {
        print("rest  client error called");

        // Error occurred
        throw Exception(jsonData["message"]);
      }
    }
  }

  Future<dynamic> postMethod({required String url, required FormData data}) async {
    var dio = Dio();
    var response = await dio.post(url, data: data);

    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {


      var jsonData = jsonDecode(response.data.toString()) ;



      return jsonData;
    }
       else {
        print("rest  client error called");

        // Error occurred
        throw Exception("An Error Occurred");
      }
    }
  }





/// Get Method -> Future<dynamic>

/// @param -> @required url -> String
/// @usage -> Make HTTP-GET request to specified URL and returns the response in JSON format


//
//  Future<dynamic> postWelcomeScreenFormData(
//      {required String url, required FormData data}) async {
//    var dio = Dio();
//    var response = await dio.post(url, data: data);
//
//    print(response.data);
//
//    if (response.statusCode == 200) {
//      if (response.data.isNotEmpty) {
//        var jsonData = json.decode(response.data)
//
//        as Map<String, dynamic>;
//        String resMessage = jsonData["message"];
//        print(resMessage);
//        if (resMessage == "Amount added Successfully") {
//          return jsonData;
//        } else {
//          print("rest  client error called");
//
//          // Error occurred
//          throw Exception(jsonData["message"]);
//        }
//      }
//    }
//  }
//
//  Future<dynamic> postClubSubFee(
//      {required String url, required FormData data}) async {
//    var dio = Dio();
//    var response = await dio.post(url, data: data);
//
//    print(response.data);
//
//    if (response.statusCode == 200) {
//      if (response.data.isNotEmpty) {
//        var jsonData = json.decode(response.data)
//
//        as Map<String, dynamic>;
//        String resMessage = jsonData["message"];
//        print(resMessage);
//        if (resMessage == "Amount added successfully!") {
//          return jsonData;
//        } else {
//          print("rest  client error called");
//
//          // Error occurred
//          throw Exception(jsonData["message"]);
//        }
//      }
//    }
//  }
//
//  Future<dynamic> postProjDetails(
//      {required String url, required FormData data}) async {
//    var dio = Dio();
//    var response = await dio.post(url, data: data);
//
//    print(response.data);
//
//    if (response.statusCode == 200) {
//      if (response.data.isNotEmpty) {
//        var jsonData = json.decode(response.data)
//
//        as Map<String, dynamic>;
//        String resMessage = jsonData["message"];
//        print(resMessage);
//        if (resMessage == "Project added successfully!") {
//          return jsonData;
//        } else {
//          print("rest  client error called");
//
//          // Error occurred
//          throw Exception(jsonData["message"]);
//        }
//      }
//    }
//  }
//
//  Future<dynamic> postFdDetails(
//      {required String url, required FormData data}) async {
//    var dio = Dio();
//    var response = await dio.post(url, data: data);
//
//    print(response.data);
//
//    if (response.statusCode == 200) {
//      if (response.data.isNotEmpty) {
//        var jsonData = json.decode(response.data)
//
//        as Map<String, dynamic>;
//        String resMessage = jsonData["message"];
//        print(resMessage);
//        if (resMessage == "FD added successfully!") {
//          return jsonData;
//        } else {
//          print("rest  client error called");
//
//          // Error occurred
//          throw Exception(jsonData["message"]);
//        }
//      }
//    }
//  }
//
//  Future<dynamic> fdData(
//      {required String url, required FormData data}) async {
//    var dio = Dio();
//    var response = await dio.post(url, data: data);
//
//    print(response.data);
//
//    if (response.statusCode == 200) {
//      if (response.data.isNotEmpty) {
//        var jsonData = json.decode(response.data)
//
//        as Map<String, dynamic>;
//
//          return jsonData;
//        } else {
//          print("rest  client error called");
//
//          // Error occurred
//          throw Exception("An error occured while fetching fd data");
//        }
//      }
//    }
//
//  Future<dynamic> financeData(
//      {required String url, required FormData data}) async {
//    var dio = Dio();
//    var response = await dio.post(url, data: data);
//
//    print(response.data);
//
//    if (response.statusCode == 200) {
//      if (response.data.isNotEmpty) {
//        var jsonData = json.decode(response.data)
//
//        as List;
//        // String resMessage = jsonData["message"];
//        // print(resMessage);
//
//        return jsonData;
//      }
//    } else {
//      print("rest  client error called");
//
//      // Error occurred
//      throw Exception("error occurred in getting data");
//    }
//  }
//
//
//  Future<dynamic> postClubId(
//      {required String url, required FormData data}) async {
//    var dio = Dio();
//    var response = await dio.post(url, data: data);
//
//    print(response.data);
//
//    if (response.statusCode == 200) {
//      var jsonData = jsonDecode(response.toString()) as Map<String, dynamic>;
//      if (jsonData.isNotEmpty) {
//        return jsonData;
//      } else {
//        print("rest  client error in pos club id method called");
//
//        // Error occurred
//        throw Exception("Could not complete task");
//      }
//    }
//  }
