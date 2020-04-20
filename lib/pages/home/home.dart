import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/pages/home/brew_list.dart';
import 'package:brew_crew/pages/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
	final AuthService _auth = AuthService();

	Future _signOut() async => await _auth.signOut();

	@override
	Widget build(BuildContext context) {
		void _showSettingsPanel() {
			showModalBottomSheet(context: context, builder: (BuildContext context) => Container(
				padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
				color: Colors.brown[300],
				child: SettingsForm(),
			));
		}

		return StreamProvider<List<Brew>>.value(
			value: DatabaseService().brews,
			child: Scaffold(
				backgroundColor: Colors.brown[100],
				appBar: AppBar(
					title: Text('Brew Crew'),
					backgroundColor: Colors.brown[300],
					elevation: 0.0,
					actions: <Widget>[
						FlatButton.icon(
							icon: Icon(Icons.settings, color: Colors.white),
							label: Text('Preferences', style: TextStyle(color: Colors.white)),
							onPressed: _showSettingsPanel,
						),
						FlatButton.icon(
							icon: Icon(Icons.person, color: Colors.white),
							label: Text('Logout', style: TextStyle(color: Colors.white)),
							onPressed: _signOut,
						)
					],
				),
				body: BrewList(),
			)
		);
	}
}
