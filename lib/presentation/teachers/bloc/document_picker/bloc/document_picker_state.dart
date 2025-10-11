class DocumentPickerState {}

class DocumentInitial extends DocumentPickerState {}

class DocumentPicking extends DocumentPickerState {}

class DocumentLoaded extends DocumentPickerState {
  final String htmlContent;
  final String documentUrl;

  DocumentLoaded(this.htmlContent, this.documentUrl);
}

class DocumentFailure extends DocumentPickerState {
  final String message;

  DocumentFailure(this.message);
}
