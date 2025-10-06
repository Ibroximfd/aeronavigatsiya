part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object?> get props => [];
}

class LoadVideos extends VideosEvent {}

class AddVideo extends VideosEvent {
  final VideoModel video;
  const AddVideo(this.video);

  @override
  List<Object?> get props => [video];
}

class UpdateVideo extends VideosEvent {
  final VideoModel video;
  const UpdateVideo(this.video);

  @override
  List<Object?> get props => [video];
}

class DeleteVideo extends VideosEvent {
  final String id;
  const DeleteVideo(this.id);

  @override
  List<Object?> get props => [id];
}
