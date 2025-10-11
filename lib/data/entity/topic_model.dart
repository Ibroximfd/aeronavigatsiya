class TopicModel {
  final String id;
  final String title;
  final String imageUrl;
  final String content; // HTML content from document
  final String documentUrl; // URL of the original document (optional)
  final DateTime createdAt;

  TopicModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.documentUrl,
    required this.createdAt,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json, {required String id}) {
    return TopicModel(
      id: id,
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      content: json['content'] ?? '',
      documentUrl: json['documentUrl'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'imageUrl': imageUrl,
    'content': content,
    'documentUrl': documentUrl,
    'createdAt': createdAt.toIso8601String(),
  };

  TopicModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? content,
    String? documentUrl,
    DateTime? createdAt,
  }) {
    return TopicModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      content: content ?? this.content,
      documentUrl: documentUrl ?? this.documentUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
