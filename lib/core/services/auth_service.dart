import 'package:firebase_auth/firebase_auth.dart';

final class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        await userCredential.user!.reload();
        User? updatedUser = auth.currentUser;
        return updatedUser;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Registration failed";
    }
  }

  static Future<User?> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Login failed";
    }
  }

  static Future<void> deleteAccount() async {
    await auth.currentUser?.delete();
  }

  static Future<void> logOut() async {
    await auth.signOut();
  }

  User? get currentUser => auth.currentUser;
}
