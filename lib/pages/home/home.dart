import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
	final AuthService _auth = AuthService();

	Future _signOut() async => await _auth.signOut();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.brown[50],
			appBar: AppBar(
				title: Text('Brew Crew'),
				backgroundColor: Colors.brown[300],
				elevation: 0.0,
				actions: <Widget>[
					FlatButton.icon(
						icon: Icon(Icons.person),
						label: Text('Logout'),
						onPressed: _signOut,
					)
				],
			),
		);
	}
}
