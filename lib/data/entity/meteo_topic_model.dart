import 'dart:convert';

List<MeteoTopicItem> meteoTopicModelFromJson(String str) =>
    List<MeteoTopicItem>.from(
        json.decode(str).map((x) => MeteoTopicItem.fromMap(x)));

String meteoTopicModelToJson(List<MeteoTopicItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MeteoTopicItem {
  String? id;
  String title;
  String imageUrl;

  MeteoTopicItem({
    this.id,
    required this.title,
    required this.imageUrl,
  });

  // Firebase'dan kelgan ma'lumotlarni konvertatsiya qilish uchun
  factory MeteoTopicItem.fromMap(Map<String, dynamic> data) {
    return MeteoTopicItem(
      id: data['id'],
      title: data['title'],
      imageUrl: data['imageUrl'],
    );
  }

  // Firebase'ga ma'lumotlarni yozish uchun
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}
