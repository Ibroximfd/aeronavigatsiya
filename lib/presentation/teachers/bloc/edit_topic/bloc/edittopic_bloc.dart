import 'dart:convert';
import 'dart:io';

import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:aviatoruz/presentation/teachers/bloc/edit_topic/bloc/edittopic_event.dart';
import 'package:aviatoruz/presentation/teachers/bloc/edit_topic/bloc/edittopic_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';

class EditTopicBloc extends Bloc<EditTopicEvent, EditTopicState> {
  EditTopicBloc(TopicModel topic)
      : super(EditTopicState(
          title: topic.title,
          content: Document.fromJson(jsonDecode(topic.content)),
          imageUrl: topic.imageUrl,
          topic: topic,
        )) {
    on<ChangeTitleEvent>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<ChangeContentEvent>((event, emit) {
      emit(state.copyWith(content: event.content));
    });

    on<PickNewImageEvent>(_onPickNewImage);

    on<SubmitUpdateEvent>(_onSubmitUpdate);
  }

  Future<void> _onPickNewImage(
      PickNewImageEvent event, Emitter<EditTopicState> emit) async {
    emit(state.copyWith(isLoadingImage: true));
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        final file = File(picked.path);
        final ref = FirebaseStorage.instance.ref().child(
            'topic_covers/${state.topic.id}_${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(file);
        final url = await ref.getDownloadURL();
        emit(state.copyWith(imageUrl: url, isLoadingImage: false));
      } else {
        emit(state.copyWith(isLoadingImage: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoadingImage: false));
    }
  }

  Future<void> _onSubmitUpdate(
      SubmitUpdateEvent event, Emitter<EditTopicState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      final updatedTopic = state.topic.copyWith(
        title: state.title,
        imageUrl: state.imageUrl,
        content: jsonEncode(state.content.toDelta().toJson()),
      );

      await FirebaseFirestore.instance
          .collection('library')
          .doc(event.chapterId)
          .collection('topics')
          .doc(updatedTopic.id)
          .update(updatedTopic.toJson());

      emit(state.copyWith(isSubmitting: false, success: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, failureMessage: e.toString()));
    }
  }
}
