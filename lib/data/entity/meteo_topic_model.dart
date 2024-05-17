class MeteoTopicItem {
  String? id;
  late String title;
  String? createdTime;

  MeteoTopicItem({this.id, required this.title, this.createdTime});

  MeteoTopicItem.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    createdTime = json["createdTime"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "createdTime": createdTime,
    };
  }
}
