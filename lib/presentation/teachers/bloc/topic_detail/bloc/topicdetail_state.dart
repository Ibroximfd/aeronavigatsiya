import 'package:aeronavigatsiya/data/entity/topic_model.dart';
import 'package:equatable/equatable.dart';

abstract class TopicDetailState extends Equatable {
  const TopicDetailState();

  @override
  List<Object?> get props => [];
}

class TopicDetailLoading extends TopicDetailState {}

class TopicDetailLoadedHtml extends TopicDetailState {
  final String contentHtml;
  final TopicModel topic;

  const TopicDetailLoadedHtml({required this.contentHtml, required this.topic});

  @override
  List<Object?> get props => [contentHtml, topic];
}

class TopicDetailError extends TopicDetailState {
  final String message;

  const TopicDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
