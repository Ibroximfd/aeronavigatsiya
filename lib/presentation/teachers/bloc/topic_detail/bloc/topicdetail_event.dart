import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:equatable/equatable.dart';

abstract class TopicDetailEvent extends Equatable {
  const TopicDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadTopicDetail extends TopicDetailEvent {
  final TopicModel topic;

  const LoadTopicDetail(this.topic);

  @override
  List<Object> get props => [topic];
}
