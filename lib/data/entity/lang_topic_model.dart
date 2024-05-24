import 'dart:convert';

List<LangTopicItem> meteoTopicModelFromJson(String str) =>
    List<LangTopicItem>.from(
        json.decode(str).map((x) => LangTopicItem.fromMap(x)));

String meteoTopicModelToJson(List<LangTopicItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class LangTopicItem {
  String? id;
  String title;
  String description;
  String imageUrl;
  String imageUrlSecond;

  LangTopicItem({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.imageUrlSecond,
  });

  // Firebase'dan kelgan ma'lumotlarni konvertatsiya qilish uchun
  factory LangTopicItem.fromMap(Map<String, dynamic> data) {
    return LangTopicItem(
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
