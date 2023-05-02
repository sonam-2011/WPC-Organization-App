// To parse this JSON data, do
//
//     final welcomeScreenIcwImages = welcomeScreenIcwImagesFromJson(jsonString);

import 'dart:convert';

List  welcomeScreenIcwImagesFromJson(String str) => json.decode(str) == null ? [] : List<WelcomeScreenIcwImages?>.from(json.decode(str)!.map((x) => WelcomeScreenIcwImages.fromJson(x)));

String welcomeScreenIcwImagesToJson(List<WelcomeScreenIcwImages?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class WelcomeScreenIcwImages {
  WelcomeScreenIcwImages({
    this.id,
    this.image,
  });

  final int? id;
  final String? image;

  factory WelcomeScreenIcwImages.fromJson(Map<String, dynamic> json) => WelcomeScreenIcwImages(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}