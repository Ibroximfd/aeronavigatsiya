import 'dart:io';
import 'package:aeronavigatsiya/presentation/teachers/bloc/image_picker/bloc/image_picker_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/image_picker/bloc/image_picker_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImageInitial()) {
    on<PickImage>(_onPickImage);
  }

  Future<void> _onPickImage(
    PickImage event,
    Emitter<ImagePickerState> emit,
  ) async {
    emit(ImagePicking());
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked == null) {
        emit(ImageFailure('Rasm tanlanmadi.'));
        return;
      }

      final file = File(picked.path);
      final fileName = const Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child(
        'topic_covers/$fileName',
      );
      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      emit(ImageLoaded(url));
    } catch (e) {
      emit(ImageFailure('Rasm yuklashda xatolik: $e'));
    }
  }
}
