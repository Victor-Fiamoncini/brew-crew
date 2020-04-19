import 'package:brew_crew/pages/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
	final FirebaseAuth _auth = FirebaseAuth.instance;

	User _userFromFirebaseUser(FirebaseUser user) {
		return user != null ? User(uid: user.uid) : null;
	}

	Future<User> signInAnon() async {
		try {
			AuthResult res = await _auth.signInAnonymously();
			FirebaseUser user = res.user;

			return _userFromFirebaseUser(user);
		} catch (err) {
			print(err.toString());
			return null;
		}
	}
}
