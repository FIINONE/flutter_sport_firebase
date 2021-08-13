import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sport_firebase/model/user.dart';

class AuthServise {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool get isSignIn => _auth.currentUser != null;

  Stream<UserModel?> get currentUser {
    return _auth.authStateChanges().map(
        (User? user) => user != null ? UserModel.fromFirebase(user) : null);
  }

  Future<UserModel?> signInEmailPasssword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      return UserModel.fromFirebase(user);
      // } on FirebaseException catch (e) {
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<UserModel?> registerEmailPasssword(
      String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      return UserModel.fromFirebase(user);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
