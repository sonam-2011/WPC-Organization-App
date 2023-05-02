// To parse this JSON data, do
//
//     final stats = statsFromJson(jsonString);

import 'dart:convert';

List<Stats> statsFromJson(String str) => List<Stats>.from(json.decode(str).map((x) => Stats.fromJson(x)));

String statsToJson(List<Stats> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stats {
  Stats({
    this.name,
    this.number,
  });

  final String? name;
  final int? number;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    name: json["name"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "number": number,
  };
}
