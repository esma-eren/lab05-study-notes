
import 'package:firebase_auth/firebase_auth.dart';

/// Thrown by AuthRepository with a message you can show to the user.
class AuthFailure implements Exception {
  AuthFailure(this.message);

  final String message;

  @override
  String toString() => 'AuthFailure($message)';
}

/// Part 2: email + password sign-in with Firebase Authentication.
class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(messageFor(e.code));
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(messageFor(e.code));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  static String messageFor(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password must be at least 6 characters.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'Wrong email or password.';
      case 'network-request-failed':
        return 'No connection. Check your network.';
      default:
        return 'Sign-in failed. Please try again.';
    }
  }
}
