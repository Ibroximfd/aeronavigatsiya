part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];
}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibrarySuccess extends LibraryState {}

class LibraryFailure extends LibraryState {
  final String message;

  const LibraryFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class LibraryImagePicking extends LibraryState {}

class LibraryImagePicked extends LibraryState {
  final String imageUrl;

  const LibraryImagePicked(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class LibraryLoaded extends LibraryState {
  final List<ChapterModel> chapters;
  LibraryLoaded(this.chapters);
}

class LibraryError extends LibraryState {
  final String error;
  LibraryError(this.error);
}

class LibraryActionSuccess extends LibraryState {
  final String message;
  LibraryActionSuccess(this.message);
}
