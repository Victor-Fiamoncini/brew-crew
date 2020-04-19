import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
	final AuthService _auth = AuthService();

	Future _signOut() async => await _auth.signOut();

	@override
	Widget build(BuildContext context) {
		final user = Provider.of<User>(context);

		return Scaffold(
			backgroundColor: Colors.brown[100],
			appBar: AppBar(
				title: Text('Brew Crew'),
				backgroundColor: Colors.brown[300],
				elevation: 0.0,
				actions: <Widget>[
					FlatButton.icon(
						icon: Icon(Icons.person, color: Colors.white),
						label: Text('Logout', style: TextStyle(color: Colors.white)),
						onPressed: _signOut,
					)
				],
			),
			body: Container(child: Text(user.uid.toString())),
		);
	}
}
