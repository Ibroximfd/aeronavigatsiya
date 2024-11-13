// To parse this JSON data, do
//
//     final englishModel = englishModelFromJson(jsonString);

import 'dart:convert';

EnglishModel englishModelFromJson(String str) =>
    EnglishModel.fromJson(json.decode(str));

String englishModelToJson(EnglishModel data) => json.encode(data.toJson());

class EnglishModel {
  final List<Datum> data;

  EnglishModel({
    required this.data,
  });

  EnglishModel copyWith({
    List<Datum>? data,
  }) =>
      EnglishModel(
        data: data ?? this.data,
      );

  factory EnglishModel.fromJson(Map<String, dynamic> json) => EnglishModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final int createdAt;
  final String title;
  final String body;
  final List<String> images;

  Datum({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.images,
  });

  Datum copyWith({
    int? id,
    int? createdAt,
    String? title,
    String? body,
    List<String>? images,
  }) =>
      Datum(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
        body: body ?? this.body,
        images: images ?? this.images,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["created_at"],
        title: json["title"],
        body: json["body"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "title": title,
        "body": body,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
