import 'package:equatable/equatable.dart';

abstract class CreateTopicState extends Equatable {
  const CreateTopicState();

  @override
  List<Object?> get props => [];
}

class CreateTopicInitial extends CreateTopicState {}

class CreateTopicImagePicking extends CreateTopicState {}

class CreateTopicImagePicked extends CreateTopicState {
  final String imageUrl;

  const CreateTopicImagePicked({required this.imageUrl});

  @override
  List<Object?> get props => [imageUrl];
}

class CreateTopicSubmitting extends CreateTopicState {}

class CreateTopicSuccess extends CreateTopicState {}

class CreateTopicFailure extends CreateTopicState {
  final String message;

  const CreateTopicFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
