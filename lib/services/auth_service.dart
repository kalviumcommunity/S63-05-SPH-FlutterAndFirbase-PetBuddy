import 'package:firebase_auth/firebase_auth.dart';

/// A small wrapper around `FirebaseAuth` to keep screens simple.
class AuthService {
  AuthService({FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  /// Authentication flow (Email & Password):
  /// - `signUp` creates a new user in Firebase Auth.
  /// - `signIn` signs an existing user in.
  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Sign up failed.');
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Sign in failed.');
    }
  }

  /// Signs the current user out.
  Future<void> logout() async {
    await _auth.signOut();
  }
}

