import 'dart:convert';

import 'package:aviatoruz/presentation/teachers/bloc/topic_detail/bloc/topicdetail_event.dart';
import 'package:aviatoruz/presentation/teachers/bloc/topic_detail/bloc/topicdetail_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TopicDetailBloc extends Bloc<TopicDetailEvent, TopicDetailState> {
  TopicDetailBloc() : super(TopicDetailLoading()) {
    on<LoadTopicDetail>(_onLoadTopicDetail);
  }

  void _onLoadTopicDetail(
    LoadTopicDetail event,
    Emitter<TopicDetailState> emit,
  ) {
    try {
      final contentJson = jsonDecode(event.topic.content);
      final controller = QuillController(
        document: Document.fromJson(contentJson),
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true,
      );

      emit(TopicDetailLoaded(
        controller: controller,
        topic: event.topic,
      ));
    } catch (e) {
      emit(TopicDetailError(message: 'Kontentni yuklashda xatolik: $e'));
    }
  }
}
