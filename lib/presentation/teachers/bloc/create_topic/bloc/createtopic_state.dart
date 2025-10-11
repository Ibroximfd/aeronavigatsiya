class CreateTopicState {}

class CreateInitial extends CreateTopicState {}

class CreateSubmitting extends CreateTopicState {}

class CreateSuccess extends CreateTopicState {}

class CreateFailure extends CreateTopicState {
  final String message;

  CreateFailure(this.message);
}
