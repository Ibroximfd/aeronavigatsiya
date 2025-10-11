import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:aeronavigatsiya/presentation/teachers/bloc/document_picker/bloc/document_picker_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/document_picker/bloc/document_picker_state.dart';
import 'package:aspose_words_cloud/aspose_words_cloud.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class DocumentPickerBloc
    extends Bloc<DocumentPickerEvent, DocumentPickerState> {
  // Aspose Words Cloud configuration - replace with your credentials
  final WordsApi wordsApi = WordsApi(
    Configuration(
      'e754b15c-8f98-41e4-8ff6-91768fc64b02',
      '44d08bb2380359a9ed81514958887697',
    ),
  );

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

      // Validate file size (e.g., max 10MB)
      if (bytes.length > 10 * 1024 * 1024) {
        emit(DocumentFailure('Hujjat hajmi 10MB dan katta bo‘lmasligi kerak.'));
        return;
      }

      // Upload original document to Firebase Storage
      final fileName = const Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child(
        'topic_documents/$fileName',
      );
      await ref.putFile(file);
      final documentUrl = await ref.getDownloadURL();

      // Convert document to HTML using Aspose.Words Cloud
      final convertRequest = ConvertDocumentRequest(
        ByteData.view(bytes.buffer),
        'html',
      );
      final convertResponse = await wordsApi.convertDocument(convertRequest);

      // Convert ByteData to String (HTML content)
      final htmlContent = utf8.decode(convertResponse.buffer.asUint8List());

      emit(DocumentLoaded(htmlContent, documentUrl));
    } catch (e) {
      emit(DocumentFailure('Hujjat yuklash va konvertatsiyada xatolik: $e'));
    }
  }
}
