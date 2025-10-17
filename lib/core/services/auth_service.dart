// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// === REGISTER ===
  static Future<User?> registerUser({
    required String name,
    required String email,
    required String password,
    required bool isTeacher,
  }) async {
    try {
      // Yangi foydalanuvchi yaratish
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user == null) throw "Foydalanuvchi yaratilmagan";

      // Firestore’da foydalanuvchi ma’lumotini saqlaymiz
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'role': isTeacher ? 'teacher_pending' : 'student',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Firebase profilda ham displayName sifatida saqlash
      await user.updateDisplayName(name);

      // Agar teacher bo‘lsa, email tasdiqlash havolasi yuboriladi
      if (isTeacher) {
        await user.sendEmailVerification();
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Ro‘yxatdan o‘tishda xatolik yuz berdi";
    } catch (e) {
      throw e.toString();
    }
  }

  /// === LOGIN ===
  static Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) throw "Foydalanuvchi topilmadi";

      // Firestore’dan role ni olish
      final role = await getUserRole(user.uid);

      // Teacher hali tasdiqlanmagan bo‘lsa tizimga kiritmaymiz
      if (role == 'teacher_pending') {
        await _auth.signOut();
        throw "Admin tasdiqlamagani uchun tizimga kira olmaysiz.";
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Kirishda xatolik yuz berdi";
    } catch (e) {
      throw e.toString();
    }
  }

  /// === GET USER ROLE ===
  static Future<String> getUserRole(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) throw "Foydalanuvchi topilmadi";

      final data = doc.data();
      if (data == null || !data.containsKey('role')) {
        throw "Role ma’lumoti topilmadi";
      }

      return data['role'] as String;
    } catch (e) {
      throw e.toString();
    }
  }

  /// === DELETE ACCOUNT ===
  static Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
      }
    } catch (e) {
      throw "Akkountni o‘chirishda xatolik: $e";
    }
  }

  static Future<void> resetPassword(String email) async {
    try {
      if (email.isEmpty) {
        throw "Iltimos, emailingizni kiriting.";
      }

      // Email formatini tekshirish (oddiy regex bilan)
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(email)) {
        throw "Noto‘g‘ri email manzil kiritildi.";
      }

      print("Sending password reset email to: $email");
      await _auth.sendPasswordResetEmail(email: email);
      print("Password reset email sent successfully");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code} - ${e.message}");
      switch (e.code) {
        case 'invalid-email':
          throw "Email manzilingiz noto‘g‘ri formatda.";
        case 'user-not-found':
          throw "Bu email bilan foydalanuvchi topilmadi.";
        case 'missing-email':
          throw "Email manzili kiritilmadi.";
        default:
          throw "Parolni tiklashda xatolik yuz berdi. Iltimos, qayta urinib ko‘ring.";
      }
    } catch (e) {
      print("Error: $e");
      throw e.toString();
    }
  }

  /// === LOG OUT ===
  static Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw "Chiqishda xatolik: $e";
    }
  }

  /// === GET CURRENT USER ===
  static User? get currentUser => _auth.currentUser;
}
