import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/firebase_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        'new crew member',
        100,
      );

      return _serializeUserFromFirebase(user);
    } catch (e) {
      throw e.message;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw e.message;
    }
  }
}
