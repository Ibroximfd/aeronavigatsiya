class TopicModel {
  final String id;
  final String title;
  final String imageUrl;
  final String content;
  final DateTime? createdAt;

  TopicModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    this.createdAt,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json, {required String id}) {
    return TopicModel(
      id: id,
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      content: json['content'] ?? '',
      createdAt: null,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'imageUrl': imageUrl,
        'content': content,
      };

  // ✅ copyWith qo'shildi
  TopicModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? content,
    DateTime? createdAt,
  }) {
    return TopicModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
