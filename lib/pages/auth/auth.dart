import 'package:brew_crew/pages/auth/sign_in.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
	@override
	_AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
	@override
	Widget build(BuildContext context) {
		return Container(
			child: SignIn(),
		);
	}
}
