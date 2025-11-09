class TopicModel {
  final String id;
  final String title;
  final String imageUrl;
  final String documentUrl; 
  final String fileType; // 'pdf', 'docx', 'doc'
  final DateTime createdAt;

  TopicModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.documentUrl,
    required this.fileType,
    required this.createdAt,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json, {required String id}) {
    return TopicModel(
      id: id,
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      documentUrl: json['documentUrl'] ?? '',
      fileType: json['fileType'] ?? 'pdf',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'imageUrl': imageUrl,
    'documentUrl': documentUrl,
    'fileType': fileType,
    'createdAt': createdAt.toIso8601String(),
  };

  TopicModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? documentUrl,
    String? fileType,
    DateTime? createdAt,
  }) {
    return TopicModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      documentUrl: documentUrl ?? this.documentUrl,
      fileType: fileType ?? this.fileType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
