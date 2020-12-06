import 'package:brew_crew/app/models/user.dart';
import 'package:brew_crew/app/services/firebase_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuthService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  User _serializeUserFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  Stream<User> get authStateChanges {
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
    } on AuthException catch (e) {
      throw e.message;
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
        user.displayName ?? user.email,
        100,
      );

      return _serializeUserFromFirebase(user);
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on AuthException catch (e) {
      throw e.message;
    }
  }
}
