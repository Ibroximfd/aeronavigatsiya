import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckPrivacyAccepted>(_onCheckPrivacyAccepted);
  }

  Future<void> _onCheckPrivacyAccepted(
      CheckPrivacyAccepted event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    await Future.delayed(const Duration(milliseconds: 2000));

    final prefs = await SharedPreferences.getInstance();
    final hasAcceptedPrivacy = prefs.getBool('privacyAccepted') ?? false;

    if (hasAcceptedPrivacy) {
      emit(NavigateToHome());
    } else {
      emit(NavigateToPrivacy());
    }
  }
}
