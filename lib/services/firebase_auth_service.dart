import 'package:firebase_auth/firebase_auth.dart';

import 'package:brew_crew/models/user.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  User _serializeUserFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_serializeUserFromFirebase);
  }

  Future<User> signInAnonymously() async {
    try {
      final response = await _firebaseAuth.signInAnonymously();

      final user = response.user;

      return _serializeUserFromFirebase(user);
    } catch (e) {
      throw 'Error to sign in anonymously, please, try again';
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      return _serializeUserFromFirebase(user);
    } catch (e) {
      throw 'Error to sign in with email and password, please, try again';
    }
  }

  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      return _serializeUserFromFirebase(user);
    } catch (e) {
      throw 'Error to sign up with email and password, please, try again';
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw 'Error to sign out, please, try again';
    }
  }
}
