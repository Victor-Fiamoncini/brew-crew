import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
	@override
	_SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
	final AuthService _authService = AuthService();

	void _onTap() async {
		dynamic res = await _authService.signInAnon();

		if (res == null) {
			print('Error signing in');
		} else {
			print('signed in');
			print(res.uid);
		}

		return null;
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.brown[100],
			appBar: AppBar(
				backgroundColor: Colors.brown[300],
				elevation: 0.0,
				title: Text('Sign in'),
			),
			body: Container(
				padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
				child: RaisedButton(
					child: Text('Sign in anon'),
					onPressed: _onTap,
				),
			),
		);
	}
}
