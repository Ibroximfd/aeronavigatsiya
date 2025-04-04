// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  final List<Datum> data;

  NewsModel({
    required this.data,
  });

  NewsModel copyWith({
    List<Datum>? data,
  }) =>
      NewsModel(
        data: data ?? this.data,
      );

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
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
  final String image;

  Datum({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.image,
  });

  Datum copyWith({
    int? id,
    int? createdAt,
    String? title,
    String? body,
    String? image,
  }) =>
      Datum(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
        body: body ?? this.body,
        image: image ?? this.image,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["created_at"],
        title: json["title"],
        body: json["body"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "title": title,
        "body": body,
        "image": image,
      };
}
