// To parse this JSON data, do
//
//     final meteoModel = meteoModelFromJson(jsonString);

import 'dart:convert';

MeteoModel meteoModelFromJson(String str) =>
    MeteoModel.fromJson(json.decode(str));

String meteoModelToJson(MeteoModel data) => json.encode(data.toJson());

class MeteoModel {
  final List<Datum> data;

  MeteoModel({
    required this.data,
  });

  MeteoModel copyWith({
    List<Datum>? data,
  }) =>
      MeteoModel(
        data: data ?? this.data,
      );

  factory MeteoModel.fromJson(Map<String, dynamic> json) => MeteoModel(
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
  final String topicImage;
  final String detailImage;

  Datum({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.topicImage,
    required this.detailImage,
  });

  Datum copyWith({
    int? id,
    int? createdAt,
    String? title,
    String? body,
    String? topicImage,
    String? detailImage,
  }) =>
      Datum(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
        body: body ?? this.body,
        topicImage: topicImage ?? this.topicImage,
        detailImage: detailImage ?? this.detailImage,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["created_at"],
        title: json["title"],
        body: json["body"],
        topicImage: json["topicImage"],
        detailImage: json["detailImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "title": title,
        "body": body,
        "topicImage": topicImage,
        "detailImage": detailImage,
      };
}
