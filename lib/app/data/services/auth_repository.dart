import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign up with email, password and name
  Future<User?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await userCred.user?.updateDisplayName(name);
      // await userCred.user?.reload();

      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Sign in with email and password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Get currently logged-in user
  User? get currentUser => _auth.currentUser;
}
