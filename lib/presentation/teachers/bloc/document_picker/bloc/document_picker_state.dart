class DocumentPickerState {}

class DocumentInitial extends DocumentPickerState {}

class DocumentPicking extends DocumentPickerState {}

class DocumentLoaded extends DocumentPickerState {
  final String documentUrl;
  final String fileType; // 'pdf', 'doc', 'docx'

  DocumentLoaded(this.documentUrl, this.fileType);
}

class DocumentFailure extends DocumentPickerState {
  final String message;

  DocumentFailure(this.message);
}
