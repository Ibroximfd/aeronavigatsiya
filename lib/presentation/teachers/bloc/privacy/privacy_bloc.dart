import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'privacy_event.dart';
import 'privacy_state.dart';

class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  PrivacyBloc() : super(PrivacyState.initial()) {
    on<TogglePrivacyAccepted>(_onTogglePrivacyAccepted);
    on<SubmitPrivacyPolicy>(_onSubmitPrivacyPolicy);
  }

  void _onTogglePrivacyAccepted(
      TogglePrivacyAccepted event, Emitter<PrivacyState> emit) {
    emit(state.copyWith(isAccepted: event.value));
  }

  Future<void> _onSubmitPrivacyPolicy(
      SubmitPrivacyPolicy event, Emitter<PrivacyState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('privacyAccepted', true);
    emit(state.copyWith(submitted: true));
  }
}
