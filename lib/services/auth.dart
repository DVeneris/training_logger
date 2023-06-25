import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:training_tracker/services/user-service.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      //  await UserService().createUser("username");
      //
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      //handle
    }
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
