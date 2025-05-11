part of 'library_bloc.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

class CreateChapterEvent extends LibraryEvent {
  final String path;
  final ChapterModel chapter;

  const CreateChapterEvent(this.chapter, this.path);

  @override
  List<Object?> get props => [chapter, path];
}

class PickChapterImageEvent extends LibraryEvent {}

class UpdateTopicEvent extends LibraryEvent {
  final String path;
  final String chapterId;
  final TopicModel topic;

  const UpdateTopicEvent(this.path,
      {required this.chapterId, required this.topic});

  @override
  List<Object?> get props => [chapterId, topic, path];
}

class DeleteTopicEvent extends LibraryEvent {
  final String path;
  final String chapterId;
  final String topicId;

  const DeleteTopicEvent(
      {required this.path, required this.chapterId, required this.topicId});

  @override
  List<Object?> get props => [chapterId, topicId, path];
}

class FetchChaptersEvent extends LibraryEvent {
  final String path;
  FetchChaptersEvent(this.path);
}

class DeleteChapterEvent extends LibraryEvent {
  final String path;
  final String chapterId;
  DeleteChapterEvent(this.chapterId, this.path);
}

class UpdateChapterEvent extends LibraryEvent {
  final String path;
  final ChapterModel chapter;
  UpdateChapterEvent(this.chapter, this.path);
}
