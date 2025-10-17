import 'package:aeronavigatsiya/core/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogOutEvent>(_onLogOutEvent);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<DeleteAccountEvent>(_onDeleteAccountEvent);
  }

  // === LOGIN ===
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await AuthService.loginUser(
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        final role = await AuthService.getUserRole(user.uid);
        emit(AuthSuccess(role));
      } else {
        emit(const AuthFailure("Foydalanuvchi topilmadi"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // === REGISTER ===
  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await AuthService.registerUser(
        name: event.name,
        email: event.email,
        password: event.password,
        isTeacher: event.isTeacher,
      );

      if (user != null) {
        if (event.isTeacher) {
          emit(
            const AuthRegistered(
              "Email tasdiqlash havolasi yuborildi. Iltimos, pochtangizni tekshiring. Admin tasdiqlamaguncha kira olmaysiz.",
            ),
          );
        } else {
          emit(const AuthRegistered("Student akkauntingiz yaratildi."));
        }
      } else {
        emit(const AuthFailure("Ro‘yxatdan o‘tishda xatolik"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // === LOGOUT ===
  Future<void> _onLogOutEvent(
    LogOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await AuthService.logOut();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure("Chiqishda xatolik: $e"));
    }
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await AuthService.resetPassword(event.email);
      emit(
        const AuthPasswordReset(
          "Parolni tiklash havolasi emailingizga yuborildi.",
        ),
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}

// === DELETE ACCOUNT ===
Future<void> _onDeleteAccountEvent(
  DeleteAccountEvent event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    await AuthService.deleteAccount();
    emit(AuthDeleted());
  } catch (e) {
    emit(AuthFailure("Akkountni o‘chirishda xatolik: $e"));
  }
}
