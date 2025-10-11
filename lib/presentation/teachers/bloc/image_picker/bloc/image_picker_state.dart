class ImagePickerState {}

class ImageInitial extends ImagePickerState {}

class ImagePicking extends ImagePickerState {}

class ImageLoaded extends ImagePickerState {
  final String imageUrl;

  ImageLoaded(this.imageUrl);
}

class ImageFailure extends ImagePickerState {
  final String message;

  ImageFailure(this.message);
}
