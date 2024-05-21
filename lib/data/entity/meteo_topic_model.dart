import 'dart:convert';

List<MeteoTopicItem> meteoTopicModelFromJson(String str) =>
    List<MeteoTopicItem>.from(
        json.decode(str).map((x) => MeteoTopicItem.fromMap(x)));

String meteoTopicModelToJson(List<MeteoTopicItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MeteoTopicItem {
  String? id;
  String title;
  String description;
  String imageUrl;
  String imageUrlSecond;

  MeteoTopicItem({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.imageUrlSecond,
  });

  // Firebase'dan kelgan ma'lumotlarni konvertatsiya qilish uchun
  factory MeteoTopicItem.fromMap(Map<String, dynamic> data) {
    return MeteoTopicItem(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      imageUrlSecond: data['imageUrlSecond'],
    );
  }

  // Firebase'ga ma'lumotlarni yozish uchun
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'imageUrlSecond': imageUrlSecond,
    };
  }
}
