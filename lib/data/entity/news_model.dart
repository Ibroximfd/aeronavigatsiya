import 'dart:convert';

List<NewsModel> meteoTopicModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromMap(x)));

String meteoTopicModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class NewsModel {
  String? id;
  String title;
  String description;
  String imageUrl;

  NewsModel({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  // Firebase'dan kelgan ma'lumotlarni konvertatsiya qilish uchun
  factory NewsModel.fromMap(Map<String, dynamic> data) {
    return NewsModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
    );
  }

  // Firebase'ga ma'lumotlarni yozish uchun
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
