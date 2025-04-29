import 'dart:io';

import 'package:aviatoruz/data/datasource/library_repository.dart';
import 'package:aviatoruz/data/entity/chapter_model.dart';
import 'package:aviatoruz/data/entity/topic_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final LibraryRepository repository = LibraryRepository();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  LibraryBloc() : super(LibraryInitial()) {
    on<CreateChapterEvent>(_onCreateChapter);
    on<PickChapterImageEvent>(_onPickChapterImage);
    on<UpdateTopicEvent>(_onUpdateTopic);
    on<DeleteTopicEvent>(_onDeleteTopic);

    on<FetchChaptersEvent>(_onFetchChapters);
    on<DeleteChapterEvent>(_onDeleteChapter);
    on<UpdateChapterEvent>(_onUpdateChapter);
  }
  Future<void> _onCreateChapter(
      CreateChapterEvent event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    try {
      await repository.createChapter(event.chapter);
      emit(LibrarySuccess());
    } catch (e) {
      emit(LibraryFailure(e.toString()));
    }
  }

  Future<void> _onPickChapterImage(
      PickChapterImageEvent event, Emitter<LibraryState> emit) async {
    emit(LibraryImagePicking());
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked == null) {
        emit(const LibraryFailure("Rasm tanlanmadi."));
        return;
      }
      final file = File(picked.path);
      final fileName = const Uuid().v4();
      final ref =
          FirebaseStorage.instance.ref().child('chapter_covers/$fileName');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      emit(LibraryImagePicked(url));
    } catch (e) {
      emit(LibraryFailure("Rasm yuklashda xatolik: $e"));
    }
  }

  Future<void> _onUpdateTopic(
      UpdateTopicEvent event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    try {
      await FirebaseFirestore.instance
          .collection('library')
          .doc(event.chapterId)
          .collection('topics')
          .doc(event.topic.id)
          .update(event.topic.toJson());
      emit(LibrarySuccess());
    } catch (e) {
      emit(LibraryFailure(e.toString()));
    }
  }

  Future<void> _onDeleteTopic(
      DeleteTopicEvent event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    try {
      final topicDoc = await firestore
          .collection('library')
          .doc(event.chapterId)
          .collection('topics')
          .doc(event.topicId)
          .get();

      if (topicDoc.exists) {
        final data = topicDoc.data();
        final coverImageUrl = data?['coverImageUrl'];

        // Storage dagi rasmni o'chirish
        if (coverImageUrl != null &&
            coverImageUrl is String &&
            coverImageUrl.isNotEmpty) {
          final ref = FirebaseStorage.instance.refFromURL(coverImageUrl);
          await ref.delete();
        }
      }

      // Firestore dan topicni o'chirish
      await firestore
          .collection('library')
          .doc(event.chapterId)
          .collection('topics')
          .doc(event.topicId)
          .delete();

      emit(LibrarySuccess());
    } catch (e) {
      emit(LibraryFailure('Failed to delete topic: $e'));
    }
  }

  Future<void> _onFetchChapters(
      FetchChaptersEvent event, Emitter<LibraryState> emit) async {
    try {
      emit(LibraryLoading());
      final snapshot = await firestore.collection('library').get();
      final chapters = snapshot.docs
          .map((doc) => ChapterModel.fromJson(doc.data()))
          .toList();
      emit(LibraryLoaded(chapters));
    } catch (e) {
      emit(LibraryError('Failed to fetch chapters: $e'));
    }
  }

  Future<void> _onDeleteChapter(
      DeleteChapterEvent event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    try {
      final chapterDoc =
          await firestore.collection('library').doc(event.chapterId).get();

      if (chapterDoc.exists) {
        final data = chapterDoc.data();
        final coverImageUrl = data?['coverImageUrl'];

        // Storage dagi rasmni o'chirish
        if (coverImageUrl != null &&
            coverImageUrl is String &&
            coverImageUrl.isNotEmpty) {
          final ref = FirebaseStorage.instance.refFromURL(coverImageUrl);
          await ref.delete();
        }
      }

      // Firestore dan chapterni o'chirish
      await firestore.collection('library').doc(event.chapterId).delete();

      // Chapter o'chirilgandan keyin listni qayta yuklash
      add(FetchChaptersEvent());
    } catch (e) {
      emit(LibraryFailure('Failed to delete chapter: $e'));
    }
  }

  Future<void> _onUpdateChapter(
      UpdateChapterEvent event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    try {
      await firestore
          .collection('library')
          .doc(event.chapter.id)
          .update(event.chapter.toMap());
      add(FetchChaptersEvent());
    } catch (e) {
      emit(LibraryFailure('Failed to update chapter: $e'));
    }
  }
}
