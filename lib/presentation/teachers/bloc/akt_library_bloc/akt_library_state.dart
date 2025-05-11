import 'package:aviatoruz/data/entity/chapter_model.dart';
import 'package:equatable/equatable.dart';

abstract class AKTLibraryState extends Equatable {
  const AKTLibraryState();

  @override
  List<Object?> get props => [];
}

class AKTLibraryInitial extends AKTLibraryState {}

class AKTLibraryLoading extends AKTLibraryState {}

class AKTLibrarySuccess extends AKTLibraryState {}

class AKTLibraryFailure extends AKTLibraryState {
  final String message;

  const AKTLibraryFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AKTLibraryImagePicking extends AKTLibraryState {}

class AKTLibraryImagePicked extends AKTLibraryState {
  final String imageUrl;

  const AKTLibraryImagePicked(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class AKTLibraryLoaded extends AKTLibraryState {
  final List<ChapterModel> chapters;
  AKTLibraryLoaded(this.chapters);
}

class AKTLibraryError extends AKTLibraryState {
  final String error;
  AKTLibraryError(this.error);
}

class AKTLibraryActionSuccess extends AKTLibraryState {
  final String message;
  AKTLibraryActionSuccess(this.message);
}
