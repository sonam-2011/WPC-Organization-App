class VerifyOtp {
  int? id;
  String? mobile;
  String? username;
  String? sts;
  String? message;



  VerifyOtp({
    required this.id,
    required  this.mobile,
    required  this.username,
    required  this.sts,
    required  this.message,
  });

  VerifyOtp.fromJson(Map<String, dynamic> json) {
    id=  json["id"];
    mobile = json["mobile"];
    username =  json["username"];
    sts =  json["sts"];
    message = json["message"];}

  }

