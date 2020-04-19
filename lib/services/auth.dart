import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
	final FirebaseAuth _auth = FirebaseAuth.instance;

	User _userFromFirebaseUser(FirebaseUser user) {
		return user != null ? User(uid: user.uid) : null;
	}

	Stream<User> get user {
		return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
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

	Future signOut() async {
		try {
			return await _auth.signOut();
		} catch (err) {
			print(err.toString());
		}
	}
}
