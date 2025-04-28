import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:equatable/equatable.dart';

abstract class CreateTopicEvent extends Equatable {
  const CreateTopicEvent();

  @override
  List<Object?> get props => [];
}

class PickImageEvent extends CreateTopicEvent {}

class CreateTopic extends CreateTopicEvent {
  final String chapterId;
  final TopicModel topic;

  CreateTopic({required this.chapterId, required this.topic});
}
