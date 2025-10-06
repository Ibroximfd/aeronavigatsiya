import 'package:aeronavigatsiya/data/datasource/videos_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aeronavigatsiya/data/entity/video_model.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  VideosBloc() : super(VideosInitial()) {
    on<LoadVideos>(_onLoadVideos);
    on<AddVideo>(_onAddVideo);
    on<UpdateVideo>(_onUpdateVideo);
    on<DeleteVideo>(_onDeleteVideo);
  }

  final VideoRepository repository = VideoRepository();

  /// 🔹 READ — barcha videolarni olish
  Future<void> _onLoadVideos(
    LoadVideos event,
    Emitter<VideosState> emit,
  ) async {
    emit(VideosLoading());
    try {
      final videos = await repository.getVideos();
      emit(VideosLoaded(videos));
    } catch (e) {
      emit(VideosError(e.toString()));
    }
  }

  /// 🔹 CREATE — yangi video yaratish
  Future<void> _onAddVideo(AddVideo event, Emitter<VideosState> emit) async {
    try {
      await repository.createVideo(event.video);
      add(LoadVideos()); // yangilangan ro‘yxatni yuklaymiz
    } catch (e) {
      emit(VideosError(e.toString()));
    }
  }

  /// 🔹 UPDATE — mavjud videoni yangilash
  Future<void> _onUpdateVideo(
    UpdateVideo event,
    Emitter<VideosState> emit,
  ) async {
    try {
      await repository.updateVideo(event.video);
      add(LoadVideos());
    } catch (e) {
      emit(VideosError(e.toString()));
    }
  }

  /// 🔹 DELETE — video o‘chirish
  Future<void> _onDeleteVideo(
    DeleteVideo event,
    Emitter<VideosState> emit,
  ) async {
    try {
      await repository.deleteVideo(event.id);
      add(LoadVideos());
    } catch (e) {
      emit(VideosError(e.toString()));
    }
  }
}
