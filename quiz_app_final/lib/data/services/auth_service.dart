import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
    required Function(int) onNavigateToPage,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser != null) {
        onNavigateToPage(2); // Redirige vers la page profil
      }
    } catch (e) {
      _showErrorSnackBar(context, "Erreur de connexion : ${e.toString()}");
    }
  }

  Future<void> createUserWithEmail({
    required String email,
    required String password,
    required BuildContext context,
    required Function(int) onNavigateToPage,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser != null) {
        onNavigateToPage(2); // Redirige vers la page profil
      }
    } catch (e) {
      _showErrorSnackBar(context, "Erreur de création de compte : ${e.toString()}");
    }
  }

  Future<UserCredential?> signInWithGoogle({
    required BuildContext context,
    required Function(int) onNavigateToPage,
  }) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (_auth.currentUser != null) {
        onNavigateToPage(2);
      }
      return userCredential;
    } catch (e) {
      _showErrorSnackBar(context, "Erreur de connexion avec Google : ${e.toString()}");
    }
    return null;
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
