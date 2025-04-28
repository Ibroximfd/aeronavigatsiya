part of 'library_bloc.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

class CreateChapterEvent extends LibraryEvent {
  final ChapterModel chapter;

  const CreateChapterEvent(this.chapter);

  @override
  List<Object?> get props => [chapter];
}

class PickChapterImageEvent extends LibraryEvent {}

class UpdateTopicEvent extends LibraryEvent {
  final String chapterId;
  final TopicModel topic;

  const UpdateTopicEvent({required this.chapterId, required this.topic});

  @override
  List<Object?> get props => [chapterId, topic];
}

class DeleteTopicEvent extends LibraryEvent {
  final String chapterId;
  final String topicId;

  const DeleteTopicEvent({required this.chapterId, required this.topicId});

  @override
  List<Object?> get props => [chapterId, topicId];
}

class FetchChaptersEvent extends LibraryEvent {}

class DeleteChapterEvent extends LibraryEvent {
  final String chapterId;
  DeleteChapterEvent(this.chapterId);
}

class UpdateChapterEvent extends LibraryEvent {
  final ChapterModel chapter;
  UpdateChapterEvent(this.chapter);
}
