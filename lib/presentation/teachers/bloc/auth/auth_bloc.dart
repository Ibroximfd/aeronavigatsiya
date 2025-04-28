import 'package:aviatoruz/core/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);

    on<LogOutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await AuthService.logOut();
        emit(AuthLoggedOut());
      } catch (e) {
        emit(AuthFailure('Chiqishda xatolik yuz berdi: ${e.toString()}'));
      }
    });
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await AuthService.loginUser(
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("User not found"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
