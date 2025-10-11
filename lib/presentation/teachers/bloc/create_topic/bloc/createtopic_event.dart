import 'package:aeronavigatsiya/data/entity/topic_model.dart';

class CreateTopicEvent {}

class CreateTopic extends CreateTopicEvent {
  final String chapterId;
  final TopicModel topic;

  CreateTopic({required this.chapterId, required this.topic});
}
