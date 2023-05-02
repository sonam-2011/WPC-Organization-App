// To parse this JSON data, do
//
//     final assignTicketResp = assignTicketRespFromJson(jsonString);

import 'dart:convert';

AssignTicketResp assignTicketRespFromJson(String str) => AssignTicketResp.fromJson(json.decode(str));

String assignTicketRespToJson(AssignTicketResp data) => json.encode(data.toJson());

class AssignTicketResp {
  AssignTicketResp({
    this.ttlTicket,
    this.message,
  });

  final int? ttlTicket;
  final String? message;

  factory AssignTicketResp.fromJson(Map<String, dynamic> json) => AssignTicketResp(
    ttlTicket: json["ttl_ticket"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "ttl_ticket": ttlTicket,
    "message": message,
  };
}
