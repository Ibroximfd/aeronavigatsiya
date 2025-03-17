// To parse this JSON data, do
//
//     final sectionModel = sectionModelFromJson(jsonString);

import 'dart:convert';

SectionModel sectionModelFromJson(String str) =>
    SectionModel.fromJson(json.decode(str));

String sectionModelToJson(SectionModel data) => json.encode(data.toJson());

class SectionModel {
  final List<Datum> data;

  SectionModel({
    required this.data,
  });

  SectionModel copyWith({
    List<Datum>? data,
  }) =>
      SectionModel(
        data: data ?? this.data,
      );

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final String createdAt;
  final String title;
  final String image;

  Datum({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.image,
  });

  Datum copyWith({
    int? id,
    String? createdAt,
    String? title,
    String? image,
  }) =>
      Datum(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
        image: image ?? this.image,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["created_at"].toString(),
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "title": title,
        "image": image,
      };
}
