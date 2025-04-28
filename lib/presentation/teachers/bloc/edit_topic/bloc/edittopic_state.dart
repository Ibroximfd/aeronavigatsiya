import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditTopicState extends Equatable {
  final String title;
  final Document content;
  final String imageUrl;
  final bool isLoadingImage;
  final bool isSubmitting;
  final bool success;
  final String failureMessage;
  final TopicModel topic;

  const EditTopicState({
    required this.title,
    required this.content,
    required this.imageUrl,
    this.isLoadingImage = false,
    this.isSubmitting = false,
    this.success = false,
    this.failureMessage = '',
    required this.topic,
  });

  EditTopicState copyWith({
    String? title,
    Document? content,
    String? imageUrl,
    bool? isLoadingImage,
    bool? isSubmitting,
    bool? success,
    String? failureMessage,
  }) {
    return EditTopicState(
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      isLoadingImage: isLoadingImage ?? this.isLoadingImage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      success: success ?? this.success,
      failureMessage: failureMessage ?? this.failureMessage,
      topic: topic,
    );
  }

  @override
  List<Object?> get props => [
        title,
        content,
        imageUrl,
        isLoadingImage,
        isSubmitting,
        success,
        failureMessage,
        topic,
      ];
}
