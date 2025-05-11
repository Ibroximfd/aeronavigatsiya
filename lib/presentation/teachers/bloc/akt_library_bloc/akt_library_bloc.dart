import 'dart:io';

import 'package:aviatoruz/core/config/network_constants.dart';
import 'package:aviatoruz/data/datasource/library_repository.dart';
import 'package:aviatoruz/data/entity/chapter_model.dart';
import 'package:aviatoruz/presentation/teachers/bloc/akt_library_bloc/akt_library_event.dart';
import 'package:aviatoruz/presentation/teachers/bloc/akt_library_bloc/akt_library_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AKTLibraryBloc extends Bloc<AKTLibraryEvent, AKTLibraryState> {
  final LibraryRepository repository = LibraryRepository();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AKTLibraryBloc() : super(AKTLibraryInitial()) {
    on<AKTCreateChapterEvent>(_onCreateChapter);
    on<AKTPickChapterImageEvent>(_onPickChapterImage);
    on<AKTUpdateTopicEvent>(_onUpdateTopic);
    on<AKTDeleteTopicEvent>(_onDeleteTopic);

    on<AKTFetchChaptersEvent>(_onFetchChapters);
    on<AKTDeleteChapterEvent>(_onDeleteChapter);
    on<AKTUpdateChapterEvent>(_onUpdateChapter);
  }
  Future<void> _onCreateChapter(
      AKTCreateChapterEvent event, Emitter<AKTLibraryState> emit) async {
    emit(AKTLibraryLoading());
    try {
      await repository.createChapter(
          event.chapter, NetworkConstants.aktLibrary);
      emit(AKTLibrarySuccess());
    } catch (e) {
      emit(AKTLibraryFailure(e.toString()));
    }
  }

  Future<void> _onPickChapterImage(
      AKTPickChapterImageEvent event, Emitter<AKTLibraryState> emit) async {
    emit(AKTLibraryImagePicking());
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked == null) {
        emit(const AKTLibraryFailure("Rasm tanlanmadi."));
        return;
      }
      final file = File(picked.path);
      final fileName = const Uuid().v4();
      final ref =
          FirebaseStorage.instance.ref().child('akt_chapter_covers/$fileName');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      emit(AKTLibraryImagePicked(url));
    } catch (e) {
      emit(AKTLibraryFailure("Rasm yuklashda xatolik: $e"));
    }
  }

  Future<void> _onUpdateTopic(
      AKTUpdateTopicEvent event, Emitter<AKTLibraryState> emit) async {
    emit(AKTLibraryLoading());
    try {
      await FirebaseFirestore.instance
          .collection(NetworkConstants.aktLibrary)
          .doc(event.chapterId)
          .collection('topics')
          .doc(event.topic.id)
          .update(event.topic.toJson());
      emit(AKTLibrarySuccess());
    } catch (e) {
      emit(AKTLibraryFailure(e.toString()));
    }
  }

  Future<void> _onDeleteTopic(
      AKTDeleteTopicEvent event, Emitter<AKTLibraryState> emit) async {
    emit(AKTLibraryLoading());
    try {
      final topicDoc = await firestore
          .collection(NetworkConstants.library)
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
          .collection(NetworkConstants.aktLibrary)
          .doc(event.chapterId)
          .collection('topics')
          .doc(event.topicId)
          .delete();

      emit(AKTLibrarySuccess());
    } catch (e) {
      emit(AKTLibraryFailure('Failed to delete topic: $e'));
    }
  }

  Future<void> _onFetchChapters(
      AKTFetchChaptersEvent event, Emitter<AKTLibraryState> emit) async {
    try {
      emit(AKTLibraryLoading());
      final snapshot =
          await firestore.collection(NetworkConstants.aktLibrary).get();
      final chapters = snapshot.docs
          .map((doc) => ChapterModel.fromJson(doc.data()))
          .toList();
      emit(AKTLibraryLoaded(chapters));
    } catch (e) {
      emit(AKTLibraryError('Failed to fetch chapters: $e'));
    }
  }

  Future<void> _onDeleteChapter(
      AKTDeleteChapterEvent event, Emitter<AKTLibraryState> emit) async {
    emit(AKTLibraryLoading());
    try {
      final chapterDoc = await firestore
          .collection(NetworkConstants.aktLibrary)
          .doc(event.chapterId)
          .get();

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
      await firestore
          .collection(NetworkConstants.library)
          .doc(event.chapterId)
          .delete();

      // Chapter o'chirilgandan keyin listni qayta yuklash
      add(AKTFetchChaptersEvent());
    } catch (e) {
      emit(AKTLibraryFailure('Failed to delete chapter: $e'));
    }
  }

  Future<void> _onUpdateChapter(
      AKTUpdateChapterEvent event, Emitter<AKTLibraryState> emit) async {
    emit(AKTLibraryLoading());
    try {
      await firestore
          .collection(NetworkConstants.aktLibrary)
          .doc(event.chapter.id)
          .update(event.chapter.toMap());
      add(AKTFetchChaptersEvent());
    } catch (e) {
      emit(AKTLibraryFailure('Failed to update chapter: $e'));
    }
  }
}
