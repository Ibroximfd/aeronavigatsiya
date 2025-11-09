import 'dart:io';
import 'package:aeronavigatsiya/presentation/teachers/bloc/document_picker/bloc/document_picker_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/document_picker/bloc/document_picker_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class DocumentPickerBloc
    extends Bloc<DocumentPickerEvent, DocumentPickerState> {
  DocumentPickerBloc() : super(DocumentInitial()) {
    on<PickDocument>(_onPickDocument);
  }

  Future<void> _onPickDocument(
    PickDocument event,
    Emitter<DocumentPickerState> emit,
  ) async {
    emit(DocumentPicking());
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result == null || result.files.isEmpty) {
        emit(DocumentFailure('Hujjat tanlanmadi.'));
        return;
      }

      final filePath = result.files.single.path!;
      final file = File(filePath);
      final bytes = await file.readAsBytes();

      // File hajmini tekshirish (maks 10MB)
      if (bytes.length > 10 * 1024 * 1024) {
        emit(DocumentFailure("Hujjat hajmi 10MB dan katta bo'lmasligi kerak."));
        return;
      }

      // File extension'ni aniqlash
      final extension = result.files.single.extension?.toLowerCase() ?? 'pdf';

      // Firebase Storage'ga yuklash
      final fileName = const Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child(
        'topic_documents/$fileName.$extension',
      );

      await ref.putFile(file);
      final documentUrl = await ref.getDownloadURL();

      emit(DocumentLoaded(documentUrl, extension));
    } catch (e) {
      emit(DocumentFailure('Hujjat yuklashda xatolik: $e'));
    }
  }
}
