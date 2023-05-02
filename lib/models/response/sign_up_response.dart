class SignUpResponse {
  bool? error;
  String? message;


  SignUpResponse(
      {required this.error,
      required this.message,
      });

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];

  }}