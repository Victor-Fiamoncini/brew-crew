import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signInAnonymously() async {
    try {
      final response = await _firebaseAuth.signInAnonymously();

      final user = response.user;

      return user;
    } catch (e) {
      throw 'Error to sign in anonymously, please, try again later';
    }
  }
}
