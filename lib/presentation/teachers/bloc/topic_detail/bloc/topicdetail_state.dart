import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';

abstract class TopicDetailState extends Equatable {
  const TopicDetailState();

  @override
  List<Object?> get props => [];
}

class TopicDetailLoading extends TopicDetailState {}

class TopicDetailLoaded extends TopicDetailState {
  final QuillController controller;
  final TopicModel topic;

  const TopicDetailLoaded({required this.controller, required this.topic});

  @override
  List<Object?> get props => [controller, topic];
}

class TopicDetailError extends TopicDetailState {
  final String message;

  const TopicDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
