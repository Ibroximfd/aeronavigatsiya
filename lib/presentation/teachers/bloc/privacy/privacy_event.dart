abstract class PrivacyEvent {}

class TogglePrivacyAccepted extends PrivacyEvent {
  final bool value;
  TogglePrivacyAccepted(this.value);
}

class SubmitPrivacyPolicy extends PrivacyEvent {}
