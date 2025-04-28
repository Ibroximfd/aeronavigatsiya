class PrivacyState {
  final bool isAccepted;
  final bool submitted;

  PrivacyState({required this.isAccepted, required this.submitted});

  factory PrivacyState.initial() =>
      PrivacyState(isAccepted: false, submitted: false);

  PrivacyState copyWith({bool? isAccepted, bool? submitted}) {
    return PrivacyState(
      isAccepted: isAccepted ?? this.isAccepted,
      submitted: submitted ?? this.submitted,
    );
  }
}
