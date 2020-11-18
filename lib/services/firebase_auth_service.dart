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
      throw 'Error to sign in anonymously, please, try again later';
    }
  }
}
