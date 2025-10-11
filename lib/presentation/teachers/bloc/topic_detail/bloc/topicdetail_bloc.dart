import 'package:aeronavigatsiya/presentation/teachers/bloc/topic_detail/bloc/topicdetail_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/topic_detail/bloc/topicdetail_state.dart';
import 'package:bloc/bloc.dart';

class TopicDetailBloc extends Bloc<TopicDetailEvent, TopicDetailState> {
  TopicDetailBloc() : super(TopicDetailLoading()) {
    on<LoadTopicDetail>(_onLoadTopicDetail);
  }

  Future<void> _onLoadTopicDetail(
    LoadTopicDetail event,
    Emitter<TopicDetailState> emit,
  ) async {
    emit(TopicDetailLoading());
    try {
      // HTML matnni to‘g‘ridan-to‘g‘ri yuboramiz
      emit(
        TopicDetailLoadedHtml(
          contentHtml: event.topic.content,
          topic: event.topic,
        ),
      );
    } catch (e) {
      emit(TopicDetailError(message: 'Kontentni yuklashda xatolik: $e'));
    }
  }
}
