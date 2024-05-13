import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // instance of auth and FirebaseStroe
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore store = FirebaseFirestore.instance;
  //instace of google

  //current user

  User? getCurrentUser() {
    return auth.currentUser;
  }

  static bool isLoginIn = false;

  //sign up

  //sign in
  static Future<User?> loginUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      //save info
      store.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        },
      );
      return userCredential.user;
    } catch (e) {
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Something is wrong")));
      });
    }
    return null;
  }

  //sign in with google

  //delete

  //log out
  static Future<void> logOut() async {
    await auth.signOut();
  }
}
