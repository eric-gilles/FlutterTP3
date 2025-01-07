import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  bool get isLoggedIn => _auth.currentUser != null;

  /// Méthode pour se connecter avec email et mot de passe
  Future<void> signInWithEmail({
    required String email,
    required String password
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Erreur de connexion : ${e.toString()}");
    }
  }

  /// Méthode pour créer un compte avec email et mot de passe
  Future<void> createUserWithEmail({
    required String email,
    required String password
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Erreur de création de compte : ${e.toString()}");
    }
  }

  /// Méthode pour se connecter avec Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      print("Erreur de connexion avec Google : ${e.toString()}");
    }
    return null;
  }

  /// Méthode pour se déconnecter
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Méthode pour envoyer un email de réinitialisation de mot de passe
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
