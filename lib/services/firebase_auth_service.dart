import 'package:brew_crew/services/firebase_database_service.dart';
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

      final firebaseDatabaseService = FirebaseDatabaseService(uid: user.uid);

      await firebaseDatabaseService.updateUserBrewData(
        '0',
        'new crew member',
        100,
      );

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
