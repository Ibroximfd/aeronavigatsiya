import 'package:aeronavigatsiya/core/config/network_constants.dart';
import 'package:aeronavigatsiya/data/datasource/library_repository.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/create_topic/bloc/createtopic_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/create_topic/bloc/createtopic_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTopicBloc extends Bloc<CreateTopicEvent, CreateTopicState> {
  final TextEditingController titleController = TextEditingController();
  final LibraryRepository repository = LibraryRepository();

  CreateTopicBloc() : super(CreateInitial()) {
    on<CreateTopic>(_onCreateTopic);
  }

  Future<void> _onCreateTopic(
    CreateTopic event,
    Emitter<CreateTopicState> emit,
  ) async {
    emit(CreateSubmitting());
    try {
      await repository.createTopic(
        event.chapterId,
        event.topic,
        NetworkConstants.library,
      );
      emit(CreateSuccess());
    } catch (e) {
      emit(CreateFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    return super.close();
  }
}
