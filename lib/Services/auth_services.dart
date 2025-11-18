import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Registers a new user using email & password.
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      return _handleError(e);
    } catch (e) {
      return "Unexpected error, please try again.";
    }
  }

  /// Logs in the user using email & password.
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      return _handleError(e);
    } catch (e) {
      return "Unexpected error, please try again.";
    }
  }

  /// Logs out the current user.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Returns current logged-in user
  User? get currentUser => _auth.currentUser;

  /// Returns error message corresponding to the error code.
  String _handleError(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return "Please enter a valid email address.";
      case "user-disabled":
        return "This account has been disabled.";
      case "user-not-found":
        return "No account found with this email.";
      case "wrong-password":
        return "Incorrect password, please try again.";
      case "email-already-in-use":
        return "This email is already registered.";
      case "weak-password":
        return "Password is too weak. Try a stronger one.";
      case "too-many-requests":
        return "Too many attempts. Please wait a moment.";
      case "operation-not-allowed":
        return "Email & password login is currently disabled.";
      default:
        return "Something went wrong. Please try again.";
    }
  }
}
