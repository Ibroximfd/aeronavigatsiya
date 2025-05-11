import 'package:aviatoruz/data/entity/chapter_model.dart';
import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:equatable/equatable.dart';

abstract class AKTLibraryEvent extends Equatable {
  const AKTLibraryEvent();

  @override
  List<Object?> get props => [];
}

class AKTCreateChapterEvent extends AKTLibraryEvent {
  final ChapterModel chapter;

  const AKTCreateChapterEvent(this.chapter);

  @override
  List<Object?> get props => [chapter];
}

class AKTPickChapterImageEvent extends AKTLibraryEvent {}

class AKTUpdateTopicEvent extends AKTLibraryEvent {
  final String chapterId;
  final TopicModel topic;

  const AKTUpdateTopicEvent({required this.chapterId, required this.topic});

  @override
  List<Object?> get props => [chapterId, topic];
}

class AKTDeleteTopicEvent extends AKTLibraryEvent {
  final String chapterId;
  final String topicId;

  const AKTDeleteTopicEvent({required this.chapterId, required this.topicId});

  @override
  List<Object?> get props => [chapterId, topicId];
}

class AKTFetchChaptersEvent extends AKTLibraryEvent {}

class AKTDeleteChapterEvent extends AKTLibraryEvent {
  final String chapterId;
  AKTDeleteChapterEvent(this.chapterId);
}

class AKTUpdateChapterEvent extends AKTLibraryEvent {
  final ChapterModel chapter;
  AKTUpdateChapterEvent(this.chapter);
}
