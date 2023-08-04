import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:training_tracker/services/user-service.dart';

class AuthService {
  Stream<User?> getUserStream() {
    final userStream = FirebaseAuth.instance.authStateChanges();
    return userStream;
  }

  // final userStream = FirebaseAuth.instance.authStateChanges();
  //final user = FirebaseAuth.instance.currentUser;
  // final userService = UserService();
  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      //handle
    }
  }

  User? getUser() {
    var user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);

      //
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      //handle
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
