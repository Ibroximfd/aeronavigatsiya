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
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
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
  final String topicImage; // Asosiy rasm
  final String detailImage; // Tafsilot rasmi

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

  factory Datum.fromJson(Map<String, dynamic> json) {
    // `images` null emasligini va ro‘yxat ekanligini tekshiramiz
    List<dynamic> images = (json["images"] is List) ? json["images"] : [];

    return Datum(
      id: json["id"] ?? 0,
      createdAt: json["created_at"] ?? 0,
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      topicImage: images.isNotEmpty ? images[0] : "", // 1-rasm yoki bo‘sh
      detailImage: images.length > 1 ? images[1] : "", // 2-rasm yoki bo‘sh
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "title": title,
        "body": body,
        "topicImage": topicImage,
        "detailImage": detailImage,
      };
}
