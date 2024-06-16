import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // instance of auth and FirebaseStroe
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore store = FirebaseFirestore.instance;
  //instace of google

  //current user

  Future<User?> signInAnonymously() async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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

      User? user = userCredential.user;
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
      }
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

  static signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn')!;
    isLoginIn = await prefs.setBool('isLoggedIn', !isLoggedIn);
    return isLoginIn;
  }

  //log out
  static Future<void> logOut() async {
    await auth.signOut();
  }

  //check initState

  static Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoginIn = prefs.getBool('isLoggedIn')!;
    return isLoginIn;
  }
}
