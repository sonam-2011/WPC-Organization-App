class OtpSendMesGateway {
  String? loginId;

  OtpSendMesGateway({required this.loginId});

  OtpSendMesGateway.fromJson(String json) {
    loginId = json;
  }
}
