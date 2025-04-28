import 'dart:io';

import 'package:aviatoruz/data/datasource/library_repository.dart';
import 'package:aviatoruz/presentation/teachers/bloc/create_topic/bloc/createtopic_event.dart';
import 'package:aviatoruz/presentation/teachers/bloc/create_topic/bloc/createtopic_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateTopicBloc extends Bloc<CreateTopicEvent, CreateTopicState> {
  final TextEditingController titleController = TextEditingController();
  final LibraryRepository repository = LibraryRepository();
  final QuillController quillController = QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );

  CreateTopicBloc() : super(CreateTopicInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<CreateTopic>(_onCreateTopic);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<CreateTopicState> emit,
  ) async {
    emit(CreateTopicImagePicking());
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked == null) {
        emit(const CreateTopicFailure(message: 'Rasm tanlanmadi.'));
        return;
      }

      final file = File(picked.path);
      final fileName = const Uuid().v4();
      final ref =
          FirebaseStorage.instance.ref().child('topic_covers/$fileName');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      emit(CreateTopicImagePicked(imageUrl: url));
    } catch (e) {
      emit(CreateTopicFailure(message: 'Rasm yuklashda xatolik: $e'));
    }
  }

  Future<void> _onCreateTopic(
      CreateTopic event, Emitter<CreateTopicState> emit) async {
    emit(CreateTopicSubmitting());
    try {
      await repository.createTopic(event.chapterId, event.topic);
      emit(CreateTopicSuccess());
    } catch (e) {
      emit(CreateTopicFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    quillController.dispose();
    return super.close();
  }
}
