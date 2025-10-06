import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';

abstract class EditTopicEvent extends Equatable {
  const EditTopicEvent();

  @override
  List<Object?> get props => [];
}

class ChangeTitleEvent extends EditTopicEvent {
  final String title;
  const ChangeTitleEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class ChangeContentEvent extends EditTopicEvent {
  final Document content;
  const ChangeContentEvent(this.content);

  @override
  List<Object?> get props => [content];
}

class PickNewImageEvent extends EditTopicEvent {}

class SubmitUpdateEvent extends EditTopicEvent {
  final String chapterId;
  const SubmitUpdateEvent({required this.chapterId});

  @override
  List<Object?> get props => [chapterId];
}
