import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
	final FirebaseAuth _auth = FirebaseAuth.instance;

	User _createUserFromFirebaseUser(FirebaseUser user) {
		return user != null ? User(uid: user.uid) : null;
	}

	Stream<User> get user {
		return _auth.onAuthStateChanged.map((FirebaseUser user) => _createUserFromFirebaseUser(user));
	}

	Future<User> signUpWithEmailAndPassword(String email, String password) async {
		try {
			AuthResult res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			FirebaseUser user = res.user;

			return _createUserFromFirebaseUser(user);
		} catch (err) {
			print(err.toString());
			return null;
		}
	}

	Future<User> signInWithEmailAndPassword(String email, String password) async {
		try {
			AuthResult res = await _auth.signInWithEmailAndPassword(email: email, password: password);
			FirebaseUser user = res.user;

			return _createUserFromFirebaseUser(user);
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
